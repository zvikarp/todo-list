import 'package:flutter/material.dart';

import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/pages/todo.dart';

/// add todo button
class AddTodoButtonWidget extends StatelessWidget {
  AddTodoButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        // onPressed: () { // TODO: open a dialog to create a new todo. the current function is 100% temporary
        //   sqfliteService.newTodo(Todo(
        //     title: "title",
        //     desc: "desc",
        //     createdOnDate: "now",
        //     done: false,
        //     synced: false,
        //     geo: "geo location",
        //     todoByDate: "soon",
        //   ));
        // },
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TodoPage())),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        tooltip: 'Increment',
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
      ),
    );
  }
}
