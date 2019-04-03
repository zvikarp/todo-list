import 'package:flutter/material.dart';

/// the top bar of the app
class TopAppBarWidget extends StatelessWidget {
  TopAppBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Center(
        child: Text(
          "Todo List",
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }
}
