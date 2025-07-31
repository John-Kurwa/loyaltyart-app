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
- [View link](https://loyaltyart-c4a4b.firebaseapp.com)

---

## 📁 Project Structure

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

---

## 🛠️ Getting Started

### 1. Clone the repository
git clone https://github.com/john-kurwa/loyaltyart.git
cd loyaltyart

### 2. Install dependencies

flutter pub get

### 3. Set up Firebase
- Visit this link: https://firebase.google.com/
- Register if you do not have an account
- Click "Go to console" and create a new project. Once done click add an app and select flutter icon to work directly with flutter project.
- Follow this link: https://firebase.google.com/docs/cli?hl=en&authuser=0#install_the_firebase_cli to install firebase CLI in your project.
- Run "firebase login" from the terminal then login in using your firebase console credentials.
- Run "dart pub global activate flutterfire_cli" from the terminal.
- Run "flutterfire configure --project=your project id from firebase terminal" replace with your project id from the setup in firebase console. Run this command  at the root of your       Flutter project directory to automatically generate firebase_options.dart file in the lib folder. 
---

### 4. Configure Firebase

- Go to firebase console website, click settings and choose your project.
- Click Authentication and next get started or proceed to enable Email/Password.

---

### 5. Run the app

flutter run

---

### 6.Contribution
-We welcome contributions! Please fork the repository and submit a pull request for any enhancements or bug fixes.

Fork the project.
-Create your feature branch: git checkout -b feature/YourFeatureName

-Commit your changes: git commit -m 'Add some feature'

-Push to the branch: git push origin feature/YourFeatureName

-Open a pull request.

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

![Dashboard](assets/screens/dashboard.png)

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
[GitHub](https://github.com/John-Kurwa) • [LinkedIn](www.linkedin.com/in/john-kurwa60) 

---

## 📝 License

This project is licensed under the MIT License — feel free to use and modify.

---
