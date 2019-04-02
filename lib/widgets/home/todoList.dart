import 'package:flutter/material.dart';
import 'package:todo_list/widgets/home/todoTile.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/sqflite.dart';

// the list of todo tiles
class TodoListWidget extends StatelessWidget {
  TodoListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
        future: sqfliteService.getAllTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder:(BuildContext context, index) {
                    Todo todoItem = snapshot.data[index];
                    return TodoTileWidget(
                      title: todoItem.title,
                    );
                  },
            );
          } else {
            // TODO: return a proper empty space container
            return Container();
          }
        });
  }
}
