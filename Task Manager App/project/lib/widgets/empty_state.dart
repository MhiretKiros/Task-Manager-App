import 'package:flutter/material.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  final TaskFilter filter;

  const EmptyState({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    String message;
    IconData icon;

    switch (filter) {
      case TaskFilter.all:
        message = 'No tasks yet. Tap the + button to add your first task!';
        icon = Icons.task_alt;
        break;
      case TaskFilter.pending:
        message = 'No pending tasks. Great job!';
        icon = Icons.check_circle_outline;
        break;
      case TaskFilter.completed:
        message = 'No completed tasks yet. Complete a task to see it here.';
        icon = Icons.check_circle;
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppTheme.primaryColor.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondaryLight,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}