import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paprika_inside/widgets.dart';

class GetAssistantScreen extends StatefulWidget {
  @override
  _GetAssistantScreenState createState() => _GetAssistantScreenState();
}

class _GetAssistantScreenState extends State<GetAssistantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'packages/paprika_inside/assets/images/get_assistant.png'),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'packages/paprika_inside/assets/icons/get_assistant_red.svg',
                      width: 55.0,
                      height: 55.0,
                    ),
                    Text(
                      'Get Assistant',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              GridView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.only(
                    left: 20,
                    top: (MediaQuery.of(context).size.height) * 0.1,
                    right: 20,
                    bottom: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                children: <Widget>[
                  CustomGestureDetectorGetAssistant(
                    title: 'Shish Guy',
                    imagePath:
                        "packages/paprika_inside/assets/icons/shisha_guy.svg",
                    onPressed: () {},
                  ),
                  CustomGestureDetectorGetAssistant(
                    title: 'Service',
                    imagePath:
                        "packages/paprika_inside/assets/icons/service.svg",
                    onPressed: () {},
                  ),
                  CustomGestureDetectorGetAssistant(
                    title: 'Wifi Password',
                    imagePath:
                        "packages/paprika_inside/assets/icons/wifi_password.svg",
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
