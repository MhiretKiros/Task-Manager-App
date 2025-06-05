# Task Manager App

A mobile task management application built with Flutter that allows users to manage their tasks efficiently.

## Features

- Display a list of tasks with title and optional description
- Add new tasks with validation (title must not be empty)
- Mark tasks as completed with visual feedback
- Delete tasks with confirmation dialog
- Filter tasks by status (all, pending, completed)
- Modern and clean UI design with smooth animations

## Getting Started

### Prerequisites

- Flutter SDK (latest version recommended)
- Dart SDK
- Android Studio or VS Code with Flutter extensions

### Installation

1. Clone this repository:
```
git clone https://github.com/yourusername/task_manager.git
```

2. Navigate to the project directory:
```
cd task_manager
```

3. Install dependencies:
```
flutter pub get
```

4. Run the app:
```
flutter run
```

## Usage

1. **View Tasks**: All tasks are displayed on the home screen
2. **Add Task**: Tap the + button to open the add task form
3. **Complete Task**: Check the checkbox next to a task to mark it as completed
4. **Delete Task**: Swipe a task to the left to reveal the delete option
5. **Filter Tasks**: Use the tab bar to filter tasks by status (All, Pending, Completed)

## Project Structure

- `lib/models/` - Contains the Task data model
- `lib/providers/` - Contains the TaskProvider for state management
- `lib/screens/` - Contains the main screen of the application
- `lib/widgets/` - Contains reusable UI components
- `lib/theme/` - Contains app theme configuration
- `lib/utils/` - Contains utility functions and animation classes

## Dependencies

- `provider`: For state management
- `uuid`: For generating unique IDs for tasks
- `flutter_slidable`: For swipe-to-delete functionality

## Future Improvements

- Add task categories/labels
- Add due dates and reminders
- Implement data persistence with local storage
- Add dark mode theme
- Add search functionality