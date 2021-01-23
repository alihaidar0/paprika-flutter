import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paprica/src/screens/restaurant_screen.dart';
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

class _PlacesPageState extends State<PlacesPage>{

  Future<PagedResultDtoRestaurantSummaryDto> futureRestData;
  List<RestaurantSummaryDto> restaurants;
  ScrollController _scrollController;

  Future _getPlacesDataAsync() {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = PlacesApi(apiClient);
    setState(() {
      futureRestData = apiInstance.apiServicesAppPlacesGetAllGet();
    });
    return futureRestData.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  @override
  void initState() {
    super.initState();
    _getPlacesDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PagedResultDtoRestaurantSummaryDto>(
      future: futureRestData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            restaurants = snapshot.data.items;
            return Scaffold(
              body: CustomScrollView(
                controller: _scrollController,
                physics: restaurants == null || restaurants.isEmpty
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  restaurants != null && restaurants.isNotEmpty
                      ? SliverList(
                          delegate: SliverChildListDelegate(
                            restaurants.map<Widget>((item) {
                                  if (item is RestaurantSummaryDto)
                                    return _RestaurantItem(item);
                                  else {
                                    return null;
                                  }
                                })?.toList() ??
                                [],
                          ),
                        )
                      : SliverFillRemaining(
                          child: Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              child: Image.asset(
                                  "assets/images/no_restaurants.png"),
                            ),
                          ),
                        ),
                ],
              ),
            );
          } else {
            return RequestRetry(
                  message: S.of(context).errorUnknown,
                  retryCallback: _getPlacesDataAsync);
          }
        } else if (snapshot.connectionState == ConnectionState.none) {
          return RequestRetry(
                message: S.of(context).errorUnknown,
                retryCallback: _getPlacesDataAsync);
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
            height: MediaQuery.of(context).size.height * 0.40,
          ),
        ],
      ),
    );
  }
}

class _RestaurantItem extends StatelessWidget {
  final RestaurantSummaryDto restaurant;

  _RestaurantItem(this.restaurant);

  CachedNetworkImageProvider _widgetLogoImage;

  @override
  Widget build(BuildContext context) {
    _widgetLogoImage ??= CachedNetworkImageProvider(this.restaurant.logoImage);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RestaurantHome(restaurantId: this.restaurant.id);
        }));
      },
      child: SizedBox(
        child: Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.25 * 0.5),
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                              image: _widgetLogoImage, fit: BoxFit.scaleDown)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    (this.restaurant.phoneNumber != null
                                        ? 0.55
                                        : 0.6),
                                child: Text(
                                  this.restaurant.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: this.restaurant.phoneNumber != null
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return CallRestaurantDialog(
                                              phoneNumber:
                                                  this.restaurant.phoneNumber,
                                              restaurantName:
                                                  this.restaurant.name,
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.phone,
                                        size: 24,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                        FlutterRatingBarIndicator(
                          rating: this.restaurant.restaurantRate,
                          itemSize: 12,
                          itemPadding: EdgeInsets.all(2),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              this.restaurant.isOpen
                                  ? S.of(context).opened
                                  : S.of(context).closed,
                              style: TextStyle(
                                fontSize: 11,
                                color: this.restaurant.isOpen
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              this.restaurant.address,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(
                            color: Colors.grey,
                            height: 10,
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      S.of(context).food,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.restaurant.foodRate.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PapricaVerticalDivider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      S.of(context).service,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.restaurant.serviceRate.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PapricaVerticalDivider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      S.of(context).shisha,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.restaurant.shishaRate.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PapricaVerticalDivider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      S.of(context).ambiance,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.restaurant.ambianceRate.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PapricaVerticalDivider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).noiseLevel,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      ApiHelper.toStringNoiseLevel(
                                          context, this.restaurant.noiseLevel),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          /// This ready for restaurant tags (Calm, Antique, ...) extracted from reviews
//                    Wrap(
//                      spacing: 8,
//                      runSpacing: -8,
//                      children:
//                          this.restaurant.tags.
//                          .map<Widget>((tag) => Chip(
//                                label: Text(
//                                  tag,
//                                  style: TextStyle(fontSize: 12, color: Colors.white),
//                                ),
//                                padding: EdgeInsets.all(0),
//                                backgroundColor: Colors.red[200],
//                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
//                              ))
//                          .toList(),
//                    )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
