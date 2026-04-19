# calculus_gacha (JoyMath)

## Web app (GitHub Pages)

**Live URL:** [https://ns2pole.github.io/calculus_gacha/](https://ns2pole.github.io/calculus_gacha/)

That URL must load the **Flutter app** (home: integral / limit gacha).  
If you only see this **README**, GitHub Pages is pointing at the wrong source:

1. Open **Settings → Pages**
2. **Build and deployment → Source:** choose **GitHub Actions** (not “Deploy from a branch: main”).
3. Push to `main` or run workflow **Deploy Web to GitHub Pages** manually.
4. Latest web deploys are published by that GitHub Actions workflow.

See: [Configuring a publishing source for GitHub Pages](https://docs.github.com/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).

---

## Localization

- **Web:** Uses the browser language list (same order as the language settings / `Accept-Language`). If any preferred language is **Japanese (`ja`)**, the UI is Japanese; otherwise **English**.
- **iOS / Android:** Uses the OS locale the same way (`ja` → Japanese, else English).

---

## Firebase on Web (GitHub Pages)

1. Firebase Console → Project settings → Your apps → Web → copy `firebaseConfig` values.
2. GitHub repo → **Settings → Secrets and variables → Actions** → add:

   | Secret | Maps to `firebaseConfig` |
   |--------|---------------------------|
   | `FIREBASE_WEB_API_KEY` | `apiKey` |
   | `FIREBASE_WEB_APP_ID` | `appId` |
   | `FIREBASE_WEB_MESSAGING_SENDER_ID` | `messagingSenderId` |
   | `FIREBASE_WEB_PROJECT_ID` | `projectId` |
   | `FIREBASE_WEB_STORAGE_BUCKET` | `storageBucket` |
   | `FIREBASE_WEB_AUTH_DOMAIN` | `authDomain` (optional; defaults to `{projectId}.firebaseapp.com`) |
   | `FIREBASE_WEB_MEASUREMENT_ID` | `measurementId` (optional) |

3. Firebase Console → **Authentication → Settings → Authorized domains** → add  
   **`localhost`** and **`ns2pole.github.io`** (your GitHub Pages host).
4. Push to `main` (or re-run **Deploy Web to GitHub Pages**). The workflow runs  
   `dart run tool/inject_firebase_web_options.dart` before `flutter build web`.

For **Google sign-in on Web**, also confirm:
- **Authentication → Sign-in method → Google** is enabled.
- The deployed site opens from **`https://ns2pole.github.io/calculus_gacha/`**.
- If Google sign-in fails only on Web, check the browser error message for
  `unauthorized-domain` or popup-blocking and then re-check Firebase Auth settings.

**Local web:** paste the same values into `lib/firebase_web_options.dart` (do not commit).

## Other secrets (do not commit)

- iOS: `GoogleService-Info.plist` from `.example` locally.
- Android: `google-services.json`, `key.properties`, keystores — local only (`.gitignore`).

---

## Flutter

This project is a Flutter application. See the [Flutter documentation](https://docs.flutter.dev/).
