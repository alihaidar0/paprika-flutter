import 'package:flutter/material.dart';
import 'package:paprika_inside/utils.dart';
import 'package:paprika_inside/widgets.dart';
import 'package:swagger_inside/api.dart';

class InsideHomeScreen extends StatefulWidget {
  @override
  _InsideHomeScreenState createState() => _InsideHomeScreenState();
}

class _InsideHomeScreenState extends State<InsideHomeScreen> {
  static String lang = "ar";
  static String tenant = 'e6f62669-bfc5-56da-227a-39f8e0b92d0a';
  Future<RestaurantsRestaurantDto> _restaurantProfile;

  @override
  void initState() {
    PaprikaInsideApiClient().setLang(lang);
    PaprikaInsideApiClient().setTenant(tenant);
    super.initState();
    _getRestaurantProfile();
  }

  Future _getRestaurantProfile() {
    ApiClient client = PaprikaInsideApiClient();
    CustomerRestaurantApi api = CustomerRestaurantApi(client);
    setState(() {
      _restaurantProfile = api.apiAppCustomerRestaurantRestaurantProfileGet();
    });
    _restaurantProfile.then((_) {
      print(_restaurantProfile);
    }).catchError((err) {
      print(err);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantsRestaurantDto>(
        future: _restaurantProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint(snapshot.data.name);
            return Scaffold(
              appBar: AppBar(
                title: Text('Hi'),
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
