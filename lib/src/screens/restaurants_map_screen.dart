import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprika/src/widgets/slider.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../translations.dart';
import '../../widgets.dart';

GoogleMapController mapController;

class RestaurantsMapScreen extends StatefulWidget {
  final List<RestaurantSummaryDto> restaurants;
  final String title;

  const RestaurantsMapScreen({Key key, this.restaurants, this.title})
      : super(key: key);

  @override
  _RestaurantsMapScreenState createState() => _RestaurantsMapScreenState();
}

class _RestaurantsMapScreenState extends State<RestaurantsMapScreen> {
  PageController _pageController;

  LatLng _current;

  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).discoverOnMap)),
      body: FutureBuilder(
        future: _getMapWidget(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return MapLoadingLayout();
          }
        },
      ),
    );
  }

  Future<Widget> _getMapWidget(BuildContext context) {
    if (widget.restaurants == null) {
      return Future.delayed(Duration(milliseconds: 500), () {
        return NoRestaurantsLayout();
      });
    }
    return Future<Widget>.delayed(Duration(milliseconds: 500), () {
      if (widget.restaurants.length > 0 && _current == null)
        _current = LatLng(
            widget.restaurants[0].latitude, widget.restaurants[0].longitude);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .9 - 122,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              padding: EdgeInsets.all(8),
              onMapCreated: _onMapCreated,
              markers: widget.restaurants
                  .asMap()
                  .map((index, restaurant) {
                    return MapEntry(
                        index,
                        Marker(
                            icon: index == _currentIndex
                                ? BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueOrange)
                                : BitmapDescriptor.defaultMarker,
                            markerId: MarkerId(restaurant.id.toString()),
                            position: LatLng(
                                restaurant.latitude, restaurant.longitude),
                            onTap: () {
                              _pageController.jumpToPage(index);
                            }));
                  })
                  .values
                  .toSet(),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
              ].toSet(),
              initialCameraPosition: CameraPosition(
                target: _current,
                zoom: 12.0,
              ),
            ),
          ),
          CarouselSlider(
            items: widget.restaurants
                .asMap()
                .map((index, restaurant) {
                  return MapEntry(
                      index,
                      _ListItem(restaurant, _pageController, index,
                          widget.restaurants.length));
                })
                .values
                .toList(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              mapController.animateCamera(CameraUpdate.newLatLng(LatLng(
                  widget.restaurants[index].latitude,
                  widget.restaurants[index].longitude)));
            },
            mPageController: _pageController,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            height: 105,
          ),
        ],
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}

class _ListItem extends StatefulWidget {
  final RestaurantSummaryDto restaurant;

  final index;
  final total;

  final pageController;

  _ListItem(this.restaurant, this.pageController, this.index, this.total);

  @override
  __ListItemState createState() => __ListItemState();
}

class __ListItemState extends State<_ListItem> {
  CachedNetworkImageProvider _widgetLogoImage;

  @override
  Widget build(BuildContext context) {
    _widgetLogoImage ??=
        CachedNetworkImageProvider(this.widget.restaurant.logoImage);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RestaurantHome(restaurantId: this.widget.restaurant.id);
        }));
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  widget.pageController.jumpToPage(widget.index - 1);
                },
                child: Container(
                  decoration: BoxDecoration(
//                    border: Border.all(color: Colors.grey[200],width: 1),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: Icon(
                          Localizations.localeOf(context).languageCode == 'en'
                              ? Icons.keyboard_arrow_left
                              : Icons.keyboard_arrow_right,
                          size: 24,
//                      color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.width * 0.25,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.20 * 0.5),
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    image: DecorationImage(
                        image: _widgetLogoImage, fit: BoxFit.scaleDown)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                (this.widget.restaurant.phoneNumber != null
                                    ? 0.4
                                    : 0.45),
                            child: Text(
                              this.widget.restaurant.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlutterRatingBarIndicator(
                    rating: this.widget.restaurant.restaurantRate,
                    itemSize: 12,
                    itemPadding: EdgeInsets.all(2),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        this.widget.restaurant.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  children: <Widget>[
                    this.widget.restaurant.phoneNumber != null
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return CallRestaurantDialog(
                                    phoneNumber:
                                        this.widget.restaurant.phoneNumber,
                                    restaurantName: this.widget.restaurant.name,
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
                  ],
                )),
            GestureDetector(
                onTap: () {
                  widget.pageController.jumpToPage(widget.index + 1);
                },
                child: Container(
                  decoration: BoxDecoration(
//                    border: Border.all(color: Colors.grey[200],width: 0),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: Icon(
                          Localizations.localeOf(context).languageCode == 'en'
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_left,
                          size: 24,
//                      color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
