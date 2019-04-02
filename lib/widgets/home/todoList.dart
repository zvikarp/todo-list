import 'package:flutter/material.dart';

import 'package:todo_list/widgets/home/todoTile.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/services/logic.dart';

import 'package:todo_list/widgets/home/topAppBar.dart';

// the list of todo tiles
class TodoListWidget extends StatelessWidget {
  TodoListWidget({Key key}) : super(key: key);
  List<int> _selectedTodos = [];

  void _updateSelectedCounter() {
    logicService.updateSelectedTodos(_selectedTodos);
  }

  bool _todoSelectToggle(int id, int type, bool isSelected) {
    if (isSelected) {
      _selectedTodos.remove(id);
      _updateSelectedCounter();
      return false;
    } else {
      if (type == 1) {
        _selectedTodos.add(id);
        _updateSelectedCounter();
        return true;
      } else {
        if (logicService.getSelectedTodos().length > 0) {
          _selectedTodos.add(id);
          _updateSelectedCounter();
          return true;
        } else {
          return false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: sqfliteService.subscribeToTodoListStresm(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          int length = 0;
          if (snapshot.hasData) {
            length += snapshot.data.length;
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 24),
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (BuildContext context, index) {
              if (index == 0) return TopAppBarWidget();
              Todo todoItem = snapshot.data[index];
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
