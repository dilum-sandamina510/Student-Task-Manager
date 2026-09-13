import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _controller = TaskController();

  void _navigateToAddTask() async {
    final Task? newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    if (newTask != null) {
      setState(() {
        _controller.addTask(newTask);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task "${newTask.title}" added successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _controller.changeStatus(index);
    });
  }

  void _deleteTask(int index) {
    final deletedTaskTitle = _controller.tasks[index].title;
    setState(() {
      _controller.deleteTask(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "$deletedTaskTitle"'),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Task Manager'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Dashboard Summary Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard(
                      context,
                      title: 'Total Tasks',
                      value: _controller.totalTasks.toString(),
                      color: theme.colorScheme.primary,
                      icon: Icons.list_alt,
                    ),
                    _buildStatCard(
                      context,
                      title: 'Completed',
                      value: _controller.completedTasks.toString(),
                      color: Colors.green.shade700,
                      icon: Icons.check_circle_outline,
                    ),
                    _buildStatCard(
                      context,
                      title: 'Pending',
                      value: _controller.pendingTasks.toString(),
                      color: Colors.orange.shade800,
                      icon: Icons.hourglass_empty,
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Add New Task Button
                ElevatedButton.icon(
                  onPressed: _navigateToAddTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add New Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Task List Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task List',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text('${_controller.totalTasks} items'),
                  backgroundColor: Colors.grey.shade200,
                ),
              ],
            ),
          ),

          // Tasks ListView
          Expanded(
            child: _controller.tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No tasks found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tap "Add New Task" to create one',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _controller.tasks.length,
                    itemBuilder: (context, index) {
                      final task = _controller.tasks[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: task.completed
                                ? Colors.green.shade300
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Status Checkbox / Toggle
                                  IconButton(
                                    icon: Icon(
                                      task.completed
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: task.completed
                                          ? Colors.green.shade700
                                          : Colors.grey.shade600,
                                    ),
                                    onPressed: () => _toggleTaskStatus(index),
                                    tooltip: task.completed
                                        ? 'Mark as pending'
                                        : 'Mark as completed',
                                  ),
                                  const SizedBox(width: 4),
                                  // Title and Badges
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.title,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            decoration: task.completed
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            color: task.completed
                                                ? Colors.grey.shade600
                                                : Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            // Category Badge
                                            _buildBadge(
                                              label: 'Category: ${task.category}',
                                              color: Colors.indigo.shade100,
                                              textColor: Colors.indigo.shade900,
                                            ),
                                            const SizedBox(width: 8),
                                            // Priority Badge
                                            _buildBadge(
                                              label: 'Priority: ${task.priority}',
                                              color: _getPriorityBgColor(task.priority),
                                              textColor: _getPriorityTextColor(task.priority),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        // Status text display
                                        Text(
                                          'Status: ${task.completed ? 'Completed' : 'Pending'}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: task.completed
                                                ? Colors.green.shade700
                                                : Colors.orange.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 16),

                              // Bottom Buttons: Complete & Delete
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () => _toggleTaskStatus(index),
                                    icon: Icon(
                                      task.completed
                                          ? Icons.undo
                                          : Icons.check_circle_outline,
                                      size: 16,
                                    ),
                                    label: Text(
                                      task.completed ? 'Pending' : 'Complete',
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      visualDensity: VisualDensity.compact,
                                      foregroundColor: task.completed
                                          ? Colors.orange.shade800
                                          : Colors.green.shade700,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () => _deleteTask(index),
                                    tooltip: 'Delete Task',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Color _getPriorityBgColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red.shade100;
      case 'Medium':
        return Colors.orange.shade100;
      case 'Low':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getPriorityTextColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red.shade900;
      case 'Medium':
        return Colors.orange.shade900;
      case 'Low':
        return Colors.green.shade900;
      default:
        return Colors.black87;
    }
  }
}
