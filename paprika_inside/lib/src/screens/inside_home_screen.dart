import 'package:flutter/material.dart';
import 'package:swagger_inside/api.dart';
import 'package:paprika_inside/utils.dart';
import 'package:paprika_inside/widgets.dart';

class InsideHomeScreen extends StatefulWidget {
  @override
  _InsideHomeScreenState createState() => _InsideHomeScreenState();
}

class _InsideHomeScreenState extends State<InsideHomeScreen> {
  Future<SoftUpPaprikaInsideRestaurantsRestaurantDto> _restaurantProfile;

  @override
  void initState() {
    super.initState();
    _getRestaurantProfile();
  }

  Future _getRestaurantProfile() {
    ApiClient client = PaprikaInsideApiClient();
    CustomerRestaurantApi api = CustomerRestaurantApi(client);
    setState(() {
      _restaurantProfile =
          api.apiAppCustomerRestaurantRestaurantProfileGet();
    });
    _restaurantProfile.then((_) {
      debugPrint(_restaurantProfile.toString());
    }).catchError((err) {
      print(err);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SoftUpPaprikaInsideRestaurantsRestaurantDto>(
        future: _restaurantProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Hi'),
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                RequestRetry(
                    message: 'errorUnknown',
                    retryCallback: _getRestaurantProfile),
              ],
            );
          }
          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }
}
