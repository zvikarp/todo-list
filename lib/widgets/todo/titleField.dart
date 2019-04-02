import 'package:flutter/material.dart';

class TitleFieldWidget extends StatefulWidget {
  TitleFieldWidget({
    Key key,
    this.initText,
    @required this.textChanged
  }) : super(key: key);

  final String initText;
  final void Function(String) textChanged;

  @override
  _TitleFieldWidgetState createState() => _TitleFieldWidgetState();
}

class _TitleFieldWidgetState extends State<TitleFieldWidget> {
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
    return TextField(
      decoration: InputDecoration.collapsed(
        hintText: "Title",
      ),
      autofocus: true,
      controller: ctr,
      onChanged: (text) => widget.textChanged(text),
      style: Theme.of(context).textTheme.headline,
    );
  }
}
