import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paprika/translations.dart';

class NoRestaurantsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        S.of(context).noRestaurantsToView,
      ),
    );
  }
}

class MapLoadingLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitRipple(
          color: Theme.of(context).primaryColor,
        ),
        Text(S.of(context).loadingLocation),
      ],
    );
  }
}
