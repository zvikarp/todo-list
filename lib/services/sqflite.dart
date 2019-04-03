import 'dart:async';
import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/methodChannel.dart';

/// the sqflite service. it handales all connections between the app and the qslite database
class SqfliteService {
  static final SqfliteService db = SqfliteService();
  Database _database;
  final _todoListStresm = BehaviorSubject<List<Todo>>();
  final _notSyncedStream = BehaviorSubject<List<int>>();
  int _filter = -1;
  List<int> _notSyncedList = [];

  void changeFilter(int filter) {
    _filter = filter;
    changeWasMadeToTodoList(-1);
  }

  initNotSyncedList() async {
    _notSyncedList.clear();
    List<Todo> todos = await getAllNotSyncedTodos();
    for (Todo todo in todos) {
      _notSyncedList.add(todo.id);
    }
    _notSyncedStream.add(_notSyncedList);
  }

  Stream subscribeToTodoListStresm() {
    changeWasMadeToTodoList(-1);
    return _todoListStresm.stream;
  }

  Stream subscribeToNotSyncedStresm() {
    initNotSyncedList();
    return _notSyncedStream.stream;
  }

  void changeWasMadeToTodoList(int id) async {
    var todos = await getAllTodos();
    _todoListStresm.add(todos);
    if (id > -1) {
      _notSyncedList.add(id);
      _notSyncedStream.add(_notSyncedList);
    }
  }

  void todoWasSynced(int id) {
    _notSyncedList.remove(id);
    if (_notSyncedList.isEmpty) {
      _notSyncedStream.add(_notSyncedList);
    }
  }

  Future todoSynced(int id) async {
    Todo todo = await getTodo(id);
    todo.synced = true;
    return updateTodo(todo, true);
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Todo ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "desc TEXT,"
          "geo TEXT,"
          "dueDate TEXT,"
          "createdOnDate TEXT,"
          "done BOOLEAN,"
          "synced BOOLEAN"
          ")");
    });
  }

  Future newTodo(Todo newTodo) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Todo");
    int id = table.first["id"] ?? 1;
    var raw = await db.rawInsert(
        "INSERT Into Todo (id, title, desc, geo, dueDate, createdOnDate, done, synced)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [
          id,
          newTodo.title,
          newTodo.desc,
          newTodo.geo,
          newTodo.dueDate,
          newTodo.createdOnDate,
          newTodo.done,
          newTodo.synced
        ]);
    changeWasMadeToTodoList(id);
    methodChannelService.addPoint(id, newTodo.geo);
    return raw;
  }

  Future updateTodo(Todo todo, [bool synced = false]) async {
    final db = await database;
    if (!synced) todo = unsyncTodo(todo);
    var res = await db.update("Todo", todo.toMap(),
        where: "id = ?", whereArgs: [todo.id]);
    if (!synced) {
      changeWasMadeToTodoList(todo.id);
      methodChannelService.removePoint(todo.id);
      methodChannelService.addPoint(todo.id, todo.geo);
    }
    return res;
  }

  Future getTodo(int id) async {
    final db = await database;
    var res = await db.query("Todo", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromMap(res.first) : null;
  }

  Future<List<Todo>> getAllNotSyncedTodos() async {
    final db = await database;
    var res = await db.query("Todo", where: "synced = ?", whereArgs: [0]);
    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  Future toggleTodoDone(Todo todo) async {
    todo.done = !todo.done;
    return updateTodo(todo);
  }

  Todo unsyncTodo(Todo todo) {
    todo.synced = false;
    return todo;
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await database;

    var res = (_filter > -1 ) ? await db.query("Todo", orderBy: "dueDate", where: "done = ?", whereArgs: [_filter]) : await db.query("Todo", orderBy: "dueDate");
    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  Future deleteTodo(int id) async {
    final db = await database;
    var res = await db.delete("Todo", where: "id = ?", whereArgs: [id]);
    changeWasMadeToTodoList(id);
    methodChannelService.removePoint(id);
    return res;
  }

  Future deleteTodos(List<int> ids) async {
    for (int id in ids) {
      await deleteTodo(id);
    }
    return true;
  }

  Future saveTodo(Todo todo) async {
    var res;
    if (todo.id < 0) {
      res = await newTodo(todo);
    } else {
      res = await updateTodo(todo);
    }
    return res;
  }
}

final SqfliteService sqfliteService = SqfliteService();
