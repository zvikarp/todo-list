import 'package:flutter/material.dart';

import 'package:todo_list/widgets/home/todoTile.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/services/logic.dart';
import 'package:todo_list/pages/todo.dart';

import 'package:todo_list/widgets/home/topAppBar.dart';

/// the list of todo tiles
class TodoListWidget extends StatefulWidget {
  TodoListWidget({Key key}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  Future<bool> _goToTodoPage(BuildContext context, int id) async {
    Todo todo = await sqfliteService.getTodo(id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => TodoPage(todo: todo,)));
    return false;
  }

  bool _todoSelectToggle(BuildContext context, int id, int type) {
    if (logicService.checkSelectedTodo(id)) {
      logicService.removeTodoFromSelected(id);
      return false;
    } else {
      if (type == 1) {
        logicService.addSelectedTodo(id);
        return true;
      } else {
        if (logicService.getSelectedTodos().length > 0) {
          logicService.addSelectedTodo(id);
          return true;
        } else {
          _goToTodoPage(context, id);
          return false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: sqfliteService.subscribeToTodoListStresm(),
        builder: (BuildContext context, snapshot) {
          int length = 1;
          if (snapshot.hasData) {
            length += snapshot.data.length;
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 24),
            itemCount: length,
            itemBuilder: (BuildContext context, index) {
              if (index == 0) return TopAppBarWidget();
              Todo todoItem = snapshot.data[index-1];
              return TodoTileWidget(
                todo: todoItem,
                todoItemSelect: _todoSelectToggle,
              );
            },
            separatorBuilder: (BuildContext context, index) {
              if (index == 0) return Container();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  height: 0,
                ),
              );
            },
          );
        });
  }
}
