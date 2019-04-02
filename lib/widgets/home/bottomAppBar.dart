import 'package:flutter/material.dart';

import 'package:todo_list/services/sqflite.dart';

/// the bottom bar of the app
class BottomAppBarWidget extends StatefulWidget {
  BottomAppBarWidget({Key key}) : super(key: key);

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  Map<String, int> _filterItems = {
    'All Tasks': -1,
    'ToDo Tasks': 0,
    'Done Tasks': 1,
  };

  String _selectedKey = "All Tasks";

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PopupMenuButton<String>(
              child: Icon(Icons.filter_list),
              onSelected: (key) {
                setState(() {
                  _selectedKey = key;
                });
                sqfliteService.changeFilter(_filterItems[key]);
              },
              itemBuilder: (BuildContext context) => _filterItems.keys
                  .map(
                    (String key) => PopupMenuItem<String>(
                          value: key,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (key == _selectedKey)
                                    ? Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : Container(
                                        width: 24,
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  key,
                                  style: TextStyle(
                                    color: (key == _selectedKey)
                                        ? Theme.of(context).primaryColor
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  )
                  .toList(),
            ),
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
