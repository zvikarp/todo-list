import 'package:flutter/material.dart';

/// the top bar of the app
class TopAppBarWidget {

  // TODO: make it taller
  // TODO: fixup styling
  // TODO: check why can't create a statless class
  AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "Todo List",
          style: Theme.of(context).textTheme.headline,
        ),
    );
  }
}
