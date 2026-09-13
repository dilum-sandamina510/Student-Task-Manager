# Student Task Manager - Flutter Mobile Application

A functional **Student Task Manager** mobile application developed using Flutter and Dart. Designed for university students to manage daily academic tasks such as assignments, lectures, research work, exam preparation, and personal tasks.

---

## 📱 Features

- **Dashboard Statistics**: Real-time counter cards showing Total Tasks, Completed, and Pending tasks.
- **Add New Task**: Form to enter task title, select category (*Assignment, Lecture, Research, Exam, Personal*), and select priority (*High, Medium, Low*).
- **Input Validation**: Prevents empty task submission with validation error messages and SnackBar notifications.
- **Task List View**: Displays tasks in card format with category chips, color-coded priority badges, and status labels.
- **Status Toggle**: Easily mark tasks as Completed or Pending.
- **Delete Task**: Remove tasks with feedback notifications.
- **MVC Architecture**: Clean separation between Model, View, and Controller layers.

---

## 📂 Project Architecture (MVC)

The codebase follows the required MVC folder structure:

```
lib/
├── models/
│   └── task.dart            # Task data model
├── controllers/
│   └── task_controller.dart # Task state & business logic
├── views/
│   ├── home_page.dart       # Screen 1: Dashboard & Task List View
│   └── add_task_page.dart    # Screen 2: Add Task Form with validation
└── main.dart                # Application entrypoint & MaterialApp configuration
```

---

## 🚀 How to Run

1. **Prerequisites**: Ensure Flutter SDK and Dart are installed.
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run Application**:
   ```bash
   flutter run
   ```

---

## 🛠️ Flutter Concepts Implemented

- `MaterialApp` & `Scaffold`
- `StatefulWidget` & `setState()`
- `TextEditingController`
- `TextField` & `Form` validation (`GlobalKey<FormState>`)
- `DropdownButtonFormField`
- `ElevatedButton`, `OutlinedButton`, `IconButton`
- `ListView.builder` & `Card`
- `Row`, `Column`, `Container`, `Chip` layout widgets
- Multi-screen Navigation (`Navigator.push`, `Navigator.pop`)
