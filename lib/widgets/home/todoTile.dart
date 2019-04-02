import 'package:flutter/material.dart';

// a todo tile
class TodoTileWidget extends StatelessWidget {
  TodoTileWidget({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;
  // TODO: add all other stuff (or just pass a User object)

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // TODO: well, yea. finish the tile.
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(
        "task description",
        style: Theme.of(context).textTheme.subtitle,
      ),
      leading: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            )),
      ),
    );
  }
}
