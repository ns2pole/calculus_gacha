# frozen_string_literal: true
# App Store Connect に AIチューター Pass（消耗型 IAP）を作成する。
# 使い方: bundle exec ruby scripts/create_ios_ai_tutor_pass_iap.rb
#
# 環境変数:
#   ASC_KEY_ID      (default: ATBD5UGJTG)
#   ASC_ISSUER_ID   (default: codemagic.yaml と同じ)
#   ASC_P8_PATH     (default: ~/.appstoreconnect/private_keys/AuthKey_<KEY_ID>.p8)
#   ASC_PRIVATE_KEY (.p8 の全文。Codemagic の APP_STORE_CONNECT_PRIVATE_KEY と同じ)

require "json"
require "jwt"
require "net/http"
require "openssl"
require "uri"

BUNDLE_ID = "com.joymath"
PRODUCT_ID = "ai_tutor_one_year_500yen_consumable"
IAP_NAME = "AI Tutor Pass 500yr"
IAP_TYPE = "CONSUMABLE"
TARGET_PRICE_JPY = "500"

LOCALIZATIONS = {
  "ja" => {
    "name" => "AIチューター Pass",
    "description" => "AIチャットを500回まで利用可能（購入日から1年間）",
  },
  "en-US" => {
    "name" => "AI Tutor Pass",
    "description" => "500 AI chat uses for one year from purchase date.",
  },
}.freeze

def env(key, default = nil)
  v = ENV[key]
  v.nil? || v.empty? ? default : v
end

def abort_msg(msg)
  warn "ERROR: #{msg}"
  exit 1
end

key_id = env("ASC_KEY_ID", "ATBD5UGJTG")
issuer_id = env("ASC_ISSUER_ID", "c64fb6be-f1d2-4e04-80b5-2841def3da52")
p8_path = env(
  "ASC_P8_PATH",
  File.expand_path("~/.appstoreconnect/private_keys/AuthKey_#{key_id}.p8"),
)
private_key_pem = env("ASC_PRIVATE_KEY")

if private_key_pem
  p8_content = private_key_pem
elsif File.exist?(p8_path)
  p8_content = File.read(p8_path)
else
  abort_msg(
    "App Store Connect API キーが見つかりません。ASC_P8_PATH=#{p8_path} " \
    "または ASC_PRIVATE_KEY を設定してください。",
  )
end

pkey = OpenSSL::PKey::EC.new(p8_content)

def make_token(pkey, key_id, issuer_id)
  payload = {
    iss: issuer_id,
    exp: Time.now.to_i + 1200,
    aud: "appstoreconnect-v1",
  }
  JWT.encode(payload, pkey, "ES256", { kid: key_id })
end

def api_request(token, method, path, body = nil)
  uri = URI("https://api.appstoreconnect.apple.com#{path}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  klass = case method
          when :get then Net::HTTP::Get
          when :post then Net::HTTP::Post
          else abort_msg("unsupported method #{method}")
          end

  req = klass.new(uri)
  req["Authorization"] = "Bearer #{token}"
  req["Content-Type"] = "application/json"
  req.body = body.to_json if body

  res = http.request(req)
  parsed = res.body.empty? ? {} : JSON.parse(res.body)

  unless res.is_a?(Net::HTTPSuccess)
    errors = parsed.dig("errors")&.map { |e| e["detail"] || e["title"] }.join("; ")
    detail = errors || res.body
    if res.code == "403" && detail.include?("agreement")
      abort_msg(
        "App Store Connect の契約が未署名または期限切れです。\n" \
        "   App Store Connect → ビジネス → 契約 で「Paid Apps Agreement」等を署名してください。\n" \
        "   署名後、数分待ってからこのスクリプトを再実行してください。",
      )
    end
    abort_msg("#{method.upcase} #{path} failed (#{res.code}): #{detail}")
  end

  parsed
end

token = make_token(pkey, key_id, issuer_id)

puts "==> App を検索 (#{BUNDLE_ID})"
apps = api_request(token, :get, "/v1/apps?filter[bundleId]=#{BUNDLE_ID}")
app = apps["data"]&.first
abort_msg("Bundle ID #{BUNDLE_ID} の App が見つかりません") unless app

app_id = app["id"]
app_name = app.dig("attributes", "name") || BUNDLE_ID
puts "    見つかりました: #{app_name} (id=#{app_id})"

puts "==> 既存 IAP を確認 (#{PRODUCT_ID})"
existing = api_request(token, :get, "/v1/apps/#{app_id}/inAppPurchases?limit=200")
iap = existing["data"]&.find { |row| row.dig("attributes", "productId") == PRODUCT_ID }

if iap
  iap_id = iap["id"]
  puts "    既に存在します (id=#{iap_id}) — スキップして価格・ローカライズを確認します"
else
  puts "==> IAP を作成 (消耗型 / #{PRODUCT_ID})"
  created = api_request(
    token,
    :post,
    "/v1/inAppPurchases",
    {
      data: {
        type: "inAppPurchases",
        attributes: {
          name: IAP_NAME,
          productId: PRODUCT_ID,
          inAppPurchaseType: IAP_TYPE,
        },
        relationships: {
          app: {
            data: { type: "apps", id: app_id },
          },
        },
      },
    },
  )
  iap_id = created.dig("data", "id")
  puts "    作成しました (id=#{iap_id})"
end

puts "==> ローカライズを追加"
loc_resp = api_request(token, :get, "/v1/inAppPurchases/#{iap_id}/inAppPurchaseLocalizations")
existing_locales = loc_resp["data"]&.map { |row| row.dig("attributes", "locale") } || []

LOCALIZATIONS.each do |locale, attrs|
  if existing_locales.include?(locale)
    puts "    #{locale}: 既存 — スキップ"
    next
  end

  api_request(
    token,
    :post,
    "/v1/inAppPurchaseLocalizations",
    {
      data: {
        type: "inAppPurchaseLocalizations",
        attributes: {
          locale: locale,
          name: attrs["name"],
          description: attrs["description"],
        },
        relationships: {
          inAppPurchaseV2: {
            data: { type: "inAppPurchases", id: iap_id },
          },
        },
      },
    },
  )
  puts "    #{locale}: 追加しました"
end

puts "==> 価格を設定 (日本 ¥#{TARGET_PRICE_JPY})"
price_points = api_request(
  token,
  :get,
  "/v1/inAppPurchases/#{iap_id}/pricePoints?filter[territory]=JPN&limit=200",
)
target_point = price_points["data"]&.find do |row|
  row.dig("attributes", "customerPrice") == TARGET_PRICE_JPY
end

if target_point.nil?
  warn "    WARNING: ¥#{TARGET_PRICE_JPY} の価格ポイントが見つかりませんでした。"
  warn "    App Store Connect で手動で ¥500 を設定してください。"
else
  price_point_id = target_point["id"]
  schedules = api_request(token, :get, "/v1/inAppPurchases/#{iap_id}/inAppPurchasePriceSchedules")
  schedule_id = schedules.dig("data", 0, "id")

  unless schedule_id
    price_row = api_request(
      token,
      :post,
      "/v1/inAppPurchasePrices",
      {
        data: {
          type: "inAppPurchasePrices",
          attributes: { startDate: nil },
          relationships: {
            inAppPurchaseV2: {
              data: { type: "inAppPurchases", id: iap_id },
            },
            inAppPurchasePricePoint: {
              data: { type: "inAppPurchasePricePoints", id: price_point_id },
            },
          },
        },
      },
    )
    manual_price_id = price_row.dig("data", "id")

    api_request(
      token,
      :post,
      "/v1/inAppPurchasePriceSchedules",
      {
        data: {
          type: "inAppPurchasePriceSchedules",
          relationships: {
            inAppPurchase: {
              data: { type: "inAppPurchases", id: iap_id },
            },
            baseTerritory: {
              data: { type: "territories", id: "JPN" },
            },
            manualPrices: {
              data: [{ type: "inAppPurchasePrices", id: manual_price_id }],
            },
          },
        },
      },
    )
    puts "    ¥#{TARGET_PRICE_JPY} を設定しました"
  else
    puts "    価格スケジュールは既に存在します — スキップ"
  end
end

puts ""
puts "✅ App Store Connect の IAP セットアップ完了"
puts "   製品 ID: #{PRODUCT_ID}"
puts "   IAP ID:  #{iap_id}"
puts ""
puts "次: RevenueCat で Product / Entitlement / Offering を確認し、"
puts "     Codemagic の revenuecat_credentials に REVENUECAT_IOS_API_KEY を追加して"
puts "     ios-app-store-release を実行してください。"
puts "     詳細: docs/IOS_AI_PASS_RELEASE.md"
