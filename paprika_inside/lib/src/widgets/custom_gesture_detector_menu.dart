import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomGestureDetectorMenu extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String title;
  final String imagePath;

  CustomGestureDetectorMenu({
    @required this.onPressed,
    this.title,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              (MediaQuery.of(context).size.width - 40) * 0.5)),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.width - 40) * 0.5 * 0.1,
            ),
            SvgPicture.asset(
              imagePath,
              width: 55.0,
              height: 55.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.width - 40) * 0.5 * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
