import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprika_inside/screens.dart';
import 'package:paprika_inside/utils.dart';
import 'package:paprika_inside/widgets.dart';
import 'package:swagger_inside/api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String lang = "ar";
  static String tenant = 'e6f62669-bfc5-56da-227a-39f8e0b92d0a';
  Future<RestaurantsRestaurantDto> _restaurantProfileFuture;
  RestaurantsRestaurantDto _restaurantProfile;
  List<bool> _button = [];

  @override
  void initState() {
    super.initState();
    PaprikaInsideApiClient().setLang(lang);
    PaprikaInsideApiClient().setTenant(tenant);
    _getRestaurantProfile();
    _button.add(false);
    _button.add(false);
    _button.add(false);
  }

  Future _getRestaurantProfile() {
    ApiClient client = PaprikaInsideApiClient();
    CustomerRestaurantApi api = CustomerRestaurantApi(client);
    setState(() {
      _restaurantProfileFuture =
          api.apiAppCustomerRestaurantRestaurantProfileGet();
    });
    _restaurantProfileFuture.then((_) {
      print(_restaurantProfileFuture.toString());
    }).catchError((err) {
      print(err);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantsRestaurantDto>(
        future: _restaurantProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _restaurantProfile = snapshot.data;
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'packages/paprika_inside/assets/images/background.png'),
                      fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            _restaurantProfile.logoImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            _restaurantProfile.welcomeMessage,
                            textDirection:
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Welcome',
                            textDirection:
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width *
                                  0.25 *
                                  0.4,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _button[0] = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: _button[0]
                                        ? Border.all(color: Colors.black)
                                        : Border.all(color: Colors.transparent),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'French',
                                      style: TextStyle(
                                        color: _button[0]
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width *
                                  0.25 *
                                  0.4,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _button[1] = true;
                                  });
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return MenuScreen();
                                  }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: _button[1]
                                        ? Border.all(color: Colors.black)
                                        : Border.all(color: Colors.transparent),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        color: _button[1]
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width *
                                  0.25 *
                                  0.4,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _button[2] = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: _button[2]
                                        ? Border.all(color: Colors.black)
                                        : Border.all(color: Colors.transparent),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'عربي',
                                      style: TextStyle(
                                        color: _button[2]
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RequestRetry(
                      message: 'errorUnknown',
                      retryCallback: _getRestaurantProfile),
                ],
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}
