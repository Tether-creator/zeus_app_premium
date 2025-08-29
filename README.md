# ZEUS Premium Wallet

ZEUS is a **premium digital banking app** built with Flutter (Android, iOS, Web).  
It ships a sleek gold-on-dark theme, multi-currency wallets, realistic flows, and web-safe receipts.

## ✨ Features
- 💼 Multi-currency: **NGN, USD, EUR, GBP, GHC, KSH**
- 🔄 Currency conversion (mock FX) with transaction history
- 💸 Transfers with limits (**₦2,000,000 / txn**, **₦100,000,000 / day**)
- 📲 Airtime & Data: **₦20,000 / txn**, **₦100,000 / day**
- 🧾 Bills: **₦100,000 / txn**, **₦500,000 / day**
- 🧾 PDF receipts (share/download on web & mobile; no `dart:io`)
- 🧑‍💼 Account opening (BVN, NIN, address, phone, email, DOB, selfie check)
- ➕ Add Money (Card + OTP mock, Bank Transfer, Cash Deposit)
- 🏦 Nigerian bank lookup (mock list + name resolver for demo)
- 🧭 Bottom nav + Home shortcuts; premium dark theme

## 🗂 Project Structure
- `lib/` — Flutter app code (screens, services, theme, state)
- `assets/images/zeus_logo.png` — app logo (transparent background)
- `.github/workflows/build.yml` — CI for Web + Android + iOS

## 🚀 Run Locally
```bash
flutter clean
flutter pub get
flutter run -d chrome   # or android/ios device
