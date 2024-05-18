# Expense Tracker

Welcome to the Expense Tracker application, developed using Flutter. This app helps you manage your expenses efficiently, with Firebase serving as the backend for authentication and data storage. Here's a detailed overview of the application and its features:

## Features

### Firebase Authentication
- **Login:** If you already have an account, use your email and password to log in.
- **Signup:** If you don't have an account, sign up to create a new one.
- 

### Clean Architecture
- The application is built using the Clean Architecture pattern to ensure maintainability, testability, and scalability of the codebase.

### Hive Database
- **Local Storage:** Transactions are stored locally using the Hive database, allowing for quick access and offline capabilities.
- **User-specific Data:** Different users have their own sets of transactions, ensuring privacy and organization.

### User Interface
- **Multiple Accounts:** The app allows users to handle multiple accounts simultaneously.
- **Transaction Management:** Users can add, edit, or delete transactions. A long press on a transaction will open options to delete or edit it, while a single press will show the transaction details.

## Application Structure

### Authentication
- **Login Screen:** For users to enter their credentials and log in.
- **Signup Screen:** For new users to create an account.

### Home Screen
- **Account Overview:** Displays an overview of all accounts and their balances.
- **Transaction List:** Lists all transactions for the selected account.

### Transaction Management
- **Add Transaction:** A form to add new transactions.
- **Edit Transaction:** A form to edit existing transactions.
- **Transaction Details:** Displays detailed information about a selected transaction.

## Installation and Setup

### Prerequisites
- Flutter SDK
- Firebase account
- Hive database

### Steps
1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Set up Firebase:**
   - Add your `google-services.json` file for Android in the `android/app` directory.
   - Add your `GoogleService-Info.plist` file for iOS in the `ios/Runner` directory.
   - Configure Firebase Authentication and Firestore in the Firebase Console.

4. **Run the app:**
   ```bash
   flutter run
   ```

## Usage

1. **Sign Up:** Create a new account if you don't have one.
2. **Login:** Log in with your email and password.
3. **Manage Accounts:** Add multiple accounts and view their balances.
4. **Add Transactions:** Keep track of your expenses by adding transactions.
5. **Edit/Delete Transactions:** Long press on a transaction to edit or delete it.

## Conclusion

The Expense Tracker app is a powerful tool to help you manage your finances. With Firebase authentication, clean architecture, and local storage using Hive, this app ensures a smooth and secure user experience. Enjoy tracking your expenses efficiently!

---

This document provides an overview of the Expense Tracker application, including its features, application structure, installation, and usage instructions. If you have any further questions or need assistance, please refer to the documentation or contact support.
