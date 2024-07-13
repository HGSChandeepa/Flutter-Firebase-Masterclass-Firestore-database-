# Simple To-Do App - DP Education

This is a simple To-Do app built with Flutter and Firebase Firestore. It allows users to add, view, update, and delete tasks. The app demonstrates the use of CRUD operations with Firebase Firestore in a Flutter application.

## Features

- **Add Task:** Add a new task with a name.
- **View Tasks:** View a list of tasks with their creation and update timestamps.
- **Update Task:** Update the name of an existing task.
- **Delete Task:** Delete a task from the list.

## Getting Started

### Prerequisites

- Flutter installed on your local machine. You can download it from [flutter.dev](https://flutter.dev/docs/get-started/install).
- Firebase account and a Firebase project setup. Follow the instructions on [firebase.google.com](https://firebase.google.com/docs/flutter/setup) to create a project and register your app.

3. **Configure Firebase:**

   - Follow the instructions on the [Firebase website](https://firebase.google.com/docs/flutter/setup) to add your Firebase project to your Flutter app.
   - Download the `google-services.json` file for Android and place it in the `android/app` directory.
   - Download the `GoogleService-Info.plist` file for iOS and place it in the `ios/Runner` directory.
   - Enable Firestore in your Firebase project.

4. **Run the app:**

   ```bash
   flutter run
   ```

## Project Structure

```plaintext
lib/
├── main.dart                 # Entry point of the application
├── models/
│   └── todo_model.dart       # Todo model class
├── services/
│   └── todo_service.dart     # Service class for Firestore operations
└── pages/
    └── home_page.dart        # Home page of the app
```

