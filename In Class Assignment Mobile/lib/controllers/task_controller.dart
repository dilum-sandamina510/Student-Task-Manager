import '../models/task.dart';

class TaskController {
  final List<Task> tasks = [];

  TaskController() {
    // Initial sample tasks as shown in assignment scenario mockup
    tasks.addAll([
      Task(
        title: 'Research Paper',
        category: 'Research',
        priority: 'High',
        completed: false,
      ),
      Task(
        title: 'Mobile App Assignment',
        category: 'Assignment',
        priority: 'High',
        completed: true,
      ),
      Task(
        title: 'Database Lecture',
        category: 'Lecture',
        priority: 'Medium',
        completed: true,
      ),
      Task(
        title: 'Midterm Exam Prep',
        category: 'Exam',
        priority: 'High',
        completed: false,
      ),
      Task(
        title: 'Presentation Preparation',
        category: 'Personal',
        priority: 'Low',
        completed: false,
      ),
    ]);
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }

  void changeStatus(int index) {
    tasks[index].completed = !tasks[index].completed;
  }

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((t) => t.completed).length;
  int get pendingTasks => tasks.where((t) => !t.completed).length;
}
