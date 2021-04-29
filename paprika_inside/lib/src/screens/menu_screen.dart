import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paprika_inside/screens.dart';
import 'package:paprika_inside/src/widgets/custom_gesture_detector_menu.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage('packages/paprika_inside/assets/images/menu.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.count(
                  primary: false,
                  padding: EdgeInsets.only(
                      left: 20,
                      top: (MediaQuery.of(context).size.height) * 0.3,
                      right: 20,
                      bottom: 20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.width - 40) * 0.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 40) *
                                0.5 *
                                0.1,
                          ),
                          SvgPicture.asset(
                            "packages/paprika_inside/assets/icons/food_menu.svg",
                            width: 55.0,
                            height: 55.0,
                          ),
                          Text(
                            'Food Menu',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 40) *
                                0.5 *
                                0.1,
                          ),
                        ],
                      ),
                    ),
                    CustomGestureDetectorMenu(
                        title: 'Get Assistant',
                        imagePath:
                            "packages/paprika_inside/assets/icons/get_assistant.svg",
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return GetAssistantScreen();
                          }));
                        }),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //         MaterialPageRoute(builder: (BuildContext context) {
                    //       return GetAssistantScreen();
                    //     }));
                    //   },
                    //   child: Card(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(
                    //             (MediaQuery.of(context).size.width - 40) *
                    //                 0.5)),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         SizedBox(
                    //           height: (MediaQuery.of(context).size.width - 40) *
                    //               0.5 *
                    //               0.1,
                    //         ),
                    //         SvgPicture.asset(
                    //           "packages/paprika_inside/assets/icons/get_assistant.svg",
                    //           width: 55.0,
                    //           height: 55.0,
                    //         ),
                    //         Text(
                    //           'Get Assistant',
                    //           style: TextStyle(
                    //             fontSize: 22.0,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: (MediaQuery.of(context).size.width - 40) *
                    //               0.5 *
                    //               0.1,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.width - 40) * 0.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 40) *
                                0.5 *
                                0.1,
                          ),
                          SvgPicture.asset(
                            "packages/paprika_inside/assets/icons/invoice.svg",
                            width: 55.0,
                            height: 55.0,
                          ),
                          Text(
                            'Invoice',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 40) *
                                0.5 *
                                0.1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.95,
              minChildSize: 0.15,
              initialChildSize: 0.15,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          padding: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Food Menu',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Food Menu',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Food Menu',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Food Menu',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Arc(
                          arcType: ArcType.CONVEX,
                          edge: Edge.TOP,
                          height: 60.0,
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.4,
                            color: Colors.white,
                            child: Center(
                                child: Text(
                              'Your Order',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 22.0),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
