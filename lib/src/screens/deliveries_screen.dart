import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/models/delivery_model.dart';
import 'package:paprica/src/utils/map_utils.dart';
import 'package:paprica/src/widgets/carousel_slider.dart';
import 'package:paprica/src/widgets/delivery_card.dart';
import 'package:paprica/src/widgets/login_promotion.dart';
import 'package:paprica/src/widgets/slider.dart';
import 'package:paprica/src/widgets/custom_scroll_behaviour.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';
import '../../widgets.dart';

class DeliveriesScreen extends StatefulWidget {
  final Stream<bool> refreshStream;

  const DeliveriesScreen({this.refreshStream});

  @override
  _DeliveriesScreenState createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen>
    with WidgetsBindingObserver {
  ScrollController scrollController;
  StreamController<bool> streamScrollController;
  StreamController<bool> streamRefreshController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    streamScrollController = StreamController<bool>.broadcast();
    streamRefreshController = StreamController<bool>.broadcast();
    scrollController = ScrollController();
    scrollController.addListener(_scrollControllerListener);
    widget.refreshStream?.listen((refresh) {
      if (refresh) {
        refreshData();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        _onScreenActive();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Future refreshData() {
    try {
      streamRefreshController.add(true);
    } catch (e) {}
    return Future.value();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollControllerListener);
    streamScrollController.close();
    streamRefreshController.close();
    super.dispose();
  }

  void _scrollControllerListener() {
    if (scrollController.position.maxScrollExtent - scrollController.offset <=
        0) {
      streamScrollController.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();
    if (ApiTypesHelper().isAuthorized) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).deliveries,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: refreshData,
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehaviour(),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UpcomingDeliveriesSection(
                      refreshStream: streamRefreshController.stream),
                  OldDeliverySection(
                    loadMoreStream: streamScrollController.stream,
                  ),
                  SizedBox(height: 10, child: Container())
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return LogInPromotion(
          loginLine: S.of(context).loginPromotionReservations);
    }
  }

  void _onScreenActive() {
    refreshData();
  }
}

class UpcomingDeliveriesSection extends StatefulWidget {
  final Stream<bool> refreshStream;

  const UpcomingDeliveriesSection({this.refreshStream});

  @override
  _UpcomingDeliveriesSection createState() => _UpcomingDeliveriesSection();
}

class _UpcomingDeliveriesSection extends State<UpcomingDeliveriesSection> {
  List<Widget> _deliveriesListWidget = [];
  DeliveryCoverImage _coverImage;
  Future<CustomerUpcomingDeliveriesDto> _upcomingDeliveriesFuture;
  List<CustomerUpcomingDeliveryDto> _upcomingDeliveries;
  bool _isLoading = false;

  StreamController<int> moveController;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      fn();
    }
  }

  @override
  void initState() {
    super.initState();
    moveController = StreamController<int>.broadcast();
    _getUpcomingDeliveriesAsync();
    widget.refreshStream?.listen(_listener);
  }

  @override
  void dispose() {
    moveController.close();
    super.dispose();
  }

  void _listener(bool refresh) {
    if (refresh != null && refresh && !_isLoading) {
      _getUpcomingDeliveriesAsync();
    }
  }

  Future _getUpcomingDeliveriesAsync() {
    ApiClient client = PapricaApiClient();
    CustomerDeliveryApi api = CustomerDeliveryApi(client);
    setState(() {
      _upcomingDeliveriesFuture =
          api.apiServicesAppCustomerDeliveryGetAllUpcomingGet();
      _isLoading = true;
    });

    _upcomingDeliveriesFuture.then((_) {
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
    return FutureBuilder<CustomerUpcomingDeliveriesDto>(
        future: _upcomingDeliveriesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.upcoming != null &&
                snapshot.data.upcoming.length > 0) {
              _upcomingDeliveries = snapshot.data.upcoming;
              _coverImage ??= DeliveryCoverImage(
                  snapshot.data.upcoming[0].restaurantCoverImage);
              _deliveriesListWidget = map<Widget>(
                _upcomingDeliveries,
                (index, delivery) {
                  return NewDeliveryCard(delivery: delivery);
                },
              ).toList();

              return Stack(
                children: <Widget>[
                  _coverImage,
                  CarouselSlider(
                    items: _deliveriesListWidget,
                    height: 550,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index) {
                      _coverImage.state.updateCover(
                          _upcomingDeliveries[index].restaurantCoverImage);
                      moveController.add(index);
                    },
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: DotsPart(
                        count: _deliveriesListWidget.length,
                        moveStream: moveController.stream,
                      ))
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: NoDeliveriesLayout(
                        mTitle: S.of(context).noUpcomingDeliveries),
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (widget.changeHomePageIndexHandler is Function &&
                      //     widget.changeHomePageIndexHandler != null) {
                      //   widget.changeHomePageIndexHandler(2);
                      // }
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(initialIndex: 2)),
                          ModalRoute.withName('/splash'));
                    },
                    child: Text(
                      S.of(context).goToPlaces,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            }
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                RequestRetry(
                    message: S.of(context).errorUnknown,
                    retryCallback: _getUpcomingDeliveriesAsync),
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
          ));
        });
  }
}

class DeliveryCoverImage extends StatefulWidget {
  final _DeliveryCoverImageState state = _DeliveryCoverImageState();
  final String currentCoverPhoto;

  DeliveryCoverImage(this.currentCoverPhoto);

  @override
  _DeliveryCoverImageState createState() {
    return state;
  }
}

class _DeliveryCoverImageState extends State<DeliveryCoverImage> {
  String url;

  @override
  void initState() {
    super.initState();
    this.url = widget.currentCoverPhoto;
  }

  updateCover(String url) {
    setState(() {
      this.url = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: (this.url),
      width: MediaQuery.of(context).size.width,
      height: 180,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image(
        image: AssetImage("assets/images/placeholder.png"),
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }
}

class NewDeliveryCard extends StatefulWidget {
  final CustomerUpcomingDeliveryDto delivery;

  const NewDeliveryCard({Key key, this.delivery}) : super(key: key);

  @override
  _NewDeliveryCardState createState() => _NewDeliveryCardState();
}

class _NewDeliveryCardState extends State<NewDeliveryCard>
    with AutomaticKeepAliveClientMixin<NewDeliveryCard> {
  GoogleMapController mapController;

  void _openMealsSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: .5,
            minChildSize: .45,
            maxChildSize: .95,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, top: 5.0, right: 18.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.close),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 6,
                              child:
                                  Center(child: Text(S.of(context).mealName))),
                          Container(
                              width: MediaQuery.of(context).size.width / 6,
                              child: Center(child: Text(S.of(context).price))),
                          Container(
                              width: MediaQuery.of(context).size.width / 6,
                              child:
                                  Center(child: Text(S.of(context).quantity))),
                        ],
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      Column(
                        children: List.generate(
                          widget.delivery.deliveryMeals.length,
                          (index) => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Center(
                                          child: Text(widget
                                                  .delivery
                                                  .deliveryMeals[index]
                                                  .mealName))),
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Center(
                                          child: Text(
                                              "${widget.delivery.deliveryMeals[index].mealPrice}"))),
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Center(
                                          child: Text(
                                              "${widget.delivery.deliveryMeals[index].quantity}"))),
                                ],
                              ),
                              widget.delivery.deliveryMeals[index] != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1.0),
                                            child: Text(
                                              S.of(context).notes + " :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Container(
                                                width: 300,
                                                child: Text(
                                                  widget
                                                      .delivery
                                                      .deliveryMeals[index]
                                                      .notes,
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 0.0,
                                    ),
                              Divider(
                                thickness: 1.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 115, 8, 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return RestaurantHome(
                                  restaurantId: widget.delivery.restaurantId);
                            }));
                          },
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                widget.delivery.restaurantImage),
                            radius: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).deliveryAt,
                              ),
                              RestaurantNamedLink(
                                restaurantName: widget.delivery.restaurantName,
                                restaurantId: widget.delivery.restaurantId,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<int>(
                    itemBuilder: (context) {
                      List<PopupMenuItem<int>> items = [];
                      items.add(PopupMenuItem(
                          value: 1, child: Text(S.of(context).call)));
                      if (widget.delivery.status ==
                              ApiHelper.deliveryTypePending ||
                          widget.delivery.status ==
                              ApiHelper.deliveryTypeApproved) {
                        items.add(PopupMenuItem(
                            value: 2, child: Text(S.of(context).edit)));
                        items.add(PopupMenuItem(
                            value: 3,
                            child: Text(S.of(context).cancelDelivery)));
                      }
                      if ((widget.delivery.status ==
                                  ApiHelper.deliveryTypePending ||
                              widget.delivery.status ==
                                  ApiHelper.deliveryTypeApproved) &&
                          widget.delivery.updateRequest != null) {
                        items.add(PopupMenuItem(
                            value: 4, child: Text(S.of(context).viewUpdates)));
                      }
                      return items;
                    },
                    onSelected: (selection) {
                      switch (selection) {
                        case 1:
                          _onCallSelected(context);
                          break;
                        case 2:
                          _onUpdateSelected(context);
                          break;
                        case 3:
                          _onCancelSelected(context);
                          break;
                        case 4:
                          _showUpdateRequest(context);
                          break;
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1.0),
                                    child: Text(
                                      S.of(context).estimationTime + ":",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(
                                      PapricaFormatter.formatDateOnly(context,
                                              widget.delivery.estimationTime) +
                                          "  " +
                                          PapricaFormatter.formatTimeOnly(
                                              context,
                                              widget.delivery.estimationTime),
                                    ),
                                  ),
                                ],
                              ),
                              _deliveryStatus(widget.delivery.status),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? const EdgeInsets.symmetric(vertical: 4.0)
                                    : const EdgeInsets.symmetric(vertical: 0.0),
                                child: Text(
                                  S.of(context).price + ": ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? const EdgeInsets.symmetric(vertical: 4.0)
                                    : const EdgeInsets.symmetric(vertical: 0.0),
                                child: Row(
                                  children: [
                                    Text(
                                      PapricaFormatter.formatNumber(
                                          widget.delivery.price.floor()),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(S.of(context).currency),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: Localizations.localeOf(context)
                                    .languageCode ==
                                    'en'
                                    ? const EdgeInsets.symmetric(vertical: 4.0)
                                    : const EdgeInsets.symmetric(vertical: 0.0),
                                child: Text(
                                  S.of(context).address + ": ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: Localizations.localeOf(context)
                                    .languageCode ==
                                    'en'
                                    ? const EdgeInsets.symmetric(vertical: 4.0)
                                    : const EdgeInsets.symmetric(vertical: 0.0),
                                child: Text(widget.delivery.customerAddress),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? const EdgeInsets.symmetric(vertical: 4.0)
                                    : const EdgeInsets.symmetric(vertical: 0.0),
                                child: Text(
                                  S.of(context).meals + ": ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Colors.white,
                                elevation: 2.0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8.0),
                                  onTap: () {
                                    _openMealsSheet(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0, top: 2.0, right: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, right: 0.8),
                                          child: Text(
                                            S.of(context).viewMeals + "    ",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.delivery.updateRequest != null
                  ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _showUpdateRequest(context),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 5.0,right: 8.0,bottom: 5.0),
                      child: Text(
                        S.of(context).pendingChanges,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    )
                  ],
                ),
              )
                  : Container(),
              FutureBuilder(
                future: _getMapWidget(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data;
                  } else {
                    return Center(child: Text(S.of(context).loadingLocation));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Text _deliveryStatus(int deliveryStatus) {
    switch (deliveryStatus) {
      case ApiHelper.deliveryTypePending: //pending
        return Text(
          S.of(context).Pending,
          style: TextStyle(
              fontSize: 15,
              color: Colors.orange[600],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.deliveryTypeRejected: //rejected
        return Text(
          S.of(context).Rejected,
          style: TextStyle(
              fontSize: 15,
              color: Colors.red[600],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.deliveryTypeCanceled: //cancelled
        return Text(
          S.of(context).cancelledDelivery,
          style: TextStyle(
              fontSize: 15,
              color: Colors.red[300],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.deliveryTypeApproved: //approved
      default:
        return Text(
          S.of(context).approved,
          style: TextStyle(
              fontSize: 15,
              color: Colors.green[600],
              fontWeight: FontWeight.w600),
        ); // roved
        break;
    }
  }

  Future<Widget> _getMapWidget() {
    return Future<Widget>.delayed(Duration(milliseconds: 500), () {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          child: GoogleMap(
            onTap: (latLog) {
              MapUtils.openMap(
                latitude: widget.delivery?.restaurantLatitude,
                longitude: widget.delivery?.restaurantLongitude,
              );
            },
            onMapCreated: _onMapCreated,
            markers: <Marker>[
              Marker(
                  markerId: MarkerId(widget.delivery?.restaurantName),
                  infoWindow: InfoWindow(title: widget.delivery.restaurantName),
                  position: LatLng(widget.delivery?.restaurantLatitude,
                      widget.delivery?.restaurantLongitude))
            ].toSet(),
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.delivery?.restaurantLatitude,
                  widget.delivery?.restaurantLongitude),
              zoom: 12.0,
            ),
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            zoomGesturesEnabled: false,
          ),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCallSelected(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CallRestaurantDialog(
          phoneNumber: widget.delivery?.restaurantPhoneNumber,
          restaurantName: widget.delivery?.restaurantName,
        );
      },
    );
  }

  void _onCancelSelected(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return PapricaInputDialog(
            title: S.of(context).confirmCancelDelivery,
            content: S.of(context).msgCancelDelivery,
            confirmCallback: (text) {
              _onConfirmCancel(context, text);
            },
          );
        }).then((cancelled) {
      if (cancelled != null && cancelled) {
        setState(() {
          widget.delivery.status = ApiHelper.deliveryTypeCanceled;
        });
      }
    });
  }

  _onConfirmCancel(BuildContext context, String reason) {
    ApiClient client = PapricaApiClient();
    CustomerDeliveryApi api = CustomerDeliveryApi(client);
    CancelDeliveryDto data = CancelDeliveryDto.fromJson(
        {'id': widget.delivery.id, 'cancelReason': reason});
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).cancellingDelivery);
    dialog.show();
    api
        .apiServicesAppCustomerDeliveryCancelDeliveryPost(
        delivery: data)
        .then((_) {
      dialog.hide();
      Navigator.of(context).pop(true);
      PapricaToast.showToast(S.of(context).successDeliveryCancel);
    }).catchError((err) {
      dialog.hide();
      Navigator.of(context).pop(false);
      DefaultErrorHandler.handle(context, err);
    });
  }

  void _onUpdateSelected(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DeliveryScreen(
        restaurantId: widget.delivery.restaurantId,
        restaurantName: widget.delivery.restaurantName,
          restaurantLongitude: widget.delivery.restaurantLongitude,
        restaurantLatitude: widget.delivery.restaurantLatitude,
        oldDelivery: widget.delivery.updateRequest == null
            ? DeliveryModel.fromUpcoming(widget.delivery)
            : DeliveryModel.fromUpdateRequest(widget.delivery),
      );
    }));
  }

  _showUpdateRequest(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_context) {
          if (widget.delivery.updateRequest == null) return Container();
          List<Widget> updates = [];

          /// Price
          if (widget.delivery.updateRequest.price != null &&
              widget.delivery.price !=
                  widget.delivery.updateRequest.price)
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Text(S.of(context).price + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(widget.delivery.updateRequest.price
                        .toString())
                  ],
                ),
              ),
            );

          /// address
          if (widget.delivery.updateRequest.address != null &&
              widget.delivery.customerAddress !=
                  widget.delivery.updateRequest.address)
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Text(S.of(context).address + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(widget.delivery.updateRequest.address
                        .toString())
                  ],
                ),
              ),
            );


          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF2F2F2),
              automaticallyImplyLeading: false,
              title: Text(
                S.of(context).deliveryUpdates,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: updates,
                  ),
                  Center(
                    child: RaisedButton(
                      child: Text(
                        S.of(context).cancelDelivery,
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () => _onCancelUpdateRequest(context),
                    ),
                  )
                ],
              ),
            ),
          );
        }).then((canceled) {
      if (canceled != null && canceled) {
        setState(() {
          widget.delivery.updateRequest = null;
        });
      }
    });
  }

  _onCancelUpdateRequest(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SafeArea(
            child: Builder(builder: (_context) {
              return PapricaSimpleDialog(
                title: S.of(context).confirmCancellation,
                content: S.of(context).confirmCancelUpdateRequestDelivery,
                yesButton: FlatButton(
                  child: Text(S.of(context).confirm),
                  onPressed: () {
                    _onConfirmCancelUpdateRequest(context);
                  },
                ),
              );
            }),
          );
        },
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: null,
        transitionDuration: const Duration(milliseconds: 150))
        .then((cancelled) {
      if (cancelled != null && cancelled) {
        Navigator.of(context).pop(cancelled);
      }
    });
  }

  _onConfirmCancelUpdateRequest(BuildContext context) {
    ApiClient client = PapricaApiClient();
    CustomerDeliveryApi api = CustomerDeliveryApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).cancelingUpdate);
    dialog.show();
    EntityDtoInt64 data = EntityDtoInt64(widget.delivery.id);
    api
        .apiServicesAppCustomerDeliveryCancelDeliveryUpdateRequestPost(
        input: data)
        .then((_) {
      dialog.hide();
      Navigator.of(context).pop(true);
      PapricaToast.showToast(S.of(context).successDeliveryCancel);
    }).catchError((err) {
      dialog.hide();
      Navigator.of(context).pop(false);
      DefaultErrorHandler.handle(context, err);
    });
  }
}

class DotsPart extends StatefulWidget {
  final int count;
  final Stream<int> moveStream;

  final int current;

  const DotsPart(
      {Key key, @required this.count, this.moveStream, this.current = 0})
      : super(key: key);

  @override
  _DotsPartState createState() => _DotsPartState();
}

class _DotsPartState extends State<DotsPart> {
  int _current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.count, (index) {
            return Container(
              width: _current == index ? 8.0 : 6.0,
              height: _current == index ? 8.0 : 6.0,
              margin: EdgeInsets.fromLTRB(2, 0, 2, 4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
            );
          })),
    );
  }

  @override
  void initState() {
    super.initState();
    _current = widget.current;
    widget.moveStream?.listen((index) {
      if (index != null && index >= 0) {
        setState(() {
          _current = index;
        });
      }
    });
  }
}

class NoDeliveriesLayout extends StatelessWidget {
  final String mTitle;

  const NoDeliveriesLayout({@required this.mTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          Image(
            height: 170,
            width: 170,
            image: AssetImage('assets/images/no_delivery.png'),
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

class OldDeliverySection extends StatefulWidget {
  final Stream<bool> loadMoreStream;

  const OldDeliverySection({Key key, this.loadMoreStream}) : super(key: key);

  @override
  _OldDeliverySectionState createState() => _OldDeliverySectionState();
}

class _OldDeliverySectionState extends State<OldDeliverySection> {
  bool isLoading = false;
  int skipCount, maxCount;
  ScrollController oldScrollController;
  Future<CustomerOldDeliveriesDto> oldDeliveriesFuture;
  Future deleteOldDeliveryFuture;
  Future<bool> deleteOldDelivery;
  List<CustomerOldDeliveryDto> myOldDelivery = [];
  bool showOldDeliveries;

  bool _doneLoadingOldDeliveries;

  @override
  void initState() {
    showOldDeliveries = false;
    _doneLoadingOldDeliveries = false;
    skipCount = 0;
    maxCount = 3;
    oldScrollController = ScrollController();
    if (ApiTypesHelper().isAuthorized)
      _getOldDeliveriesAsync(mSkipCount: skipCount, mMaxCount: maxCount);

    widget.loadMoreStream?.listen(_loadMoreListener);

    super.initState();
  }

  void _loadMoreListener(bool loadMore) {
    if (!isLoading && loadMore && !_doneLoadingOldDeliveries) {
      skipCount = myOldDelivery.length;
      _getOldDeliveriesAsync(mSkipCount: skipCount, mMaxCount: maxCount);
    }
  }

  Future _getOldDeliveriesAsync({int mSkipCount, int mMaxCount}) {
    ApiClient client = PapricaApiClient();
    CustomerDeliveryApi api = CustomerDeliveryApi(client);
    oldDeliveriesFuture = api.apiServicesAppCustomerDeliveryGetAllOldGet(
        skipCount: mSkipCount ?? 0, maxResultCount: mMaxCount ?? 3);
    if (mounted)
      setState(() {
        oldDeliveriesFuture.then((onValue) {
          if (onValue.oldDeliveries.isNotEmpty)
            myOldDelivery.addAll(onValue.oldDeliveries);
          else
            _doneLoadingOldDeliveries = true;
        });
        isLoading = false;
      });
    return Future.value();
  }

  Future<bool> _deleteOldDelivery(int id) {
    ApiClient client = PapricaApiClient();
    CustomerDeliveryApi api = CustomerDeliveryApi(client);
    deleteOldDeliveryFuture = api.apiServicesAppCustomerDeliveryDeleteOldPost(
        input: EntityDtoInt64(id));
    return deleteOldDeliveryFuture.then((onValue) {
      if (onValue)
        return true;
      else
        return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (false == showOldDeliveries) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            showOldDeliveries = true;
          });
        },
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  S.of(context).oldDeliveries,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Icon(showOldDeliveries
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
      );
    } else {
      return FutureBuilder<CustomerOldDeliveriesDto>(
          future: oldDeliveriesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        showOldDeliveries = false;
                      });
                    },
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              S.of(context).oldDeliveries,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Icon(showOldDeliveries
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: myOldDelivery != null && myOldDelivery.length > 0
                        ? MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                              controller: oldScrollController,
                              shrinkWrap: true,
                              itemCount: myOldDelivery.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    final bool res = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PapricaSimpleDialog(
                                            title: S.of(context).confirm,
                                            content: (S.of(context).sureDelete),
                                            yesButton: FlatButton(
                                                onPressed: () {
                                                  Future<bool> res =
                                                      _deleteOldDelivery(
                                                          myOldDelivery[index]
                                                              .id);
                                                  ProgressDialog
                                                      progressDialog =
                                                      ProgressDialog(context);
                                                  progressDialog.setMessage(
                                                      S.of(context).clearing);
                                                  progressDialog.show();
                                                  res.then((onValue) {
                                                    progressDialog.hide();
                                                    if (onValue)
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    else {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                      PapricaToast.showToast(
                                                          S
                                                              .of(context)
                                                              .deletingFailed,
                                                          ToastType.Error);
                                                    }
                                                  });
                                                },
                                                child:
                                                    Text(S.of(context).delete)),
                                          );
                                        });
                                    return res != null && res;
                                  },
                                  key: Key("KEY-" +
                                      Random().nextInt(1000).toString()),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    setState(() {
                                      myOldDelivery.removeAt(index);
                                    });
                                  },
                                  child: DeliveryCard(
                                    delivery: DeliveryModel.fromOld(
                                        myOldDelivery[index]),
                                    deleteCallback: () {
                                      setState(
                                        () {
                                          myOldDelivery.removeAt(index);
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            ))
                        : Center(
                            child: NoDeliveriesLayout(
                                mTitle: S.of(context).noOldDeliveries)),
                  ),
                  Container(
                    height: isLoading ? 50.0 : 0,
                    color: Colors.white70,
                    child: Center(
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return RequestRetry(
                  message: S.of(context).errorUnknown,
                  retryCallback: _getOldDeliveriesAsync);
              // Todo : two error messages will appear
            }
            return Center(child: Container());
          });
    }
  }
}
