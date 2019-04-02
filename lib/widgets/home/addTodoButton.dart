import 'package:flutter/material.dart';

/// add todo button
class AddTodoButtonWidget extends StatelessWidget {
  AddTodoButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
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
