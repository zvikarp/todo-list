import 'dart:async';
import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_list/models/todo.dart';

/// the sqflite service. it handales all connections between the app and the qslite database
class SqfliteService {
  static final SqfliteService db = SqfliteService();
  Database _database;
  final _todoListStresm = BehaviorSubject<List<Todo>>();
  int _filter = -1;

  void changeFilter(int filter) {
    _filter = filter;
    updateTodoListStream();
  }

  Stream subscribeToTodoListStresm() {
    updateTodoListStream();
    return _todoListStresm.stream;
  }

  void updateTodoListStream() async {
    var todos = await getAllTodos();
    _todoListStresm.add(todos);
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  /// creates a database with a table 'Todo' - if its the first time we are accessing the database
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
          "todoByDate TEXT,"
          "createdOnDate TEXT,"
          "done BOOLEAN,"
          "synced BOOLEAN"
          ")");
    });
  }

  /// creates a new item in the 'Todo' table. the function recives a [Todo]
  Future newTodo(Todo newTodo) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Todo");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Todo (id, title, desc, geo, todoByDate, createdOnDate, done, synced)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [
          id,
          newTodo.title,
          newTodo.desc,
          newTodo.geo,
          newTodo.todoByDate,
          newTodo.createdOnDate,
          newTodo.done,
          newTodo.synced
        ]);
    updateTodoListStream();
    return raw;
  }

  /// updates a existing item in the 'Todo' table by its id. the function recives a [Todo]
  Future updateTodo(Todo todo) async {
    final db = await database;
    todo = unsyncTodo(todo);
    var res = await db.update("Todo", todo.toMap(),
        where: "id = ?", whereArgs: [todo.id]);
    updateTodoListStream();
    return res;
  }

  /// recives one item from the 'Todo' table by a id
  Future getTodo(int id) async {
    final db = await database;
    var res = await db.query("Todo", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromMap(res.first) : null;
  }

  /// toggles the done state of a todo item, the function recives a [Todo]
  Future toggleTodoDone(Todo todo) async {
    todo.done = !todo.done;
    return updateTodo(todo);
  }

  /// if change happend to the todo, unsync it.
  Todo unsyncTodo(Todo todo) {
    todo.synced = false;
    return todo;
  }

  /// returns the full table 'Todo'
  Future<List<Todo>> getAllTodos() async {
    final db = await database;

    var res = (_filter > -1 ) ? await db.query("Todo", orderBy: "todoByDate", where: "done = ?", whereArgs: [_filter]) : await db.query("Todo", orderBy: "todoByDate");
    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  /// deletes a todo by a given id
  Future deleteTodo(int id) async {
    final db = await database;
    var res = await db.delete("Todo", where: "id = ?", whereArgs: [id]);
    updateTodoListStream();
    return res;
  }

  /// deletes a list of todo by a given ids
  Future deleteTodos(List<int> ids) async {
    for (int id in ids) {
      await deleteTodo(id);
    }
    return true;
  }

  /// saves the todo, if its new of old
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
