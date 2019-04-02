import 'package:flutter/material.dart';

/// the bottom bar of the app
class BottomAppBarWidget extends StatelessWidget {
  BottomAppBarWidget({Key key}) : super(key: key);

  // TODO: make shdow match the 'add todo' button
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.filter_list),
            SizedBox(
              width: 200.0,
            ),
            Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
