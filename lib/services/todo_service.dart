import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_tute/models/todo_model.dart';

class TodoService {
  // Reference to the Firestore collection
  //this is the collection reference and the collection name is 'tasks' adn we can access this collection by using the _todoCollection variable

  final CollectionReference _todoCollection =
      FirebaseFirestore.instance.collection('tasks');

  //Method to add a new task to the Firestore collection
  Future<void> addTask(String name) async {
    //create a new task with the name and the current time
    try {
      final task = Todo(
        id: '',
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isUpdated: false,
      );

      //convert the task to a map
      final Map<String, dynamic> data = task.toJson();

      //add the task to the collection
      await _todoCollection.add(data);
      print('Task added');
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  // Methode to get all the tasks from the Firestore collection
  Stream<List<Todo>> getTasks() {
    //return the collection as a stream of snapshots and then map each snapshot to a task
    return _todoCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  //Method to update a task in the Firestore collection
  Future<void> updateTask(Todo task) async {
    try {
      //convert the task to a map
      final Map<String, dynamic> data = task.toJson();

      //update the task in the collection
      await _todoCollection.doc(task.id).update(data);
      print('Task updated');
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  //Method to delete a task from the Firestore collection
  Future<void> deleteTask(String id) async {
    try {
      //delete the task from the collection
      await _todoCollection.doc(id).delete();
      print('Task deleted');
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
