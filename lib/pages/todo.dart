import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/utils/dateTime.dart';
import 'package:todo_list/utils/latLng.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo/topAppBar.dart';
import 'package:todo_list/widgets/todo/titleField.dart';
import 'package:todo_list/widgets/todo/descField.dart';
import 'package:todo_list/widgets/todo/dueDateSelector.dart';
import 'package:todo_list/widgets/todo/geoSelector.dart';

/// the page to create, display and edit todos
class TodoPage extends StatefulWidget {
  TodoPage({
    Key key,
    this.todo,
  }) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();

  final Todo todo;
}

class _TodoPageState extends State<TodoPage> {
  String _title = "";
  String _desc = "";
  DateTime _dueDate = DateTime.now();
  LatLng _geo = LatLng(32.0667, 34.7667);
  double _zoom = 14.0;
  bool _done = false;
  int _id = -1;

  void _titleChanged(String title) {
    setState(() {
      _title = title;
    });
  }

  void _descChanged(String desc) {
    setState(() {
      _desc = desc;
    });
  }

  void _geoChanged(LatLng geo, double zoom) {
    setState(() {
      _geo = geo;
      _zoom = zoom;
    });
  }

  void _dueDateChanged(DateTime dueDate) {
    setState(() {
      _dueDate = dueDate;
    });
  }

  void _getTodo() async {
    if (widget.todo != null) {
      List<dynamic> geo = latLngUtil.stringToLatLng(widget.todo.geo);
      _titleChanged(widget.todo.title);
      _descChanged(widget.todo.desc);
      _dueDateChanged(dateTimeUtil.stringToDate(widget.todo.dueDate));
      _geoChanged(geo[0], geo[1]);
      setState(() {
       _done = widget.todo.done;
       _id = widget.todo.id;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getTodo();
  }

  void _saveButtonPressed() {
    if (_title == "") return;
    Todo newTodo = Todo(
      id: _id,
      title: _title,
      desc: _desc,
      createdOnDate: DateTime.now().toString(),
      dueDate: dateTimeUtil.dateToString(_dueDate),
      done: _done,
      geo: latLngUtil.latLngToString(_geo, _zoom),
      synced: false,
    );
    sqfliteService.saveTodo(newTodo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                TopAppBarWidget(
                  pressedSave: _saveButtonPressed,
                ),
                TitleFieldWidget(
                  initText: _title,
                  textChanged: _titleChanged,
                ),
                DescFieldWidget(
                  initText: _desc,
                  textChanged: _descChanged,
                ),
                DueDateSelectorWidget(
                  initDueDate: _dueDate,
                  dueDateChanged: _dueDateChanged,
                ),
                GeoSelectorWidget(
                  initGeo: _geo,
                  initZoom: _zoom,
                  geoChanged: _geoChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
