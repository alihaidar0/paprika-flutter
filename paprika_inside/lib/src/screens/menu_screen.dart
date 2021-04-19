import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  padding: EdgeInsets.only(left: 20, top: (MediaQuery.of(context).size.height) * 0.3, right: 20, bottom: 20),
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
                            height: (MediaQuery.of(context).size.width - 40)*0.5*0.1,
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
                            height: (MediaQuery.of(context).size.width - 40)*0.5*0.1,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.width - 40) * 0.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 40)*0.5*0.1,
                          ),
                          SvgPicture.asset(
                            "packages/paprika_inside/assets/icons/get_assistant.svg",
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
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 40)*0.5*0.1,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.width - 40) * 0.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 40)*0.5*0.1,
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
                            height: (MediaQuery.of(context).size.width - 40)*0.5*0.1,
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
              minChildSize: 0.09,
              initialChildSize: 0.09,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
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
                        ),Text(
                          'Food Menu',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                        ),Text(
                          'Food Menu',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
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
