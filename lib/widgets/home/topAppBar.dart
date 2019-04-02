import 'package:flutter/material.dart';

/// the top bar of the app
class TopAppBarWidget extends StatelessWidget {
  TopAppBarWidget({Key key}) : super(key: key);

  // TODO: make it taller
  // TODO: fixup styling
  // TODO: check why can't create a statless class
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
