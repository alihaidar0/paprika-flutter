import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/screens/pickups_screen.dart';
import 'package:paprika/src/screens/reservations_screen.dart';
import 'package:paprika/src/widgets/login_promotion.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../utils.dart';
import '../../widgets.dart';

class ServicePage extends StatefulWidget {
  final Stream<bool> refreshStream;

  const ServicePage({this.refreshStream});

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  StreamController<bool> _streamRefreshController;

  @override
  void initState() {
    super.initState();
    _streamRefreshController = StreamController<bool>.broadcast();
    widget.refreshStream?.listen((refresh) {
      if (refresh) {
        refreshData();
      }
    });
  }

  @override
  void dispose() {
    _streamRefreshController.close();
    super.dispose();
  }

  Future refreshData() {
    try {
      _streamRefreshController.add(true);
    } catch (e) {}
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();
    if (ApiTypesHelper().isAuthorized) {
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refreshData,
        child: UpcomingService(refreshStream: _streamRefreshController.stream),
      );
    } else {
      return LogInPromotion(loginLine: S.of(context).loginPromotionActivities);
    }
  }
}

class UpcomingService extends StatefulWidget {
  final Stream<bool> refreshStream;

  const UpcomingService({this.refreshStream});

  @override
  _UpcomingServiceState createState() => _UpcomingServiceState();
}

class _UpcomingServiceState extends State<UpcomingService> {
  Future<CustomerUpcomingServiceDto> _customerUpcomingServiceFuture;
  bool _isLoading = false;
  CustomerNearestReservationDto _customerNearestReservationDto;
  CustomerNearestPickupDto _customerNearestPickupDto;
  CustomerNearestDeliveryDto _customerNearestDeliveryDto;

  @override
  void initState() {
    super.initState();
    _getUpcomingServiceAsync();
    widget.refreshStream?.listen(_listener);
  }

  _listener(bool refresh) {
    if (refresh != null && refresh && !_isLoading) {
      _getUpcomingServiceAsync();
    }
  }

  Future _getUpcomingServiceAsync() {
    ApiClient client = PapricaApiClient();
    CustomerServiceApi api = CustomerServiceApi(client);
    setState(() {
      _customerUpcomingServiceFuture =
          api.apiServicesAppCustomerServiceGetAllUpcomingGet();
      _isLoading = true;
    });

    _customerUpcomingServiceFuture.then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((err) {
      setState(() {
        _isLoading = false;
      });
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CustomerUpcomingServiceDto>(
        future: _customerUpcomingServiceFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Color(0xFFFCFAF8),
              body: ListView(
                children: [
                  (snapshot.data.nearestReservation != null &&
                          snapshot.data.nearestPickup != null)
                      ? Padding(
                          padding:
                              Localizations.localeOf(context).languageCode ==
                                      'en'
                                  ? const EdgeInsets.only(left: 35.0)
                                  : const EdgeInsets.only(right: 35.0),
                          child: Text(
                            S.of(context).upcoming,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : Container(),
                  snapshot.data.nearestReservation != null
                      ? _nearestReservation(snapshot.data.nearestReservation)
                      : snapshot.data.nearestPickup != null
                          ? _nearestPickup(snapshot.data.nearestPickup)
                          : Container(),

                  /// remove delivery
                  // snapshot.data.nearestDelivery != null
                  //             ? _nearestDelivery(snapshot.data.nearestDelivery)
                  //             : Column(
                  //                 children: <Widget>[
                  //                   Center(
                  //                     child: NoServicesLayout(
                  //                         mTitle:
                  //                             S.of(context).noUpcomingServices),
                  //                   ),
                  //                   GestureDetector(
                  //                     onTap: () {
                  //                       if (widget.changeHomePageIndexHandler
                  //                               is Function &&
                  //                           widget.changeHomePageIndexHandler !=
                  //                               null) {
                  //                         widget.changeHomePageIndexHandler(2);
                  //                       }
                  //                     },
                  //                     child: Text(
                  //                       S.of(context).goToPlaces,
                  //                       style: TextStyle(
                  //                           color:
                  //                               Theme.of(context).primaryColor),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  Padding(
                    padding:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? const EdgeInsets.only(
                                left: 42.0, top: 8.0, bottom: 8.0)
                            : const EdgeInsets.only(
                                right: 42.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      S.of(context).allServices,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.white,
                      elevation: 2.0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ReservationsScreen();
                          }));
                        },
                        child: Padding(
                          padding:
                              Localizations.localeOf(context).languageCode ==
                                      'en'
                                  ? const EdgeInsets.only(
                                      left: 25.0,
                                      top: 18.0,
                                      right: 20.0,
                                      bottom: 18.0)
                                  : const EdgeInsets.only(
                                      right: 25.0,
                                      top: 18.0,
                                      left: 20.0,
                                      bottom: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/reserve.svg",
                                    width: 35.0,
                                    height: 35.0,
                                  ),
                                  Padding(
                                    padding: Localizations.localeOf(context)
                                                .languageCode ==
                                            'en'
                                        ? const EdgeInsets.only(left: 18.0)
                                        : const EdgeInsets.only(right: 18.0),
                                    child: Text(
                                      S.of(context).reservations,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  snapshot.data.reservationsTotalCount == 0
                                      ? Container()
                                      : Container(
                                          width: 18.0,
                                          height: 18.0,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(9.0)),
                                          child: Center(
                                            child: Text(
                                              "${snapshot.data.reservationsTotalCount}",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 25.0,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.white,
                      elevation: 2.0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return PickupsScreen();
                          }));
                        },
                        child: Padding(
                          padding:
                              Localizations.localeOf(context).languageCode ==
                                      'en'
                                  ? const EdgeInsets.only(
                                      left: 25.0,
                                      top: 5.0,
                                      right: 20.0,
                                      bottom: 18.0)
                                  : const EdgeInsets.only(
                                      right: 25.0,
                                      top: 5.0,
                                      left: 20.0,
                                      bottom: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 7.0,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/order.svg",
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                  Padding(
                                    padding: Localizations.localeOf(context)
                                                .languageCode ==
                                            'en'
                                        ? const EdgeInsets.only(
                                            left: 18.0, top: 10.0)
                                        : const EdgeInsets.only(
                                            right: 18.0, top: 10.0),
                                    child: Text(
                                      "   ${S.of(context).pickups}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    snapshot.data.pickupsTotalCount == 0
                                        ? Container()
                                        : Container(
                                            width: 18.0,
                                            height: 18.0,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(9.0)),
                                            child: Center(
                                              child: Text(
                                                "${snapshot.data.pickupsTotalCount}",
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 25.0,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// remove delivery
                  // Padding(
                  //   padding:
                  //       Localizations.localeOf(context).languageCode == 'en'
                  //           ? const EdgeInsets.only(left: 15.0, right: 30.0)
                  //           : const EdgeInsets.only(right: 15.0, left: 30.0),
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12.0),
                  //     ),
                  //     color: Colors.white,
                  //     elevation: 2.0,
                  //     child: InkWell(
                  //       borderRadius: BorderRadius.circular(12.0),
                  //       onTap: () {
                  //         Navigator.of(context).push(MaterialPageRoute(
                  //             builder: (BuildContext context) {
                  //           return DeliveriesScreen();
                  //         }));
                  //       },
                  //       child: Padding(
                  //         padding:
                  //             Localizations.localeOf(context).languageCode ==
                  //                     'en'
                  //                 ? const EdgeInsets.only(
                  //                     left: 25.0,
                  //                     top: 18.0,
                  //                     right: 20.0,
                  //                     bottom: 18.0)
                  //                 : const EdgeInsets.only(
                  //                     right: 25.0,
                  //                     top: 18.0,
                  //                     left: 20.0,
                  //                     bottom: 18.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 SvgPicture.asset(
                  //                   "assets/icons/noun_food_delivery.svg",
                  //                   width: 35.0,
                  //                   height: 35.0,
                  //                 ),
                  //                 Padding(
                  //                   padding: Localizations.localeOf(context)
                  //                               .languageCode ==
                  //                           'en'
                  //                       ? const EdgeInsets.only(left: 18.0)
                  //                       : const EdgeInsets.only(right: 18.0),
                  //                   child: Text(
                  //                     S.of(context).deliveries,
                  //                     style: TextStyle(
                  //                       fontSize: 18.0,
                  //                     ),
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //             Row(
                  //               children: [
                  //                 snapshot.data.deliveriesTotalCount == 0
                  //                     ? Container()
                  //                     : Container(
                  //                         width: 18.0,
                  //                         height: 18.0,
                  //                         decoration: BoxDecoration(
                  //                             color: Theme.of(context)
                  //                                 .primaryColor,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(9.0)),
                  //                         child: Center(
                  //                           child: Text(
                  //                             "${snapshot.data.deliveriesTotalCount}",
                  //                             style: TextStyle(
                  //                               fontSize: 13.0,
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                 SizedBox(
                  //                   width: 15.0,
                  //                 ),
                  //                 Icon(
                  //                   Icons.arrow_forward_ios,
                  //                   size: 25.0,
                  //                   color: Colors.grey,
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                RequestRetry(
                    message: S.of(context).errorUnknown,
                    retryCallback: _getUpcomingServiceAsync),
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

  void _viewMyReservations(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ReservationsScreen();
    }));
  }

  Widget _nearestReservation(CustomerNearestReservationDto data) {
    return Padding(
      padding: Localizations.localeOf(context).languageCode == 'en'
          ? const EdgeInsets.only(left: 12.0, top: 4.0, right: 24.0)
          : const EdgeInsets.only(left: 24.0, top: 4.0, right: 12.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? const EdgeInsets.only(left: 42.0, top: 32.0)
                    : const EdgeInsets.only(right: 42.0, top: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: [
                        Text(
                          S.of(context).youHaveUpcomingReservationAt,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          " ${data.restaurantName} ",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      PaprikaFormatter.formatDateOnly(context, data.date) +
                          "    " +
                          PaprikaFormatter.formatTimeOnly(context, data.date),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    data.occasionType == null || data.occasionType == ""
                        ? Container(
                            height: 0.0,
                          )
                        : Row(
                            children: [
                              Text(
                                S.of(context).occasion + ":",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "${data.occasionType}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: Localizations.localeOf(context)
                                      .languageCode ==
                                  'en'
                              ? const EdgeInsets.only(right: 12.0, bottom: 10.0)
                              : const EdgeInsets.only(left: 12.0, bottom: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              _viewMyReservations(context);
                            },
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).viewReservations,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                FaIcon(
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? (FontAwesomeIcons.angleDoubleRight)
                                      : (FontAwesomeIcons.angleDoubleLeft),
                                  color: Theme.of(context).primaryColor,
                                  size: 16.0,
                                ),
                              ],
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
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return RestaurantHome(restaurantId: data.restaurantId);
              }));
            },
            child: Padding(
              padding: Localizations.localeOf(context).languageCode == 'en'
                  ? const EdgeInsets.only(left: 36.0)
                  : const EdgeInsets.only(right: 36.0),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(30),
                child: CachedNetworkImage(
                    imageUrl: data.restaurantImage,
                    placeholder: (context, url) => Image(
                          image: AssetImage("assets/images/placeholder.png"),
                          width: 60,
                        ),
                    width: 60),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nearestPickup(CustomerNearestPickupDto data) {
    return Padding(
      padding: Localizations.localeOf(context).languageCode == 'en'
          ? const EdgeInsets.only(left: 12.0, top: 4.0, right: 24.0)
          : const EdgeInsets.only(left: 24.0, top: 4.0, right: 12.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? const EdgeInsets.only(left: 42.0, top: 32.0)
                    : const EdgeInsets.only(right: 42.0, top: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: [
                        Text(
                          S.of(context).youHaveUpcomingPickupAt,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          " ${data.restaurantName} ",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      PaprikaFormatter.formatDateOnly(context, data.date) +
                          "    " +
                          PaprikaFormatter.formatTimeOnly(context, data.date),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: Localizations.localeOf(context)
                                      .languageCode ==
                                  'en'
                              ? const EdgeInsets.only(right: 12.0, bottom: 10.0)
                              : const EdgeInsets.only(left: 12.0, bottom: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return PickupsScreen();
                              }));
                            },
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).viewPickups,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                FaIcon(
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? (FontAwesomeIcons.angleDoubleRight)
                                      : (FontAwesomeIcons.angleDoubleLeft),
                                  color: Theme.of(context).primaryColor,
                                  size: 16.0,
                                ),
                              ],
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
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return RestaurantHome(restaurantId: data.restaurantId);
              }));
            },
            child: Padding(
              padding: Localizations.localeOf(context).languageCode == 'en'
                  ? const EdgeInsets.only(left: 36.0)
                  : const EdgeInsets.only(right: 36.0),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(30),
                child: CachedNetworkImage(
                    imageUrl: data.restaurantImage,
                    placeholder: (context, url) => Image(
                          image: AssetImage("assets/images/placeholder.png"),
                          width: 60,
                        ),
                    width: 60),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// remove delivery
// Widget _nearestDelivery(CustomerNearestDeliveryDto data) {
//   return Padding(
//     padding: Localizations.localeOf(context).languageCode == 'en'
//         ? const EdgeInsets.only(left: 12.0, top: 4.0, right: 24.0)
//         : const EdgeInsets.only(left: 24.0, top: 4.0, right: 12.0),
//     child: Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 25.0),
//           child: Card(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               padding: Localizations.localeOf(context).languageCode == 'en'
//                   ? const EdgeInsets.only(left: 42.0, top: 32.0)
//                   : const EdgeInsets.only(right: 42.0, top: 32.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data.restaurantName,
//                     style: TextStyle(
//                       color: Colors.red.shade900,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 4.0,
//                   ),
//                   Text(
//                     S.of(context).youHaveUpcomingDeliveryAt +
//                         " ${data.restaurantName} ",
//                     style: TextStyle(
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "${PaprikaFormatter.formatDateOnly(context, data.estimationTime)}  ${PaprikaFormatter.formatTimeOnly(context, data.estimationTime)}",
//                     style: TextStyle(
//                       color: Colors.red.shade200,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "${S.of(context).price}:   ",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             PaprikaFormatter.formatNumber(data.price.floor()),
//                             style: TextStyle(
//                               fontSize: 16.0,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 4,
//                           ),
//                           Text(
//                             S.of(context).currency,
//                             style: TextStyle(
//                               fontSize: 16.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: Localizations.localeOf(context)
//                                     .languageCode ==
//                                 'en'
//                             ? const EdgeInsets.only(right: 12.0, bottom: 10.0)
//                             : const EdgeInsets.only(left: 12.0, bottom: 10.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (BuildContext context) {
//                               return DeliveriesScreen();
//                             }));
//                           },
//                           child: Row(
//                             children: [
//                               Text(
//                                 S.of(context).viewDeliveries,
//                                 style: TextStyle(
//                                   fontSize: 15.0,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 8.0,
//                               ),
//                               FaIcon(
//                                 Localizations.localeOf(context)
//                                             .languageCode ==
//                                         'en'
//                                     ? (FontAwesomeIcons.angleDoubleRight)
//                                     : (FontAwesomeIcons.angleDoubleLeft),
//                                 color: Theme.of(context).primaryColor,
//                                 size: 16.0,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (BuildContext context) {
//               return RestaurantHome(restaurantId: data.restaurantId);
//             }));
//           },
//           child: Padding(
//             padding: Localizations.localeOf(context).languageCode == 'en'
//                 ? const EdgeInsets.only(left: 36.0)
//                 : const EdgeInsets.only(right: 36.0),
//             child:
//             ClipRRect(
//               borderRadius: new BorderRadius.circular(30),
//               child: CachedNetworkImage(
//                   imageUrl: data.restaurantImage,
//                   placeholder: (context, url) => Image(
//                     image: AssetImage("assets/images/placeholder.png"),
//                     width: 60,
//                   ),
//                   width: 60),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
}

class NoServicesLayout extends StatelessWidget {
  final String mTitle;

  const NoServicesLayout({@required this.mTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          Image(
            height: 170,
            width: 170,
            image: AssetImage('assets/images/no_reservation.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(mTitle),
          ),
        ],
      ),
    );
  }
}
