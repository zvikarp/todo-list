import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_list/models/todo.dart';

/// the sqflite service. it handales all connections between the app and the qslite database.
class SqfliteService {
  static final SqfliteService db = SqfliteService();
  Database _database;

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

  /// creates a new item in the 'Todo' table. the function recives a [Todo].
  newTodo(Todo newTodo) async {
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
    return raw;
  }

  /// updates a existing item in the 'Todo' table by its id. the function recives a [Todo].
  Future updateTodo(Todo newTodo) async {
    final db = await database;
    var res = await db.update("Todo", newTodo.toMap(),
        where: "id = ?", whereArgs: [newTodo.id]);
    return res;
  }

  /// recives one item from the 'Todo' table by a id.
  Future getTodo(int id) async {
    final db = await database;
    var res = await db.query("Todo", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromMap(res.first) : null;
  }

  /// returns the full table 'Todo'
  Future<List<Todo>> getAllTodos() async {
    print("test 3");
    final db = await database;
    var res = await db.query("Todo");
    print(res.map((c) => Todo.fromMap(c)).toList());
    List<Todo> list = res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    print(list);
    return list;
  }

  /// deletes a todo by a given id.
  Future deleteTodo(int id) async {
    final db = await database;
    return db.delete("Todo", where: "id = ?", whereArgs: [id]);
  }

}

final SqfliteService sqfliteService = SqfliteService();