import 'package:flutter/material.dart';

import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo/titleField.dart';
import 'package:todo_list/widgets/todo/descField.dart';
import 'package:todo_list/widgets/todo/todoByDateSelector.dart';
import 'package:todo_list/widgets/todo/geoSelector.dart';

/// the page to create, display and edit todos
class TodoPage extends StatefulWidget {
  TodoPage({
    Key key,
    this.id = -1,
    this.done,
    this.initTitle = "",
    this.initDesc = "",
    this.initGeo = "",
    this.initTodoByDate = "",
  }) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();

  final int id;
  final bool done;
  final String initTitle;
  final String initDesc;
  final String initTodoByDate;
  final String initGeo;
}

class _TodoPageState extends State<TodoPage> {
  String _title;
  String _desc;
  String _todoByDate;
  String _geo;

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

  @override
  void initState() {
    super.initState();
    _titleChanged(widget.initTitle);
    _descChanged(widget.initDesc);
    _todoByDateChanged(widget.initTodoByDate);
    _geoChanged(widget.initGeo);
  }

  void _saveButtonPressed() {
    Todo newTodo = Todo(
      id: widget.id,
      title: _title,
      desc: _desc,
      createdOnDate: DateTime.now().toString(),
      todoByDate: _todoByDate,
      done: widget.done,
      geo: _geo,
      synced: false,
    );
    sqfliteService.saveTodo(newTodo);
  }

  Widget _saveButton() {
    return FlatButton(
      onPressed: _saveButtonPressed,
      child: Text("Save"),
    );
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
                _saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
