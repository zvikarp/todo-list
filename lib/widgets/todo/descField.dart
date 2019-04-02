import 'package:flutter/material.dart';

class DescFieldWidget extends StatefulWidget {
  DescFieldWidget({Key key, this.initText, @required this.textChanged})
      : super(key: key);

  final String initText;
  final void Function(String) textChanged;

  @override
  _DescFieldWidgetState createState() => _DescFieldWidgetState();
}

class _DescFieldWidgetState extends State<DescFieldWidget> {
  final TextEditingController ctr = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      ctr.text = widget.initText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.description,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: "Description",
              ),
              autofocus: true,
              controller: ctr,
              maxLines: 3,
              onChanged: (text) => widget.textChanged(text),
            ),
          ),
        ],
      ),
    );
  }
}
