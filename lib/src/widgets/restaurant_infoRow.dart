import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final AssetImage icon;
  final TextDirection textDirection;

  InfoRow({this.icon, this.title, this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: Localizations.localeOf(context).languageCode == 'en'
              ? const EdgeInsets.fromLTRB(0, 8, 8, 8)
              : const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Image(
            image: this.icon,
            width: 0.05 * MediaQuery.of(context).size.width,
            height: 0.05 * MediaQuery.of(context).size.width,
            filterQuality: FilterQuality.high,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.36,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  this.title,
                  textDirection: this.textDirection,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class WideInfoRow extends StatelessWidget {
  final String title;
  final AssetImage icon;
  final TextDirection textDirection;

  WideInfoRow({this.icon, this.title, this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: Localizations.localeOf(context).languageCode == 'en'
              ? const EdgeInsets.fromLTRB(0, 8, 8, 8)
              : const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Image(
            image: this.icon,
            width: 0.05 * MediaQuery.of(context).size.width,
            height: 0.05 * MediaQuery.of(context).size.width,
            filterQuality: FilterQuality.high,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  this.title,
                  textDirection: this.textDirection,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
