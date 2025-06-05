import 'package:flutter/foundation.dart';
import 'package:task_manager/models/task.dart';

enum TaskFilter {
  all,
  completed,
  pending,
}

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks {
    switch (_filter) {
      case TaskFilter.all:
        return _tasks;
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return _tasks.where((task) => !task.isCompleted).toList();
    }
  }

  TaskFilter get filter => _filter;

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void toggleTaskCompletion(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // For adding sample tasks during development
  void addSampleTasks() {
    _tasks.addAll([
      Task(
        title: 'Buy groceries',
        description: 'Milk, eggs, bread, and vegetables',
      ),
      Task(
        title: 'Complete Flutter project',
        description: 'Finish the task manager app',
      ),
      Task(
        title: 'Call mom',
        isCompleted: true,
      ),
      Task(
        title: 'Exercise',
        description: '30 minutes of cardio',
      ),
    ]);
    notifyListeners();
  }
}