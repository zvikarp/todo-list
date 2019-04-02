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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Due by: ", style: Theme.of(context).textTheme.subtitle,),
          ),
          Text(
            "00:00",
            style: Theme.of(context).textTheme.subtitle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
