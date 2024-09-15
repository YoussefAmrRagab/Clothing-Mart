# 🛍️ Flutter Clothing Mart App
<div style="display: flex; flex-direction: row;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/8c099eb0-c0b1-41f2-a511-2ede4b7ef519" alt="Screenshot 0" style="width: 200px; height: auto; margin-right: 10px;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/a13ecd0d-8ecb-4704-b260-c7fad62ffaad" alt="Screenshot 3" style="width: 200px; height: auto; margin-right: 10px;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/bffa1e9a-e04b-4017-a1c3-3f4a1fcaf4c4" alt="Screenshot 1" style="width: 200px; height: auto;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/372e911b-aec1-447c-8265-96c1466e5335" alt="Screenshot 2" style="width: 200px; height: auto; margin-right: 10px;">
</div>

Welcome to the Flutter Clothing Mart App! This project is a mobile application developed using Flutter, Firebase Authentication, Firebase Realtime Database, Cloud Firestore, and Cloud Storage for Firebase. The app allows users to browse and shop for clothes, manage their cart, save favorite items, and update their profile settings.

## Features

### Authentication

- 🔐 **Login Screen**: Users can authenticate using their email and password through Firebase Authentication.
- 📝 **Signup Screen**: New users can create an account using their email and password, which is authenticated through Firebase.

### Home Screen

- 🏠 **Clothing Display**: Displays a list of clothes categorized by type.
- 🏷️ **Chip Widget**: Allows users to filter clothes by category.
- 🔍 **Search Bar**: Enables users to search for specific clothing items.
- 🎉 **Recommendations**: Recommends clothing based on the user's weight and gender.

### Details Screen

- 📄 **Clothing Details**: Shows the image, description, brand, price, available sizes, and an option to add items to the cart.
- ➕ **Counter**: Allows users to select the quantity of items they want to purchase.

### Checkout Screen

- 🛒 **Checkout Display**: Shows all clothing items added to the cart.
- 💰 **Total Price Calculation**: Calculates the total price of all items in the cart.

### Favorite Screen

- ❤️ **Favorites Display**: Shows clothing items that the user has saved as favorites.

### Settings Screen

- ⚙️ **Profile Management**: Allows users to view and update their profile information.
- 🚪 **Logout**: Enables users to log out of their account.

## Clean Architecture Project 🏗️

### Presentation Layer 🎨

- 🖼️ **View**: Represents the UI components visible to the user. Includes screens such as login, signup, home, details, cart, favorite, and settings.
- 🧠 **Provider**: Acts as an intermediary between the View and the Domain layers. Manages the presentation logic and state of the UI. Provides data to the View and handles user interactions.

### Domain Layer 💡
Encapsulates the core business logic and rules of the application.

### Data Layer 📊
Handles data retrieval and storage, interacting with external sources.

## Technologies Used

- 📱 **Flutter**: Cross-platform UI toolkit for building natively compiled applications.
- 🔑 **Firebase Auth**: Provides backend services, easy-to-use SDKs, and ready-made UI libraries to authenticate users to your app.
- 🗄️ **Firebase Realtime Database**: Cloud-hosted NoSQL database to store and sync data between users in real-time.
- 📋 **Cloud Firestore**: Flexible, scalable database for mobile, web, and server development. Stores user data and clothing details.
- 🖼️ **Cloud Storage for Firebase**: Securely upload and store user and product images.
- 🔄 **Provider**: A state management library for Flutter that uses the provider pattern to manage application state.

## Installation

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Ensure Firebase setup and configuration (refer to Firebase documentation).
5. Run the app on your preferred device/emulator with `flutter run`.
