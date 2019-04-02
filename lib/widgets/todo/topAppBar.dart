import 'package:flutter/material.dart';

class TopAppBarWidget extends StatelessWidget {
  TopAppBarWidget({
    Key key,
    this.pressedSave,
  }) : super(key: key);

  final void Function() pressedSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54,),
          onPressed: () => Navigator.pop(context),
        ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: pressedSave,
          child: Text("SAVE", style: Theme.of(context).accentTextTheme.button,),
        ),
      ],
    );
  }
}
