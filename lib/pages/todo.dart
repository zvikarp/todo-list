import 'package:flutter/material.dart';

import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo/topAppBar.dart';
import 'package:todo_list/widgets/todo/titleField.dart';
import 'package:todo_list/widgets/todo/descField.dart';
import 'package:todo_list/widgets/todo/todoByDateSelector.dart';
import 'package:todo_list/widgets/todo/geoSelector.dart';

/// the page to create, display and edit todos
class TodoPage extends StatefulWidget {
  TodoPage({
    Key key,
    this.id = -1,
  }) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();

  final int id;
}

class _TodoPageState extends State<TodoPage> {
  String _title = "";
  String _desc = "";
  String _todoByDate = "";
  String _geo = "";
  bool _done = false;

  void _titleChanged(String title) {
    print(title);
    setState(() {
      _title = title;
    });
  }

  void _descChanged(String desc) {
    setState(() {
      _desc = desc;
    });
  }

  void _todoByDateChanged(String todoByDate) {
    setState(() {
      _todoByDate = todoByDate;
    });
  }

  void _geoChanged(String geo) {
    setState(() {
      _geo = geo;
    });
  }

  void _getTodo() async {
    if (widget.id > -1) {
      Todo todo = await sqfliteService.getTodo(widget.id);
      print("hi!");
      _titleChanged(todo.title);
      _descChanged(todo.desc);
      _todoByDateChanged(todo.todoByDate);
      _geoChanged(todo.geo);
      setState(() {
       _done = todo.done; 
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getTodo();
  }

  void _saveButtonPressed() {
    Todo newTodo = Todo(
      id: widget.id,
      title: _title,
      desc: _desc,
      createdOnDate: DateTime.now().toString(),
      todoByDate: _todoByDate,
      done: _done,
      geo: _geo,
      synced: false,
    );
    sqfliteService.saveTodo(newTodo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                TopAppBarWidget(
                  pressedSave: _saveButtonPressed,
                ),
                TitleFieldWidget(
                  initText: _title,
                  textChanged: _titleChanged,
                ),
                DescFieldWidget(
                  initText: _desc,
                  textChanged: _descChanged,
                ),
                TodoByDateSelectorWidget(),
                GeoSelectorWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
