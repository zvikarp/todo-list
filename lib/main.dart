import 'package:flutter/material.dart';
import 'package:todo_list/utils/theme.dart';

import 'package:todo_list/pages/home.dart';

void main() => runApp(TodoListApp());

// the main widget that containes the app
class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: themeUtil.getTheme(),
      home: HomePage(),
    );
  }
}