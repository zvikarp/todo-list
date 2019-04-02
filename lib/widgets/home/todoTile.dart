import 'package:flutter/material.dart';

import 'package:todo_list/services/sqflite.dart';
import 'package:todo_list/models/todo.dart';

// a todo tile
class TodoTileWidget extends StatefulWidget {
  TodoTileWidget({
    Key key,
    @required this.todoItemSelect,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;
  final bool Function(int, int, bool) todoItemSelect;

  @override
  _TodoTileWidgetState createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends State<TodoTileWidget> {
  bool selected = false;

  void _deleteTodo() {
    sqfliteService.deleteTodo(this.widget.todo.id);
  }

  void _toggleCheckBox() {
    sqfliteService.toggleTodoDone(widget.todo);
  }

  void _onTodoSelected(int type) {
      bool newSelected = widget.todoItemSelect(this.widget.todo.id, type, selected);
      setState(() {
       selected = newSelected; 
      });

  }

  Widget _checkBox(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckBox,
      child: _toggleCheckBoxButton(context),
    );
  }

  Widget _toggleCheckBoxButton(BuildContext context) {
    if (selected) {
      return Container(
        margin: EdgeInsets.all(16.0),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).primaryColor,
        ),
      );
    } else if (widget.todo.done) {
      return Container(
        margin: EdgeInsets.all(16.0),
        width: 20,
        height: 20,
        child: Transform.translate(
          offset: Offset(-4, -4),
          child: Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(16.0),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      );
    }
  }

  Widget _mainContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.widget.todo.title,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Overpass',
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              decoration: widget.todo.done
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          Text(
            this.widget.todo.desc,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Widget _dueDate(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        this.widget.todo.todoByDate + "03:40 12/05/19",
        style: TextStyle(
          fontSize: 10.0,
          fontFamily: 'Lato',
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _deleteButton() {
    return IconButton(
      onPressed: _deleteTodo,
      icon: Icon(
        Icons.delete_outline,
        color: Colors.red[200],
      ),
    );
  }

  Widget _swipeToDeleteBackground() {
    return Container(
      alignment: Alignment(1, 0),
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.todo.id.toString()),
      direction: DismissDirection.endToStart,
      background: _swipeToDeleteBackground(),
      onDismissed: (direction) {
        _deleteTodo();
        // Scaffold.of(context).showSnackBar(
        //     SnackBar(content: Text(todo.id.toString() + " dismissed")));
      },
      child: GestureDetector(
        onLongPress: () => _onTodoSelected(1),
        onTap: () => _onTodoSelected(0),
        child: Container(
          color: selected ? Colors.grey[300] : Theme.of(context).canvasColor,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: <Widget>[
              _checkBox(context),
              _mainContent(context),
              _dueDate(context),
              _deleteButton(),
            ],
          ),
        ),
      ),
    );
  }
}
