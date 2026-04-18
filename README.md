# calculus_gacha (JoyMath)

## Web app (GitHub Pages)

**Live URL:** [https://ns2pole.github.io/calculus_gacha/](https://ns2pole.github.io/calculus_gacha/)

That URL must load the **Flutter app** (home: integral / limit gacha).  
If you only see this **README**, GitHub Pages is pointing at the wrong source:

1. Open **Settings → Pages**
2. **Build and deployment → Source:** choose **GitHub Actions** (not “Deploy from a branch: main”).
3. Push to `main` or run workflow **Deploy Web to GitHub Pages** manually.

See: [Configuring a publishing source for GitHub Pages](https://docs.github.com/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).

---

## Localization

- **Web:** Uses the browser language list (same order as the language settings / `Accept-Language`). If any preferred language is **Japanese (`ja`)**, the UI is Japanese; otherwise **English**.
- **iOS / Android:** Uses the OS locale the same way (`ja` → Japanese, else English).

---

## Secrets (do not commit)

- Firebase Web: fill `lib/firebase_web_options.dart` locally only (placeholders in repo).
- iOS: `GoogleService-Info.plist` from `.example` locally.
- Android: `google-services.json`, `key.properties`, keystores — local only (`.gitignore`).

---

## Flutter

This project is a Flutter application. See the [Flutter documentation](https://docs.flutter.dev/).
