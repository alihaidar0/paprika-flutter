import 'package:flutter/material.dart';
import 'package:paprica/src/widgets/custom_radio_button.dart';

typedef RadioTabCallback(String value);

class StringRadioButton extends StatelessWidget {
  final String value;
  final String radioValue;
  final RadioTabCallback onRadioTab;

  final Duration duration;

  final EdgeInsets padding;

  StringRadioButton(this.value, {this.padding, this.radioValue, this.onRadioTab, this.duration = const Duration(milliseconds: 600)});

  @override
  Widget build(BuildContext context) {
    return CustomRadio<String, dynamic>(
      duration: this.duration,
      value: value,
      groupValue: radioValue,
      animsBuilder: (AnimationController controller) => [
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        ColorTween(begin: Colors.white, end: Theme.of(context).primaryColor).animate(controller),
        ColorTween(begin: Theme.of(context).primaryColor, end: Colors.white).animate(controller),
        ColorTween(begin: Theme.of(context).primaryColor, end: Theme.of(context).primaryColor).animate(controller),
      ],
      builder: (BuildContext context, List<dynamic> animValues, Function updateState, String value) {
        return GestureDetector(
          onTap: () {
            onRadioTab(value);
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Card(
              color: animValues[1],
              child: Padding(
                padding: this.padding??const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.body1.copyWith(fontSize: 13.0, color: animValues[2]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
