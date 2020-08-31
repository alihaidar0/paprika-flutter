import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:paprica/src/models/paprica_filter_model.dart';
import 'package:paprica/src/models/restaurants_list_model.dart';
import 'package:paprica/src/widgets/restaurant_list_view.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';
import 'dart:async';
import '../../utils.dart';

int currentTab;

class PlacesPage extends StatefulWidget {
  const PlacesPage();

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage>
    with AutomaticKeepAliveClientMixin<PlacesPage> {
  Future<PlacesResponse> futureRestData;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  LocationData locationData;

  @override
  void initState() {
    super.initState();
//    currentTab = 0;
    _checkLocation();
    _getPlacesDataAsync();
  }

  Future onRefresh() {
    return _getPlacesDataAsync();
  }

  Future _getPlacesDataAsync() {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = PlacesApi(apiClient);
    futureRestData = apiInstance.getPlacesPage();

    return futureRestData.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<PlacesResponse>(
      future: futureRestData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: const Color(0xffeeeeee),
              body: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      itemCount: snapshot.data.result.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Image.asset(
                            "assets/images/places_background.png",
                            fit: BoxFit.cover,
                          );
                        }

                        index -= 1;
                        return Container(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: PlacesRestaurantsList(
                              restaurantsList:
                                  snapshot.data.result[index].items,
                              title: snapshot.data.result[index].title,
                              titleColor: Theme.of(context).primaryColor,
                              filterModel:
                                  PapricaFilterModel.apiToFilterModelAdapter(
                                      snapshot.data.result[index].filter,
                                      context),
                            ));
                      })),
            );
          } else {
            return _PlacesPagePlaceHolder(
              RequestRetry(
                  message: S.of(context).errorUnknown,
                  retryCallback: _getPlacesDataAsync),
              getData: _getPlacesDataAsync,
            );
          }
        } else if (snapshot.connectionState == ConnectionState.none) {
          return _PlacesPagePlaceHolder(
            RequestRetry(
                message: S.of(context).errorUnknown,
                retryCallback: _getPlacesDataAsync),
            getData: _getPlacesDataAsync,
          );
        } else
          return _PlacesPagePlaceHolder(
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                CircularProgressIndicator(),
              ],
            ),
            getData: _getPlacesDataAsync,
          );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _checkLocation() {
    LocationProvider.getLocation().then((data) {
      this.locationData = data;
    });
  }
}

class NoRestaurantsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(S.of(context).noRestaurantsToView);
  }
}

typedef Future RetryCallback();

class _PlacesPagePlaceHolder extends StatefulWidget {
  final Widget child;
  final RetryCallback getData;

  _PlacesPagePlaceHolder(this.child, {this.getData});

  @override
  __PlacesPagePlaceHolderState createState() => __PlacesPagePlaceHolderState();
}

class __PlacesPagePlaceHolderState extends State<_PlacesPagePlaceHolder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Center(child: this.widget.child),
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
          ),
        ],
      ),
    );
  }
}
