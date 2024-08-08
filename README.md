# Lost Linker

### Introduction

Lost Linker is a dedicated lost and found app designed specifically for university communities. It allows students, faculty, and staff to easily post and search for lost or found items on campus. The app ensures privacy by avoiding location tracking while providing a simple and effective way to reunite lost items with their owners. Built using **Flutter** and **Dart**, with **Firebase** handling backend services like authentication, database, and cloud storage.

### Features

1. **Login**: Secure login system for all users.
2. **Registration**: Easy user registration with email verification.
3. **User Profile**: Manage personal information and view activity.
4. **Create Post**: Create posts for lost or found items.
5. **Homepage**: View recent posts and search for items.
6. **My Posts**: Manage and track posts you’ve created.
7. **Owner Verification**: Ensure items are returned to their rightful owners.
8. **Contact Sharing**: Safely share contact information for item recovery.

### Demonstration

Watch the full demonstration of Lost Linker on YouTube: [Lost Linker Demo](https://www.youtube.com/watch?v=lvcC98XWZBs)

### Requirements

- **Android Studio**: Integrated development environment for Android development.
- **Firebase**: Backend-as-a-Service for authentication, database, and cloud storage.

### Framework and Language

- **Framework**: Flutter
- **Language**: Dart

### Installation

#### Step 1: Install Android Studio

1. Download and install [Android Studio](https://developer.android.com/studio) from the official website.
2. Set up your development environment by following the instructions provided.

#### Step 2: Set Up Firebase

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project or use an existing one.
3. Add an Android app to your project:
   - Register your app with the package name (e.g., `com.example.lostlinker`).
   - Download the `google-services.json` file and place it in the `android/app` directory of your Flutter project.
4. Enable the required Firebase services:
   - Authentication: Set up email/password authentication.
   - Firestore Database: Create a Firestore database for storing lost and found posts.
   - Cloud Storage: Enable cloud storage for image uploads.
5. Add the Firebase SDK to your Flutter project:
   - Open `pubspec.yaml` and add the necessary dependencies for Firebase services:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       firebase_core: latest_version
       firebase_auth: latest_version
       cloud_firestore: latest_version
       firebase_storage: latest_version
     ```
   - **Download the latest versions** of these dependencies from [pub.dev](https://pub.dev/).
   - Run `flutter pub get` to install the dependencies.

#### Step 3: Clone the Repository

```bash
git clone https://github.com/aman0311x/lost-linker.git
cd lost-linker
