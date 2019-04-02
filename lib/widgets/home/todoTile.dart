import 'package:flutter/material.dart';

// a todo tile
class TodoTileWidget extends StatelessWidget {
  TodoTileWidget({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;
  // TODO: add all other stuff (or just pass a User object)

  Widget _checkBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.title,
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            "task description",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Widget _dueDate(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "03:40 12/05/19",
        style: TextStyle(
          fontSize: 10.0, fontFamily: 'Lato', color: Colors.green, fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _checkBox(context),
          _mainContent(context),
          _dueDate(context),
        ],
      ),
    );
  }
}
