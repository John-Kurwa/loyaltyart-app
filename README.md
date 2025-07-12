# ✂️ LoyaltyArt

**LoyaltyArt** is a modern Flutter-based mobile & web app for barbershops and salons to track customer loyalty, manage bookings, view payments, and gain actionable insights via admin analytics and charts. Designed to improve retention through QR-based rewards and SMS reminders.

---

## 🚀 Features

- ✅ **Customer Loyalty Tracking** (QR code or phone number based)
- 📆 **Booking System** with client name, date & service
- 💰 **Payment History** & tracking
- 📊 **Admin Dashboard** with charts & analytics
- 🔐 **Authentication** (Firebase email/password)
- ✉️ **SMS Reminders** (via integrated SMS API)
- 🔔 **Push Notifications**
- 🎨 Smooth Animations & Responsive UI

---

## 📁 Project Structure

```text
lib/
├── app/
│   ├── routes.dart           # App navigation
│   └── theme.dart            # Global theme & styling
├── core/
│   ├── services/             # Shared services (auth, notifications, etc.)
│   └── styles/               # Custom styling & colors
├── features/
│   ├── auth/
│   │   └── presentation/pages/login_page.dart
│   ├── home/
│   │   └── presentation/pages/home_page.dart
│   ├── bookings/
│   │   ├── data/repositories/
│   │   └── presentation/pages/widgets/
│   ├── loyalty/
│   │   ├── data/repositories/
│   │   └── presentation/pages/widgets/
│   ├── payments/
│   │   ├── data/repositories/
│   │   └── presentation/pages/widgets/
│   └── admin/
│       └── presentation/pages/admin_dashboard.dart
```

---

## 🛠️ Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/john-kurwa/loyaltyart.git
cd loyaltyart
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up Firebase

- Create a Firebase project
- Enable **Email/Password** auth
- Add a test user
- Download `google-services.json`
- Place it in:  
  ```
  android/app/google-services.json
  ```

### 4. Configure Firebase

Edit your Gradle files:
- In `android/build.gradle`:
  ```gradle
  classpath 'com.google.gms:google-services:4.3.15'
  ```
- In `android/app/build.gradle`:
  ```gradle
  apply plugin: 'com.google.gms.google-services'
  ```

### 5. Run the app

```bash
flutter run
```

---

## 💡 Tech Stack

- **Flutter** (Dart)
- **Firebase** (Auth, Storage, Notifications)
- **Provider** (state management)
- **Charts & Animations**
- **Custom UI** (responsive grid, cards, icons)
- Optional: SMS API integration (Africa's Talking / Twilio / etc.)

---

## 📸 Screenshots

> _You can add screenshots or gifs here later using:_
```
![Dashboard](assets/screens/dashboard.png)
```

---

## 📦 Future Improvements

- ✅ Dark mode
- ✅ iOS support
- 🌐 Language localization
- 📍 Location-based shop selection
- 📥 Customer referral codes

---

## 👨‍💻 Author

**John Mumba**  
🇰🇪 Nairobi, Kenya  
[GitHub](https://github.com/john-mumba) • [LinkedIn](https://linkedin.com/in/john-mumba) • [Twitter](https://twitter.com/your_handle)

---

## 📝 License

This project is licensed under the MIT License — feel free to use and modify.

---



