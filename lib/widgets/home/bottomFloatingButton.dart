import 'package:flutter/material.dart';

import 'package:todo_list/services/logic.dart';
import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/pages/todo.dart';

/// add todo button
class BottomFloationgButtonWidget extends StatefulWidget {
  BottomFloationgButtonWidget({Key key}) : super(key: key);

  @override
  _BottomFloationgButtonWidgetState createState() => _BottomFloationgButtonWidgetState();
}

class _BottomFloationgButtonWidgetState extends State<BottomFloationgButtonWidget> {
    List<int> _selectedTodos = [];

  void _getSelectedUpdates() {
    logicService.subscribeToSelectedTodosStresm().listen((selectedTodos) {
      setState(() {
        _selectedTodos = selectedTodos;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getSelectedUpdates();
  }

  Widget _addNewTodoButton () {
    return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TodoPage())),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add,
            ),
            Text(
              "Add new todo",
            ),
          ],
        ),
      );
  }
  void _deleteSelectedTodosById() async {
    await sqfliteService.deleteTodos(_selectedTodos);
    List<int> nonSelected = [];
    logicService.updateSelectedTodos(nonSelected);
  }

  Widget _deleteSelectedTodos () {
    return FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: _deleteSelectedTodosById,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.delete_outline,
            ),
            Text(
              "Delete " + _selectedTodos.length.toString() + " todos",
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: _selectedTodos.length == 0 ? _addNewTodoButton() : _deleteSelectedTodos(),
    );
  }
}
