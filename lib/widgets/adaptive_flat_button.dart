import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback presentDatePicker;

  const AdaptiveFlatButton(this.text, this.presentDatePicker, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: presentDatePicker,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: presentDatePicker,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
