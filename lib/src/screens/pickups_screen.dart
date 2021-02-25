import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/models/pickup_model.dart';
import 'package:paprica/src/utils/map_utils.dart';
import 'package:paprica/src/widgets/carousel_slider.dart';
import 'package:paprica/src/widgets/login_promotion.dart';
import 'package:paprica/src/widgets/pickup_card.dart';
import 'package:paprica/src/widgets/slider.dart';
import 'package:paprica/src/widgets/custom_scroll_behaviour.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';
import '../../widgets.dart';

class PickupsScreen extends StatefulWidget {
  final Stream<bool> refreshStream;

  const PickupsScreen({this.refreshStream});

  @override
  _PickupsScreenState createState() => _PickupsScreenState();
}

class _PickupsScreenState extends State<PickupsScreen>
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
          title: Text(S.of(context).pickups, style: TextStyle(fontSize: 18)),
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
                  UpcomingPickupsSection(
                      refreshStream: streamRefreshController.stream),
                  OldPickupSection(
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

class UpcomingPickupsSection extends StatefulWidget {
  final Stream<bool> refreshStream;

  const UpcomingPickupsSection({this.refreshStream});

  @override
  _UpcomingPickupsSection createState() => _UpcomingPickupsSection();
}

class _UpcomingPickupsSection extends State<UpcomingPickupsSection> {
  List<Widget> _pickupsListWidget = [];
  PickupCoverImage _coverImage;
  Future<CustomerUpcomingPickupsDto> _upcomingPickupsFuture;
  List<CustomerUpcomingPickupDto> _upcomingPickups;
  bool _isLoading = false;

  StreamController<int> moveController;

  @override
  void initState() {
    super.initState();
    moveController = StreamController<int>.broadcast();
    _getUpcomingPickupsAsync();
    widget.refreshStream?.listen(_listener);
  }

  @override
  void dispose() {
    moveController.close();
    super.dispose();
  }

  void _listener(bool refresh) {
    if (refresh != null && refresh && !_isLoading) {
      _getUpcomingPickupsAsync();
    }
  }

  Future _getUpcomingPickupsAsync() {
    ApiClient client = PapricaApiClient();
    CustomerPickupApi api = CustomerPickupApi(client);
    setState(() {
      _upcomingPickupsFuture =
          api.apiServicesAppCustomerPickupGetAllUpcomingGet();
      _isLoading = true;
    });

    _upcomingPickupsFuture.then((_) {
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
    return FutureBuilder<CustomerUpcomingPickupsDto>(
        future: _upcomingPickupsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.upcoming != null &&
                snapshot.data.upcoming.length > 0) {
              _upcomingPickups = snapshot.data.upcoming;
              _coverImage ??= PickupCoverImage(
                  snapshot.data.upcoming[0].restaurantCoverImage);
              _pickupsListWidget = map<Widget>(
                _upcomingPickups,
                (index, pickup) {
                  return NewPickupCard(pickup: pickup);
                },
              ).toList();
              return Stack(
                children: <Widget>[
                  _coverImage,
                  CarouselSlider(
                    items: _pickupsListWidget,
                    height: 550,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index) {
                      _coverImage.state.updateCover(
                          _upcomingPickups[index].restaurantCoverImage);
                      moveController.add(index);
                    },
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: DotsPart(
                        count: _pickupsListWidget.length,
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
                    child: NoPickupsLayout(
                        mTitle: S.of(context).noUpcomingPickups),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(initialIndex: 1)),
                          ModalRoute.withName('/splash'));
                    },
                    child: Text(
                      S.of(context).goToRestaurants,
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
                    retryCallback: _getUpcomingPickupsAsync),
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

class PickupCoverImage extends StatefulWidget {
  final _PickupCoverImageState state = _PickupCoverImageState();
  final String currentCoverPhoto;

  PickupCoverImage(this.currentCoverPhoto);

  @override
  _PickupCoverImageState createState() {
    return state;
  }
}

class _PickupCoverImageState extends State<PickupCoverImage> {
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

class NewPickupCard extends StatefulWidget {
  final CustomerUpcomingPickupDto pickup;

  const NewPickupCard({Key key, this.pickup}) : super(key: key);

  @override
  _NewPickupCardState createState() => _NewPickupCardState();
}

class _NewPickupCardState extends State<NewPickupCard>
    with AutomaticKeepAliveClientMixin<NewPickupCard> {
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
                          widget.pickup.pickupMeals.length,
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
                                          child: Text(widget.pickup
                                              .pickupMeals[index].mealName))),
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Center(
                                          child: Text(
                                              "${widget.pickup.pickupMeals[index].mealPrice}"))),
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Center(
                                          child: Text(
                                              "${widget.pickup.pickupMeals[index].quantity}"))),
                                ],
                              ),
                              widget.pickup.pickupMeals[index].notes != null
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
                                                              .pickup
                                                              .pickupMeals[
                                                                  index]
                                                              .notes !=
                                                          ""
                                                      ? widget
                                                          .pickup
                                                          .pickupMeals[index]
                                                          .notes
                                                      : S.of(context).none,
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
                                  restaurantId: widget.pickup.restaurantId);
                            }));
                          },
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                widget.pickup.restaurantImage),
                            radius: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).pickupAt,
                              ),
                              RestaurantNamedLink(
                                restaurantName: widget.pickup.restaurantName,
                                restaurantId: widget.pickup.restaurantId,
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
                      if (widget.pickup.status == ApiHelper.pickupTypePending ||
                          widget.pickup.status ==
                              ApiHelper.pickupTypeApproved) {
                        items.add(PopupMenuItem(
                            value: 2, child: Text(S.of(context).edit)));
                        items.add(PopupMenuItem(
                            value: 3, child: Text(S.of(context).cancelPickup)));
                      }
                      if ((widget.pickup.status ==
                                  ApiHelper.pickupTypePending ||
                              widget.pickup.status ==
                                  ApiHelper.pickupTypeApproved) &&
                          widget.pickup.updateRequest != null) {
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
                                      S.of(context).time + ":",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(
                                      PapricaFormatter.formatDateOnly(
                                              context, widget.pickup.date) +
                                          "  " +
                                          PapricaFormatter.formatTimeOnly(
                                              context, widget.pickup.date),
                                    ),
                                  ),
                                ],
                              ),
                              _pickupStatus(widget.pickup.status),
                            ],
                          ),
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
                                  S.of(context).totalPrice + ": ",
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
                                          widget.pickup.price.floor()),
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
                          SizedBox(
                            height: 8.0,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _openMealsSheet(context),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  S.of(context).pressToViewMeals,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
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
                                  size: 12.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.pickup.updateRequest != null
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _showUpdateRequest(context),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
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

  Text _pickupStatus(int pickupStatus) {
    switch (pickupStatus) {
      case ApiHelper.pickupTypePending: //pending
        return Text(
          S.of(context).Pending,
          style: TextStyle(
              fontSize: 15,
              color: Colors.orange[600],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.pickupTypeRejected: //rejected
        return Text(
          S.of(context).Rejected,
          style: TextStyle(
              fontSize: 15,
              color: Colors.red[600],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.pickupTypeCanceled: //cancelled
        return Text(
          S.of(context).cancelledPickup,
          style: TextStyle(
              fontSize: 15,
              color: Colors.red[300],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.pickupTypeApproved: //approved
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
                latitude: widget.pickup?.restaurantLatitude,
                longitude: widget.pickup?.restaurantLongitude,
              );
            },
            onMapCreated: _onMapCreated,
            markers: <Marker>[
              Marker(
                  markerId: MarkerId(widget.pickup?.restaurantName),
                  infoWindow: InfoWindow(title: widget.pickup.restaurantName),
                  position: LatLng(widget.pickup?.restaurantLatitude,
                      widget.pickup?.restaurantLongitude))
            ].toSet(),
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.pickup?.restaurantLatitude,
                  widget.pickup?.restaurantLongitude),
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
          phoneNumber: widget.pickup?.restaurantPhoneNumber,
          restaurantName: widget.pickup?.restaurantName,
        );
      },
    );
  }

  void _onCancelSelected(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return PaprikaInputDialog(
            title: S.of(context).confirmCancelPickup,
            content: S.of(context).msgCancelPickup,
            confirmCallback: (text) {
              _onConfirmCancel(context, text);
            },
          );
        }).then((cancelled) {
      if (cancelled != null && cancelled) {
        setState(() {
          widget.pickup.status = ApiHelper.pickupTypeCanceled;
        });
      }
    });
  }

  _onConfirmCancel(BuildContext context, String reason) {
    ApiClient client = PapricaApiClient();
    CustomerPickupApi api = CustomerPickupApi(client);
    CancelPickupDto data = CancelPickupDto.fromJson(
        {'id': widget.pickup.id, 'cancelReason': reason});
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).cancellingPickup);
    dialog.show();
    api.apiServicesAppCustomerPickupCancelPickupPost(pickup: data).then((_) {
      dialog.hide();
      Navigator.of(context).pop(true);
      PapricaToast.showToast(S.of(context).successPickupCancel);
    }).catchError((err) {
      dialog.hide();
      Navigator.of(context).pop(false);
      DefaultErrorHandler.handle(context, err);
    });
  }

  void _onUpdateSelected(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PickupScreen(
        restaurantId: widget.pickup.restaurantId,
        restaurantName: widget.pickup.restaurantName,
        oldPickup: widget.pickup.updateRequest == null
            ? PickupModel.fromUpcoming(widget.pickup)
            : PickupModel.fromUpdateRequest(widget.pickup.updateRequest),
      );
    }));
  }

  _showUpdateRequest(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_context) {
          if (widget.pickup.updateRequest == null) return Container();
          List<Widget> updates = [];

          /// Date
          if (widget.pickup.updateRequest.time != null &&
              (widget.pickup.date.year !=
                      widget.pickup.updateRequest.time.year ||
                  widget.pickup.date.month !=
                      widget.pickup.updateRequest.time.month ||
                  widget.pickup.date.day !=
                      widget.pickup.updateRequest.time.day))
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset("assets/icons/date.png"),
                    ),
                    SizedBox(width: 8),
                    Text(S.of(context).date + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(PapricaFormatter.formatDateOnly(
                        context, widget.pickup.updateRequest.time))
                  ],
                ),
              ),
            );

          /// Time
          if (widget.pickup.updateRequest.time != null &&
              (widget.pickup.date.hour !=
                      widget.pickup.updateRequest.time.hour ||
                  widget.pickup.date.minute !=
                      widget.pickup.updateRequest.time.minute))
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset("assets/icons/clock.png"),
                    ),
                    SizedBox(width: 8),
                    Text(S.of(context).time + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(PapricaFormatter.formatTimeOnly(
                        context, widget.pickup.updateRequest.time))
                  ],
                ),
              ),
            );

          /// Price
          if (widget.pickup.updateRequest.price != null &&
              widget.pickup.price != widget.pickup.updateRequest.price)
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // SizedBox(
                    //   width: 24,
                    //   height: 24,
                    //   child: Image.asset("assets/icons/user.png"),
                    // ),
                    SizedBox(width: 8),
                    Text(S.of(context).price + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(widget.pickup.updateRequest.price.toString())
                  ],
                ),
              ),
            );
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF2F2F2),
              automaticallyImplyLeading: false,
              title: Text(
                S.of(context).pickupUpdates,
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
                        S.of(context).cancelPickup,
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
          widget.pickup.updateRequest = null;
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
                  return PaprikaSimpleDialog(
                    title: S.of(context).confirmCancellation,
                    content: S.of(context).confirmCancelUpdateRequestPickup,
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
    CustomerPickupApi api = CustomerPickupApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).cancelingUpdate);
    dialog.show();
    EntityDtoInt64 data = EntityDtoInt64(widget.pickup.id);
    api
        .apiServicesAppCustomerPickupCancelPickupUpdateRequestPost(input: data)
        .then((_) {
      dialog.hide();
      Navigator.of(context).pop(true);
      PapricaToast.showToast(S.of(context).successPickupCancel);
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

class NoPickupsLayout extends StatelessWidget {
  final String mTitle;

  const NoPickupsLayout({@required this.mTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          Image(
            height: 170,
            width: 170,
            image: AssetImage('assets/images/no_pickup.png'),
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

class OldPickupSection extends StatefulWidget {
  final Stream<bool> loadMoreStream;

  const OldPickupSection({Key key, this.loadMoreStream}) : super(key: key);

  @override
  _OldPickupSectionState createState() => _OldPickupSectionState();
}

class _OldPickupSectionState extends State<OldPickupSection> {
  bool isLoading = false;
  int skipCount, maxCount;
  ScrollController oldScrollController;
  Future<CustomerOldPickupsDto> oldPickupsFuture;
  Future deleteOldPickupFuture;
  Future<bool> deleteOldPickup;
  List<CustomerOldPickupDto> myOldPickup = [];
  bool showOldPickups;

  bool _doneLoadingOldPickups;

  @override
  void initState() {
    showOldPickups = false;
    _doneLoadingOldPickups = false;
    skipCount = 0;
    maxCount = 3;
    oldScrollController = ScrollController();
    if (ApiTypesHelper().isAuthorized)
      _getOldPickupsAsync(mSkipCount: skipCount, mMaxCount: maxCount);

    widget.loadMoreStream?.listen(_loadMoreListener);

    super.initState();
  }

  void _loadMoreListener(bool loadMore) {
    if (!isLoading && loadMore && !_doneLoadingOldPickups) {
      skipCount = myOldPickup.length;
      _getOldPickupsAsync(mSkipCount: skipCount, mMaxCount: maxCount);
    }
  }

  Future _getOldPickupsAsync({int mSkipCount, int mMaxCount}) {
    ApiClient client = PapricaApiClient();
    CustomerPickupApi api = CustomerPickupApi(client);
    oldPickupsFuture = api.apiServicesAppCustomerPickupGetAllOldGet(
        skipCount: mSkipCount ?? 0, maxResultCount: mMaxCount ?? 3);
    if (mounted)
      setState(() {
        oldPickupsFuture.then((onValue) {
          if (onValue.oldPickups.isNotEmpty)
            myOldPickup.addAll(onValue.oldPickups);
          else
            _doneLoadingOldPickups = true;
        });
        isLoading = false;
      });
    return Future.value();
  }

  Future<bool> _deleteOldPickup(int id) {
    ApiClient client = PapricaApiClient();
    CustomerPickupApi api = CustomerPickupApi(client);
    deleteOldPickupFuture = api.apiServicesAppCustomerPickupDeleteOldPost(
        input: EntityDtoInt64(id));
    return deleteOldPickupFuture.then((onValue) {
      if (onValue)
        return true;
      else
        return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (false == showOldPickups) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            showOldPickups = true;
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
                  S.of(context).oldPickups,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Icon(showOldPickups
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
      );
    } else {
      return FutureBuilder<CustomerOldPickupsDto>(
          future: oldPickupsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        showOldPickups = false;
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
                              S.of(context).oldPickups,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Icon(showOldPickups
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: myOldPickup != null && myOldPickup.length > 0
                        ? MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                              controller: oldScrollController,
                              shrinkWrap: true,
                              itemCount: myOldPickup.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    final bool res = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PaprikaSimpleDialog(
                                            title: S.of(context).confirm,
                                            content: (S.of(context).sureDelete),
                                            yesButton: FlatButton(
                                                onPressed: () {
                                                  Future<bool> res =
                                                      _deleteOldPickup(
                                                          myOldPickup[index]
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
                                      myOldPickup.removeAt(index);
                                    });
                                  },
                                  child: PickupCard(
                                    pickup:
                                        PickupModel.fromOld(myOldPickup[index]),
                                    deleteCallback: () {
                                      setState(
                                        () {
                                          myOldPickup.removeAt(index);
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            ))
                        : Center(
                            child: NoPickupsLayout(
                                mTitle: S.of(context).noOldPickups)),
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
                  retryCallback: _getOldPickupsAsync);
              // Todo : two error messages will appear
            }
            return Center(child: Container());
          });
    }
  }
}
