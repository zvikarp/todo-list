import 'package:flutter/material.dart';

/// the top bar of the app
class TopAppBarWidget extends StatelessWidget {
  TopAppBarWidget({Key key}) : super(key: key);

  // TODO: make it taller
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).canvasColor,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Text(
          "Todo List",
          style: Theme.of(context).textTheme.headline,
        ),
      ),
      floating: true,
    );
  }
}
