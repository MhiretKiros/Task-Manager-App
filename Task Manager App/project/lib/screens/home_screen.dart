import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/theme/app_theme.dart';
import 'package:task_manager/widgets/empty_state.dart';
import 'package:task_manager/widgets/new_task_sheet.dart';
import 'package:task_manager/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Add sample tasks - only for demonstration
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      if (taskProvider.tasks.isEmpty) {
        taskProvider.addSampleTasks();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NewTaskSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTaskList(TaskFilter.all),
                  _buildTaskList(TaskFilter.pending),
                  _buildTaskList(TaskFilter.completed),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Manager',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              final pendingCount = taskProvider.tasks
                  .where((task) => !task.isCompleted)
                  .length;
              
              return Text(
                'You have $pendingCount pending tasks',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondaryLight,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppTheme.primaryColor,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.textSecondaryLight,
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Pending'),
          Tab(text: 'Completed'),
        ],
        onTap: (index) {
          final provider = Provider.of<TaskProvider>(context, listen: false);
          switch (index) {
            case 0:
              provider.setFilter(TaskFilter.all);
              break;
            case 1:
              provider.setFilter(TaskFilter.pending);
              break;
            case 2:
              provider.setFilter(TaskFilter.completed);
              break;
          }
        },
      ),
    );
  }

  Widget _buildTaskList(TaskFilter filter) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        taskProvider.setFilter(filter);
        final tasks = taskProvider.tasks;
        
        if (tasks.isEmpty) {
          return EmptyState(filter: filter);
        }
        
        return TaskList(tasks: tasks);
      },
    );
  }
}