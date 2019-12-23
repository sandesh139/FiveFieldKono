import 'package:flutter/material.dart';

class WinnerDialogue extends StatelessWidget {
  final title;
  final message;
  final Function function;
  

  WinnerDialogue(this.title, this.function, this.message);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text(title),
      content: new Text("helllow"),
      actions: <Widget>[
        new FlatButton(
          onPressed: function,
          color: Colors.white,
          child: new Text("Reset"),
        )
      ],
    );
  }
}