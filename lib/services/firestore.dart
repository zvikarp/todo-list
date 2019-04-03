import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:todo_list/services/auth.dart';
import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/models/todo.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;

  Future<bool> updateTodo(Todo todo) async {
    String uid = await authService.getUid();
    await _db
        .collection('users')
        .document(uid)
        .collection('todos')
        .document(todo.id.toString())
        .setData({
      'title': todo.title,
      'desc': todo.desc,
      'geo': todo.geo,
      'todoByDate': todo.todoByDate,
      'createdOnDate': todo.createdOnDate,
      'done': todo.done,
      'synced': true
    });
    sqfliteService.todoWasSynced(todo.id);
    return true;
  }

  Future<bool> deleteTodo(int id) async {
    String uid = await authService.getUid();
    await _db
        .collection('users')
        .document(uid)
        .collection('todos')
        .document(id.toString())
        .delete();
    sqfliteService.todoWasSynced(id);
    return true;
  }

  Future<bool> updateTodosById(List<int> ids) async {
    ids.forEach((id) async {
      Todo todo = await sqfliteService.getTodo(id);
      if (todo == null) {
        await deleteTodo(id);
      } else {
        await updateTodo(todo);
      }
    });
    return true;
  }
}

final FirestoreService firestoreService = FirestoreService();
