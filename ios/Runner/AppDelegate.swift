import Flutter
import UIKit
import StoreKit

// StoreKitTestクラスをAppDelegate.swift内に定義
class StoreKitTest: NSObject, SKProductsRequestDelegate {
    private var productsRequest: SKProductsRequest?
    private var result: FlutterResult?
    
    func testProductRequest(productId: String, result: @escaping FlutterResult) {
        self.result = result
        
        let productIds = Set([productId])
        let request = SKProductsRequest(productIdentifiers: productIds)
        request.delegate = self
        self.productsRequest = request
        
        print("StoreKitTest: Requesting product: \(productId)")
        request.start()
    }
    
    func listAllAvailableProducts(result: @escaping FlutterResult) {
        self.result = result
        
        // Products.storekitファイルに登録されているすべての商品IDを取得
        // 実際のApp Store Connectの商品IDを試す（既知の商品IDのリスト）
        let knownProductIds = Set([
            "indefinite_equation_option_160yen",
            "factorization_double_option_80yen"
        ])
        
        let request = SKProductsRequest(productIdentifiers: knownProductIds)
        request.delegate = self
        self.productsRequest = request
        
        print("StoreKitTest: Requesting all available products...")
        request.start()
    }
    
    // MARK: - SKProductsRequestDelegate
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("StoreKitTest: Received \(response.products.count) products")
        print("StoreKitTest: Invalid product IDs: \(response.invalidProductIdentifiers)")
        
        if response.products.isEmpty {
            print("StoreKitTest: No products found")
            
            let errorMessage = "No products found. Invalid IDs: \(response.invalidProductIdentifiers.joined(separator: ", "))"
            
            // すべての商品をリストする場合
            result?([
                "success": false,
                "error": errorMessage,
                "invalidProductIds": Array(response.invalidProductIdentifiers),
                "availableProducts": []
            ])
            return
        }
        
        // 複数の商品が返された場合（listAllAvailableProductsの場合）
        if response.products.count > 1 {
            var productsList: [[String: Any]] = []
            for product in response.products {
                print("StoreKitTest: Found product:")
                print("  - Product ID: \(product.productIdentifier)")
                print("  - Localized Title: \(product.localizedTitle)")
                print("  - Localized Description: \(product.localizedDescription)")
                print("  - Price: \(product.price)")
                print("  - Price Locale: \(product.priceLocale.identifier)")
                print("  - Localized Price: \(product.localizedPrice ?? "nil")")
                
                productsList.append([
                    "productId": product.productIdentifier,
                    "title": product.localizedTitle,
                    "description": product.localizedDescription,
                    "price": product.price.doubleValue,
                    "priceLocale": product.priceLocale.identifier,
                    "localizedPrice": product.localizedPrice ?? ""
                ])
            }
            
            result?([
                "success": true,
                "products": productsList,
                "invalidProductIds": Array(response.invalidProductIdentifiers)
            ])
            return
        }
        
        // 単一商品の場合（testProductRequestの場合）
        for product in response.products {
            print("StoreKitTest: Found product:")
            print("  - Product ID: \(product.productIdentifier)")
            print("  - Localized Title: \(product.localizedTitle)")
            print("  - Localized Description: \(product.localizedDescription)")
            print("  - Price: \(product.price)")
            print("  - Price Locale: \(product.priceLocale.identifier)")
            print("  - Localized Price: \(product.localizedPrice ?? "nil")")
        }
        
        let firstProduct = response.products.first!
        result?([
            "success": true,
            "productId": firstProduct.productIdentifier,
            "title": firstProduct.localizedTitle,
            "description": firstProduct.localizedDescription,
            "price": firstProduct.price.doubleValue,
            "priceLocale": firstProduct.priceLocale.identifier,
            "localizedPrice": firstProduct.localizedPrice ?? ""
        ])
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("StoreKitTest: Request failed with error: \(error.localizedDescription)")
        result?(["success": false, "error": error.localizedDescription])
    }
}

extension SKProduct {
    var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var storeKitTest: StoreKitTest?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // StoreKitテスト用のメソッドチャンネルを設定
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "com.joymath/storekit_test",
      binaryMessenger: controller.binaryMessenger
    )
    
    storeKitTest = StoreKitTest()
    
    channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "testProductRequest" {
        guard let args = call.arguments as? [String: Any],
              let productId = args["productId"] as? String else {
          result(FlutterError(code: "INVALID_ARGS", message: "productId is required", details: nil))
          return
        }
        
        self?.storeKitTest?.testProductRequest(productId: productId, result: result)
      } else if call.method == "listAllAvailableProducts" {
        self?.storeKitTest?.listAllAvailableProducts(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
