import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  bool isUpdated;

  Todo({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isUpdated,
  });

  // Factory constructor to create a Todo from a Firestore document
  factory Todo.fromJson(Map<String, dynamic> doc, String id) {
    return Todo(
      id: id,
      name: doc['name'],
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
      updatedAt: (doc['updatedAt'] as Timestamp).toDate(),
      isUpdated: doc['isUpdated'],
    );
  }

  // Convert a Todo to a map to save to Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isUpdated': isUpdated,
    };
  }
}
