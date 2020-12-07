import 'package:flutter/material.dart';

class BarLine extends StatelessWidget {
  final double totalWidth, lineHeight;
  final double value;
  final String title;
  final Color mainBarColor;

  BarLine({
    this.lineHeight,
    this.value,
    this.totalWidth,
    this.title,
    this.mainBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      child: Row(
        children: <Widget>[
          Padding(
            padding: Localizations.localeOf(context).languageCode == 'en'
                ? EdgeInsets.fromLTRB(0, 0, 4, 0)
                : EdgeInsets.fromLTRB(4, 0, 0, 0),
            //const EdgeInsets.fromLTRB(0, 0, 4, 0),

            child: Text(
              title,
            ),
          ),
          Container(
            height: lineHeight,
            width: totalWidth,
            decoration: BoxDecoration(
              color: mainBarColor,
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Localizations.localeOf(context).languageCode == 'en'
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: Container(
              height: lineHeight,
              width: (value + 0.01) * totalWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
