import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

class InsideHomeScreen extends StatefulWidget {
  @override
  _InsideHomeScreenState createState() => _InsideHomeScreenState();
}

class _InsideHomeScreenState extends State<InsideHomeScreen> {
  SoftUpPaprikaInsideAfterDishesAfterDishDto a;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inside'),
      ),
    );
  }
}
