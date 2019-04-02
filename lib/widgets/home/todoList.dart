import 'package:flutter/material.dart';
import 'package:todo_list/widgets/home/todoTile.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/sqflite.dart';

import 'package:todo_list/widgets/home/topAppBar.dart';

// the list of todo tiles
class TodoListWidget extends StatelessWidget {
  TodoListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
        future: sqfliteService.getAllTodos(),
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
                title: todoItem.title,
              );
            },
            separatorBuilder: (BuildContext context, index) {
              if (index == 0) return Container();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              );
            },
          );
        });
  }
}
