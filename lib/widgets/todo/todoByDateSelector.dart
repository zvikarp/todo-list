import 'package:flutter/material.dart';

import 'package:todo_list/utils/dateTime.dart';

class TodoByDateSelectorWidget extends StatefulWidget {
  TodoByDateSelectorWidget({
    Key key,
    this.initDueDate,
    this.dueDateChanged,
  }) : super(key: key);

  @override
  _TodoByDateSelectorWidgetState createState() =>
      _TodoByDateSelectorWidgetState();

  final DateTime initDueDate;
  final void Function(DateTime) dueDateChanged;
}

class _TodoByDateSelectorWidgetState extends State<TodoByDateSelectorWidget> {
  DateTime _dueDate;

  _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dueDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _dueDate.hour,
          _dueDate.minute,
        );
      });
      widget.dueDateChanged(_dueDate);
    }
  }

  _selectTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _dueDate.hour, minute: _dueDate.minute),
    );
    if (picked != null) {
      setState(() {
        _dueDate = DateTime(
          _dueDate.year,
          _dueDate.month,
          _dueDate.day,
          picked.hour,
          picked.minute,
        );
      });
      widget.dueDateChanged(_dueDate);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _dueDate = widget.initDueDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Due by: ",
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          GestureDetector(
            onTap: _selectTime,
            child: Text(
              dateTimeUtil.time(_dueDate),
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: _selectDate,
              child: Text(
                dateTimeUtil.date(_dueDate),
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
