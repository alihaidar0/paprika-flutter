import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomizedInactiveButton extends StatelessWidget {
  CustomizedInactiveButton({@required this.onPressed, this.title, this.padding});

  final GestureTapCallback onPressed;
  final String title;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    //RaisedButton Allows disabling the button by passing null onPressed
    return RaisedButton(
      color: Colors.white,
      splashColor: Colors.white70,
      child: Padding(
        padding: this.padding??const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 10.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 12,
          ),
        ),
      ),
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
    );
  }
}
