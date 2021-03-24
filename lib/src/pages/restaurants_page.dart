import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paprika/src/screens/restaurant_screen.dart';
import 'package:paprika/translations.dart';
import 'package:paprika/widgets.dart';
import 'package:swagger/api.dart';

import '../../utils.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage();

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage>
    with AutomaticKeepAliveClientMixin<RestaurantsPage> {
  Future<PagedResultDtoRestaurantSummaryDto> futureRestData;
  ScrollController _scrollController;
  bool _endOfRestaurants;
  bool _requestingData;
  List<dynamic> restaurants = [];
  bool _firstTime;

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

  void _requestData(BuildContext context, {int skipCount, int maxResult = 10}) {
    if (_requestingData) return;
    setState(() {
      _requestingData = true;
    });
    ApiClient client = PapricaApiClient();
    PlacesApi api = PlacesApi(client);
    api
        .apiServicesAppPlacesGetAllGet(
      skipCount: skipCount ?? 0,
      maxResultCount: maxResult,
    )
        .then((restaurantsDto) {
      setState(() {
        _requestingData = false;
        // Load More
        if (skipCount != null && skipCount > 0) {
          // Just remove the loader
          if (restaurants.isNotEmpty && restaurants.last is SpinKitCircle) {
            restaurants.removeLast();
          }
          if (restaurantsDto.items.isNotEmpty) {
            restaurants.addAll(restaurantsDto.items);
          } else {
            _endOfRestaurants = true;
          }
        }
      });
    }).catchError((err) {
      setState(() {
        _requestingData = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getPlacesDataAsync();
    _endOfRestaurants = false;
    _requestingData = false;
    _firstTime = true;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          !_requestingData &&
          restaurants.isNotEmpty &&
          context != null &&
          !_endOfRestaurants) {
        _requestData(context, skipCount: restaurants.length);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureRestData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data.items != null &&
                snapshot.data.items.length > 0 &&
                _firstTime) {
              for (var item in snapshot.data.items) {
                restaurants.add(item);
              }
              _firstTime = false;
            }
            if (_requestingData) {
              restaurants.add(SpinKitCircle(color: Colors.grey, size: 32));
            } else {
              if (restaurants != null &&
                  restaurants.length > 0 &&
                  restaurants.last is SpinKitCircle) {
                restaurants.removeLast();
              }
            }
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
                                  if (item is RestaurantSummaryDto) {
                                    return _RestaurantItem(item);
                                  } else {
                                    return item;
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
          return _RestaurantsPagePlaceHolder(
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
}

typedef Future RetryCallback();

class _RestaurantsPagePlaceHolder extends StatefulWidget {
  final Widget child;
  final RetryCallback getData;

  _RestaurantsPagePlaceHolder(this.child, {this.getData});

  @override
  __RestaurantsPagePlaceHolderState createState() =>
      __RestaurantsPagePlaceHolderState();
}

class __RestaurantsPagePlaceHolderState
    extends State<_RestaurantsPagePlaceHolder> {
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

// class _RestaurantItem extends StatelessWidget {
//   final RestaurantSummaryDto restaurant;
//
//   _RestaurantItem(this.restaurant);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (BuildContext context) {
//           return RestaurantHome(restaurantId: this.restaurant.id);
//         }));
//       },
//       child: SizedBox(
//         child: Card(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.25,
//                       height: MediaQuery.of(context).size.width * 0.25,
//                       decoration: new BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                               MediaQuery.of(context).size.width * 0.25 * 0.5),
//                           shape: BoxShape.rectangle,
//                           color: Colors.white,
//                           image: DecorationImage(
//                               image: CachedNetworkImageProvider(
//                                   this.restaurant.logoImage),
//                               fit: BoxFit.scaleDown)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 2),
//                               child: Row(
//                                 children: [
//                                   SizedBox(width: 2.0),
//                                   Container(
//                                     width: MediaQuery.of(context).size.width *
//                                         (this.restaurant.phoneNumber != null
//                                             ? 0.55
//                                             : 0.6),
//                                     child: Text(
//                                       this.restaurant.name,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: Theme.of(context).primaryColor,
//                                           fontWeight: FontWeight.w500,height: 1.3),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               child: this.restaurant.phoneNumber != null
//                                   ? GestureDetector(
//                                       onTap: () {
//                                         showDialog(
//                                           context: context,
//                                           barrierDismissible: false,
//                                           builder: (context) {
//                                             return CallRestaurantDialog(
//                                               phoneNumber:
//                                                   this.restaurant.phoneNumber,
//                                               restaurantName:
//                                                   this.restaurant.name,
//                                             );
//                                           },
//                                         );
//                                       },
//                                       child: Icon(
//                                         Icons.phone,
//                                         size: 24,
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                     )
//                                   : Container(),
//                             )
//                           ],
//                         ),
//                         SizedBox(height: 2),
//                         Row(
//                           children: [
//                             SizedBox(width: 2.0),
//                             FlutterRatingBarIndicator(
//                               rating: this.restaurant.restaurantRate,
//                               itemSize: 12,
//                               itemPadding: EdgeInsets.all(2),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 4),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.60,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4),
//                             child: Text(
//                               this.restaurant.isOpen
//                                   ? S.of(context).opened
//                                   : S.of(context).closed,
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: this.restaurant.isOpen
//                                     ? Colors.green
//                                     : Colors.red,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 2),
//                         // Container(
//                         //   width: MediaQuery.of(context).size.width * 0.60,
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.symmetric(horizontal: 4),
//                         //     child: Text(
//                         //       this.restaurant.address,
//                         //       maxLines: 2,
//                         //       overflow: TextOverflow.ellipsis,
//                         //     ),
//                         //   ),
//                         // ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.60,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4),
//                             child: Text(
//                               ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
//                                   this.restaurant.restaurantTypes, Type.places,
//                                   maxNumber: 2, separator: S.of(context).comma + ' '),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Divider(
//                             color: Colors.grey,
//                             height: 10,
//                           ),
//                           SizedBox(height: 5),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.all(3.0),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Text(
//                                       S.of(context).food,
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     Text(
//                                       this.restaurant.foodRate.toString(),
//                                       style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 4),
//                                 child: PaprikaVerticalDivider(),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(3.0),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Text(
//                                       S.of(context).service,
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     Text(
//                                       this.restaurant.serviceRate.toString(),
//                                       style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               restaurant.hasShisha != null &&
//                                       restaurant.hasShisha == true
//                                   ? Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 4),
//                                           child: PaprikaVerticalDivider(),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: Column(
//                                             children: <Widget>[
//                                               Text(
//                                                 S.of(context).shisha,
//                                                 style: TextStyle(fontSize: 12),
//                                               ),
//                                               Text(
//                                                 this
//                                                     .restaurant
//                                                     .shishaRate
//                                                     .toString(),
//                                                 style: TextStyle(
//                                                   color: Theme.of(context)
//                                                       .primaryColor,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   : Container(),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 4),
//                                 child: PaprikaVerticalDivider(),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(3.0),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Text(
//                                       S.of(context).ambiance,
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     Text(
//                                       this.restaurant.ambianceRate.toString(),
//                                       style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 4),
//                                 child: PaprikaVerticalDivider(),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(3.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       S.of(context).noiseLevel,
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     Text(
//                                       ApiHelper.toStringNoiseLevel(
//                                           context, this.restaurant.noiseLevel),
//                                       style: TextStyle(
//                                           color: Theme.of(context).primaryColor,
//                                           fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//
//                           /// This ready for restaurant tags (Calm, Antique, ...) extracted from reviews
// //                    Wrap(
// //                      spacing: 8,
// //                      runSpacing: -8,
// //                      children:
// //                          this.restaurant.tags.
// //                          .map<Widget>((tag) => Chip(
// //                                label: Text(
// //                                  tag,
// //                                  style: TextStyle(fontSize: 12, color: Colors.white),
// //                                ),
// //                                padding: EdgeInsets.all(0),
// //                                backgroundColor: Colors.red[200],
// //                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
// //                              ))
// //                          .toList(),
// //                    )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _RestaurantItem extends StatelessWidget {
  final RestaurantSummaryDto restaurant;

  _RestaurantItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
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
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.25 * 0.5),
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  this.restaurant.logoImage),
                              fit: BoxFit.scaleDown)),
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
                              child: this.restaurant.phoneNumber == null &&
                                      this.restaurant.tel == null
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return CallRestaurantDialog(
                                              phoneNumber:
                                                  this.restaurant.phoneNumber != null ? this.restaurant.phoneNumber : this.restaurant.tel,
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
                                    ),
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
                              ApiTypesHelper()
                                  .getCommaSeparatedTypeNamesByValue(
                                      this.restaurant.restaurantTypes,
                                      Type.places,
                                      maxNumber: 2,
                                      separator: S.of(context).comma + ' '),
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
                                child: PaprikaVerticalDivider(),
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
                              restaurant.hasShisha != null &&
                                      restaurant.hasShisha == true
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: PaprikaVerticalDivider(),
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
                                                this
                                                    .restaurant
                                                    .shishaRate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PaprikaVerticalDivider(),
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
                                child: PaprikaVerticalDivider(),
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
