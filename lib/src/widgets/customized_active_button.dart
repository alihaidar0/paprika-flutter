import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomizedActiveButton extends StatelessWidget {
  CustomizedActiveButton({@required this.onPressed, this.title});

  final GestureTapCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    //RaisedButton Allows disabling the button by passing null onPressed
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      splashColor: Colors.white30,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
    );
  }
}
