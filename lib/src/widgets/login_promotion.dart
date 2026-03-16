import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../translations.dart';

class LogInPromotion extends StatelessWidget {
  final String loginLine;

  const LogInPromotion({Key key, this.loginLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        this.loginLine != null && this.loginLine.isNotEmpty
            ? Text(this.loginLine)
            : Text(S.of(context).pleaseLogIn),
        GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/logIn', ModalRoute.withName('/home'));
            },
            child: Text(
              S.of(context).logIn,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
        )
      ],
    ));
  }
}
