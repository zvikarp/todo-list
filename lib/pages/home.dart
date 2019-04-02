import 'package:flutter/material.dart';

import 'package:todo_list/widgets/home/bottomAppBar.dart';
import 'package:todo_list/widgets/home/bottomFloatingButton.dart';
import 'package:todo_list/widgets/home/todoList.dart';

// home page, containes the list of all todos and navigation buttons
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: TodoListWidget()),
      bottomNavigationBar: BottomAppBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFloationgButtonWidget(),
    );
  }
}
