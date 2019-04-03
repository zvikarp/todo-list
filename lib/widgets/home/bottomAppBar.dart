import 'package:flutter/material.dart';

import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/services/firestore.dart';
import 'package:todo_list/services/methodChannel.dart';

// pretty big class, in future shuld be split to sub-classes

/// the bottom bar of the app, with filter options and sync notifier
class BottomAppBarWidget extends StatefulWidget {
  BottomAppBarWidget({Key key}) : super(key: key);

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> with SingleTickerProviderStateMixin {
  
  AnimationController animationController;

  Map<String, int> _filterItems = {
    'All Tasks': -1,
    'ToDo Tasks': 0,
    'Done Tasks': 1,
  };
  bool _logedin = true;

  String _selectedKey = "All Tasks";

  _updateTodos(idsList) async {
    bool res;
    res = await firestoreService.updateTodosById(idsList);
    print(res.toString() + "dfgdgsgh");
    setState(() {
      _logedin = res;
    });
  }

  _listenToSync() {
    sqfliteService.subscribeToNotSyncedStresm().listen((idsList) {
      if (idsList.length > 0) {
        animationController.forward(from: 0.0);
        _updateTodos(idsList);
      } else {
        animationController.stop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _listenToSync();
    methodChannelService.getLocationUpdates();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );

    animationController.repeat(
    );
  }

  Widget _syncIcon() {
    return new Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: new AnimatedBuilder(
        animation: animationController,
        child: Icon(Icons.sync),
        builder: (BuildContext context, Widget _widget) {
          return new Transform.rotate(
            angle: animationController.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }

  Widget _errorButton() {
    return IconButton(
      icon: Icon(Icons.sync_problem),
      onPressed: () => sqfliteService.initNotSyncedList(),
    );
  }

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
            _logedin ? _syncIcon() : _errorButton(),
          ],
        ),
      ),
    );
  }
}
