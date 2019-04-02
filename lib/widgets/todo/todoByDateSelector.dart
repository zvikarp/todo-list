import 'package:flutter/material.dart';

class TodoByDateSelectorWidget extends StatelessWidget {
  TodoByDateSelectorWidget({Key key}) : super(key: key);

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
          SizedBox(
            width: 16.0,
          ),
          Container(
            child: Text(
              "00:00",
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Container(
            child: Text(
              "DD/MM/YYYY",
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
