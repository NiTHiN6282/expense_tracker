# Expense Tracker - Authentication Module

This README documents the **Email Signup & OTP Verification Authentication Flow** used in the Expense Tracker Flutter application. It covers setup, configuration, integration, and execution steps.

---

## 📱 Features Included

* Email-based user registration
* Strong password validation
* OTP-based email verification
* Google Sign-In UI (endpoint prepared)
* Riverpod state management
* Clean architecture (UI → Controller → Repository → API)
* Robust error handling using `fpdart` Either pattern

---

## 🧱 Architecture Overview

```
features/
 └── auth/
     ├── controller/
     │   └── auth_controller.dart
     ├── repository/
     │   └── auth_repository.dart
     ├── models/
     │   ├── sign_up_response_model.dart
     │   └── verify_response_model.dart
     └── screens/
         ├── signup_screen.dart
         └── verification_screen.dart

core/
 ├── api.dart
 ├── utils.dart
 ├── failure.dart
 └── type_defs.dart
```

---

## ⚙️ Prerequisites

Ensure you have the following installed:

* ✅ Flutter SDK (3.x recommended)
* ✅ Android Studio / VS Code
* ✅ Emulator or Physical Device
* ✅ Internet connection

---

## 🔧 Required Packages

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_riverpod: ^3.0.3
  http: ^1.6.0
  fpdart: ^1.2.0
  google_fonts: ^6.3.2
  flutter_svg: ^2.2.2
  pinput: ^6.0.0
```

Run:

```bash
flutter pub get
```

---

## 🔑 API Configuration

File: `core/api.dart`

```dart
class Api {
  static const baseUrl = "https://phplaravel-1505866-5773612.cloudwaysapps.com/api/v1";
  static const apiKey = "YOUR_API_KEY";

  static const signUpEmail = "/auth/signup/email";
  static const verifyEmail = "/auth/verify-email";
}
```

⚠️ Replace `YOUR_API_KEY` with your actual API key if needed.

---

## 🚀 How Authentication Flow Works

### 1️⃣ Signup Process

User enters:

* Name
* Email
* Password

Validation Rules:

* Minimum 8 characters
* At least 1 uppercase letter
* At least 1 number
* At least 1 special character

On success:

* API `POST /auth/signup/email` is called
* User is redirected to Verification Screen

### 2️⃣ Email Verification (OTP)

User enters 6-digit OTP

API called:

```
POST /auth/verify-email
Body: { email, otp }
```

On success:

* Access Token & Refresh Token returned
* User verified and redirected

---

## 🧩 Integration Guide

### Step 1: Wrap App with ProviderScope

```dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### Step 2: Use Signup Screen

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => SignupScreen()),
);
```

### Step 3: Email Verification Screen

```dart
VerificationScreen(email: userEmail);
```

---

## ▶️ Run the App

```bash
flutter run
```

---


## ✅ Folder Responsibility

| Layer      | Responsibility              |
| ---------- | --------------------------- |
| UI         | Handles layout & user input |
| Controller | Business logic & navigation |
| Repository | API interaction             |
| Models     | Response parsing            |
| Core       | Shared utilities            |

---

