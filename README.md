# 🛍️ Flutter Clothing Mart App
<div style="display: flex; flex-direction: row;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/f7c1e53d-30ce-4080-8d55-6841ec51764f" alt="Screenshot 0" style="width: 200px; height: auto; margin-right: 10px;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/a2860ef0-4d69-4279-8c18-234e17e89ac9" alt="Screenshot 1" style="width: 200px; height: auto;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/ba0df0f8-51b3-4045-8f9b-892884eaad81" alt="Screenshot 2" style="width: 200px; height: auto; margin-right: 10px;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/73302a33-4320-4221-9479-0fdf0037f7a9" alt="Screenshot 3" style="width: 200px; height: auto; margin-right: 10px;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/942d99b9-cfdc-4894-99d3-434093eafb95" alt="Screenshot 4" style="width: 200px; height: auto; margin-right: 10px;">
    <img src="https://github.com/YoussefAmrRagab/Clothing-Mart/assets/114784684/677ccbad-231f-4a96-8b2a-079b470ada1a" alt="Screenshot 5" style="width: 200px; height: auto; margin-right: 10px;">
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
- 🎉 **Recommendations**: Recommends clothing based on the user's weight.

### Details Screen

- 📄 **Clothing Details**: Shows the image, description, brand, price, available sizes, and an option to add items to the cart.
- ➕ **Counter**: Allows users to select the quantity of items they want to purchase.

### Cart Screen

- 🛒 **Cart Display**: Shows all clothing items added to the cart.
- 💰 **Total Price Calculation**: Calculates the total price of all items in the cart.

### Favorite Screen

- ❤️ **Favorites Display**: Shows clothing items that the user has saved as favorites.

### Settings Screen

- ⚙️ **Profile Management**: Allows users to view and update their profile information.
- 🚪 **Logout**: Enables users to log out of their account.

## Architecture: MVVM

This project follows the MVVM (Model-View-ViewModel) architecture pattern:

- 🏗️ **Model**: Represents the data and business logic of the application. Includes classes for clothing items, user data, and authentication.
- 🖼️ **View**: Represents the UI components visible to the user. Includes screens such as login, signup, home, details, cart, favorite, and settings.
- 🧠 **ViewModel**: Acts as an intermediary between the View and the Model. Manages the presentation logic and state of the UI. Provides data to the View and handles user interactions. Utilizes the Provider package for state management in Flutter.

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

## Note

This is not the final version and needs more modification some features not working (like: search, recommendation, and changing user image), and there are some bugs but I will solve it at nearest time as I can also the code needs more reorganizing and i will do it as much as I can
