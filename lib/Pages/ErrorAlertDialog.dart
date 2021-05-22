import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Login.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;

  const ErrorAlertDialog({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => Login());
            Navigator.pushReplacement(context, route);
          },
          child: Center(
            child: Text('OK'),
          ),
        )
      ],
    );
  }
}
