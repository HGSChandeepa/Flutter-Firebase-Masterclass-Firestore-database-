import 'package:flutter/material.dart';
import 'package:firebase_flutter_tute/services/todo_service.dart'; // Import the TodoService
import 'package:firebase_flutter_tute/models/todo_model.dart'; // Import the Todo model

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _taskController = TextEditingController();
  final TodoService _todoService =
      TodoService(); // Create an instance of TodoService

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              hintText: 'Enter task name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without saving
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Add the task to Firestore using TodoService
                await _todoService.addTask(_taskController.text);
                _taskController.clear();
                Navigator.of(context).pop(); // Close the dialog after saving
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskBottomSheet(Todo task) {
    _taskController.text = task.name;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      // Update the task in Firestore using TodoService
                      task.name = _taskController.text;
                      task.updatedAt = DateTime.now();
                      task.isUpdated = true;

                      await _todoService.updateTask(task);
                      _taskController.clear();
                      Navigator.of(context)
                          .pop(); // Close the bottom sheet after saving
                    },
                    child: const Text('Update Task'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _todoService.getTasks(), // Listen to the stream of tasks
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available'));
          } else {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Created: ${task.createdAt}'),
                        Text('Updated: ${task.updatedAt}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Delete the task from Firestore using TodoService
                        _todoService.deleteTask(task.id);
                      },
                    ),
                    onTap: () {
                      _showEditTaskBottomSheet(task);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
