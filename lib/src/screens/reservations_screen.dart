import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/models/reservation_model.dart';
import 'package:paprica/src/utils/map_utils.dart';
import 'package:paprica/src/widgets/carousel_slider.dart';
import 'package:paprica/src/widgets/login_promotion.dart';
import 'package:paprica/src/widgets/reservation_card.dart';
import 'package:paprica/src/widgets/slider.dart';
import 'package:paprica/src/widgets/custom_scroll_behaviour.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';
import '../../widgets.dart';

class ReservationsScreen extends StatefulWidget {
  final Stream<bool> refreshStream;

  const ReservationsScreen({this.refreshStream});

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen>
    with WidgetsBindingObserver {
  ScrollController scrollController;
  StreamController<bool> streamScrollController;
  StreamController<bool> _streamRefreshController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    streamScrollController = StreamController<bool>.broadcast();
    _streamRefreshController = StreamController<bool>.broadcast();
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
      _streamRefreshController.add(true);
    } catch (e) {}
    return Future.value();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollControllerListener);
    streamScrollController.close();
    _streamRefreshController.close();
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
          title: Text(S.of(context).reservations,
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
                  UpcomingReservationsSection(
                      refreshStream: _streamRefreshController.stream),
                  OldReservationSection(
                    loadMoreStream: streamScrollController.stream,
                  ),
                  SizedBox(height: 10, child: Container()),
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

class NoReservationsLayout extends StatelessWidget {
  final String mTitle;

  const NoReservationsLayout({@required this.mTitle});

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

class UpcomingReservationsSection extends StatefulWidget {
  final Stream<bool> refreshStream;

  // final changeHomePageIndexHandler;

  // const UpcomingReservationsSection(this.changeHomePageIndexHandler,{this.refreshStream});
  const UpcomingReservationsSection({this.refreshStream});

  @override
  _UpcomingReservationsSection createState() => _UpcomingReservationsSection();
}

class _UpcomingReservationsSection extends State<UpcomingReservationsSection> {
  List<Widget> _reservationsListWidget = [];
  ReservationCoverImage _coverImage;
  Future<CustomerUpcomingReservationsDto> _upcomingReservationsFuture;
  List<CustomerUpcomingReservationDto> _upcomingReservations;
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
    _getUpcomingReservationsAsync();
    widget.refreshStream?.listen(_listener);
  }

  @override
  void dispose() {
    moveController.close();
    super.dispose();
  }

  void _listener(bool refresh) {
    if (refresh != null && refresh && !_isLoading) {
      _getUpcomingReservationsAsync();
    }
  }

  Future _getUpcomingReservationsAsync() {
    ApiClient client = PapricaApiClient();
    CustomerReservationApi api = CustomerReservationApi(client);
    setState(() {
      _upcomingReservationsFuture =
          api.apiServicesAppCustomerReservationGetAllUpcomingGet();
      _isLoading = true;
    });

    _upcomingReservationsFuture.then((_) {
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
    return FutureBuilder<CustomerUpcomingReservationsDto>(
        future: _upcomingReservationsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.upcoming != null &&
                snapshot.data.upcoming.length > 0) {
              _upcomingReservations = snapshot.data.upcoming;
              _coverImage ??= ReservationCoverImage(
                  snapshot.data.upcoming[0].restaurantCoverImage);
              _reservationsListWidget = map<Widget>(
                _upcomingReservations,
                (index, reservation) {
                  return NewReservationCard(reservation: reservation);
                },
              ).toList();
              return Stack(
                children: <Widget>[
                  _coverImage,
                  CarouselSlider(
                    items: _reservationsListWidget,
                    height: 500,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index) {
                      _coverImage.state.updateCover(
                          _upcomingReservations[index].restaurantCoverImage);
                      moveController.add(index);
                    },
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: DotsPart(
                        count: _reservationsListWidget.length,
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
                    child: NoReservationsLayout(
                        mTitle: S.of(context).noUpcomingReservations),
                  ),
                  GestureDetector(
                    onTap: () {
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
                    retryCallback: _getUpcomingReservationsAsync),
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

class OldReservationSection extends StatefulWidget {
  final Stream<bool> loadMoreStream;

  const OldReservationSection({Key key, this.loadMoreStream}) : super(key: key);

  @override
  _OldReservationSectionState createState() => _OldReservationSectionState();
}

class _OldReservationSectionState extends State<OldReservationSection> {
  bool isLoading = false;
  int skipCount, maxCount;
  ScrollController oldScrollController;
  Future<CustomerOldReservationsDto> oldReservationsFuture;
  Future deleteOldReservationFuture;
  Future<bool> deleteOldReservation;
  List<CustomerOldReservationDto> myOldReservation = [];
  bool showOldReservations;

  bool _doneLoadingOldReservations;

  @override
  void initState() {
    showOldReservations = false;
    _doneLoadingOldReservations = false;
    skipCount = 0;
    maxCount = 3;
    oldScrollController = ScrollController();
    if (ApiTypesHelper().isAuthorized)
      _getOldReservationsAsync(mSkipCount: skipCount, mMaxCount: maxCount);

    widget.loadMoreStream?.listen(_loadMoreListener);

    super.initState();
  }

  void _loadMoreListener(bool loadMore) {
    if (!isLoading && loadMore && !_doneLoadingOldReservations) {
      skipCount = myOldReservation.length;
      _getOldReservationsAsync(mSkipCount: skipCount, mMaxCount: maxCount);
    }
  }

  Future _getOldReservationsAsync({int mSkipCount, int mMaxCount}) {
    ApiClient client = PapricaApiClient();
    CustomerReservationApi api = CustomerReservationApi(client);
    oldReservationsFuture = api.apiServicesAppCustomerReservationGetAllOldGet(
        skipCount: mSkipCount ?? 0, maxResultCount: mMaxCount ?? 3);
    if (mounted)
      setState(() {
        oldReservationsFuture.then((onValue) {
          if (onValue.oldReservations.isNotEmpty)
            myOldReservation.addAll(onValue.oldReservations);
          else
            _doneLoadingOldReservations = true;
        });
        isLoading = false;
      });
    return Future.value();
  }

  Future<bool> _deleteOldReservation(int id) {
    ApiClient client = PapricaApiClient();
    CustomerReservationApi api = CustomerReservationApi(client);
    deleteOldReservationFuture =
        api.apiServicesAppCustomerReservationDeleteOldPost(
            input: EntityDtoInt64(id));
    return deleteOldReservationFuture.then((onValue) {
      if (onValue)
        return true;
      else
        return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (false == showOldReservations) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            showOldReservations = true;
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
                  S.of(context).oldReservations,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Icon(showOldReservations
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
      );
    } else {
      return FutureBuilder<CustomerOldReservationsDto>(
          future: oldReservationsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        showOldReservations = false;
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
                              S.of(context).oldReservations,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Icon(showOldReservations
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: myOldReservation != null &&
                            myOldReservation.length > 0
                        ? MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                              controller: oldScrollController,
                              shrinkWrap: true,
                              itemCount: myOldReservation.length,
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
                                                      _deleteOldReservation(
                                                          myOldReservation[
                                                                  index]
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
                                      myOldReservation.removeAt(index);
                                    });
                                  },
                                  child: ReservationCard(
                                    reservation: ReservationModel.fromOld(
                                        myOldReservation[index]),
                                    deleteCallback: () {
                                      setState(
                                        () {
                                          myOldReservation.removeAt(index);
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            ))
                        : Center(
                            child: NoReservationsLayout(
                                mTitle: S.of(context).noOldReservations)),
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
                  retryCallback: _getOldReservationsAsync);
              // Todo : two error messages will appear
            }
            return Center(child: Container());
          });
    }
  }
}

class NewReservationCard extends StatefulWidget {
  final CustomerUpcomingReservationDto reservation;

  const NewReservationCard({Key key, this.reservation}) : super(key: key);

  @override
  _NewReservationCardState createState() => _NewReservationCardState();
}

class _NewReservationCardState extends State<NewReservationCard>
    with AutomaticKeepAliveClientMixin<NewReservationCard> {
  GoogleMapController mapController;

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
                                  restaurantId:
                                      widget.reservation.restaurantId);
                            }));
                          },
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                widget.reservation.restaurantImage),
                            radius: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).reservationAt,
                              ),
                              RestaurantNamedLink(
                                restaurantName:
                                    widget.reservation.restaurantName,
                                restaurantId: widget.reservation.restaurantId,
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
                      if (widget.reservation.status ==
                              ApiHelper.reservationTypePending ||
                          widget.reservation.status ==
                              ApiHelper.reservationTypeApproved) {
                        items.add(PopupMenuItem(
                            value: 2, child: Text(S.of(context).edit)));
                        items.add(PopupMenuItem(
                            value: 3,
                            child: Text(S.of(context).cancelReservation)));
                      }
                      if ((widget.reservation.status ==
                                  ApiHelper.reservationTypePending ||
                              widget.reservation.status ==
                                  ApiHelper.reservationTypeApproved) &&
                          widget.reservation.updateRequest != null) {
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
                                      "#" + S.of(context).people + ":",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(
                                      widget.reservation.numberOfPeople
                                          .toString(),
                                    ),
                                  ),
                                ],
                              ),
                              _reservationStatus(widget.reservation.status),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 1.0),
                                child: Text(
                                  S.of(context).date + ":",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  PapricaFormatter.formatDateOnly(
                                      context, widget.reservation.date) +
                                      "  " +
                                      PapricaFormatter.formatTimeOnly(
                                          context, widget.reservation.date),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment:
                                widget.reservation.customerAdditionalInfo !=
                                            null &&
                                        widget.reservation
                                            .customerAdditionalInfo.isNotEmpty
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? const EdgeInsets.symmetric(vertical: 4.0)
                                    : const EdgeInsets.symmetric(vertical: 0.0),
                                child: Text(
                                  S.of(context).moreInfo + ": ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.reservation.customerAdditionalInfo !=
                                              null &&
                                          widget.reservation
                                              .customerAdditionalInfo.isNotEmpty
                                      ? widget
                                          .reservation.customerAdditionalInfo
                                      : S.of(context).noAdditionalInfo,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.reservation.updateRequest != null
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

  Text _reservationStatus(int reservationStatus) {
    switch (reservationStatus) {
      case ApiHelper.reservationTypePending: //pending
        return Text(
          S.of(context).Pending,
          style: TextStyle(
              fontSize: 15,
              color: Colors.orange[600],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.reservationTypeRejected: //rejected
        return Text(
          S.of(context).Rejected,
          style: TextStyle(
              fontSize: 15,
              color: Colors.red[600],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.reservationTypeCanceled: //cancelled
        return Text(
          S.of(context).cancelledReservation,
          style: TextStyle(
              fontSize: 15,
              color: Colors.red[300],
              fontWeight: FontWeight.w600),
        );
        break;
      case ApiHelper.reservationTypeApproved: //approved
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
                latitude: widget.reservation?.restaurantLatitude,
                longitude: widget.reservation?.restaurantLongitude,
              );
            },
            onMapCreated: _onMapCreated,
            markers: <Marker>[
              Marker(
                  markerId: MarkerId(widget.reservation?.restaurantName),
                  infoWindow:
                      InfoWindow(title: widget.reservation.restaurantName),
                  position: LatLng(widget.reservation?.restaurantLatitude,
                      widget.reservation?.restaurantLongitude))
            ].toSet(),
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.reservation?.restaurantLatitude,
                  widget.reservation?.restaurantLongitude),
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
          phoneNumber: widget.reservation?.restaurantPhoneNumber,
          restaurantName: widget.reservation?.restaurantName,
        );
      },
    );
  }

  void _onUpdateSelected(BuildContext context) {
    showDialog<ReservationModel>(
        context: context,
        builder: (context) {
          return ReservationDialog(
            widget.reservation.restaurantId,
            widget.reservation.restaurantName,
            widget.reservation.maxPeopleAllowed,
            oldReservation: widget.reservation.updateRequest == null
                ? ReservationModel.fromUpcoming(widget.reservation)
                : ReservationModel.fromUpdateRequest(
                    widget.reservation.updateRequest,
                    widget.reservation.id,
                    widget.reservation.restaurantName,
                    widget.reservation.restaurantImage),
          );
        }).then((reservation) {
      if (reservation != null) {
        setState(() {
          if (widget.reservation.status == ApiHelper.reservationTypePending) {
            widget.reservation.date = reservation.date;
            widget.reservation.numberOfPeople = reservation.numberOfPeople;
            widget.reservation.customerAdditionalInfo = reservation.moreInfo;
            widget.reservation.personPhoneNumber = reservation.phoneNumber;
            widget.reservation.personName = reservation.personName;
          } else {
            widget.reservation.updateRequest =
                UpdateReservationRequestDto.fromJson({
              'reservationId': reservation.id,
              'time': reservation.date.toIso8601String(),
              'numberOfPeople': reservation.numberOfPeople,
              'customerAdditionalInfo': reservation.moreInfo,
              'phoneNumber': reservation.phoneNumber,
              'personName': reservation.personName,
            });
          }
        });
        PapricaToast.showToast(S.of(context).successReservationUpdate);
      }
    });
  }

  void _onCancelSelected(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return PapricaInputDialog(
            title: S.of(context).confirmCancelReservation,
            content: S.of(context).msgCancelReservation,
            confirmCallback: (text) {
              _onConfirmCancel(context, text);
            },
          );
        }).then((cancelled) {
      if (cancelled != null && cancelled) {
        setState(() {
          widget.reservation.status = ApiHelper.reservationTypeCanceled;
        });
      }
    });
  }

  _onConfirmCancel(BuildContext context, String reason) {
    ApiClient client = PapricaApiClient();
    CustomerReservationApi api = CustomerReservationApi(client);
    CancelReservationDto data = CancelReservationDto.fromJson(
        {'id': widget.reservation.id, 'cancelReason': reason});
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).cancellingReservation);
    dialog.show();
    api
        .apiServicesAppCustomerReservationCancelReservationPost(
            reservation: data)
        .then((_) {
      dialog.hide();
      Navigator.of(context).pop(true);
      PapricaToast.showToast(S.of(context).successReservationCancel);
    }).catchError((err) {
      dialog.hide();
      Navigator.of(context).pop(false);
      DefaultErrorHandler.handle(context, err);
    });
  }

  _showUpdateRequest(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_context) {
          if (widget.reservation.updateRequest == null) return Container();
          List<Widget> updates = [];

          /// Date
          if (widget.reservation.updateRequest.time != null &&
              (widget.reservation.date.year !=
                      widget.reservation.updateRequest.time.year ||
                  widget.reservation.date.month !=
                      widget.reservation.updateRequest.time.month ||
                  widget.reservation.date.day !=
                      widget.reservation.updateRequest.time.day))
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
                        context, widget.reservation.updateRequest.time))
                  ],
                ),
              ),
            );

          /// Time
          if (widget.reservation.updateRequest.time != null &&
              (widget.reservation.date.hour !=
                      widget.reservation.updateRequest.time.hour ||
                  widget.reservation.date.minute !=
                      widget.reservation.updateRequest.time.minute))
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
                        context, widget.reservation.updateRequest.time))
                  ],
                ),
              ),
            );

          /// People
          if (widget.reservation.updateRequest.numberOfPeople != null &&
              widget.reservation.numberOfPeople !=
                  widget.reservation.updateRequest.numberOfPeople)
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset("assets/icons/user.png"),
                    ),
                    SizedBox(width: 8),
                    Text(S.of(context).people + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(widget.reservation.updateRequest.numberOfPeople
                        .toString())
                  ],
                ),
              ),
            );

          /// Information
          if (widget.reservation.updateRequest.customerAdditionalInfo != null &&
              widget.reservation.customerAdditionalInfo !=
                  widget.reservation.updateRequest.customerAdditionalInfo)
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.info,
                        size: 24, color: Theme.of(context).primaryColor),
                    SizedBox(width: 8),
                    Text(S.of(context).moreInformation + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(
                        widget.reservation.updateRequest.customerAdditionalInfo)
                  ],
                ),
              ),
            );

          /// Phone Number
          if (widget.reservation.updateRequest.phoneNumber != null &&
              widget.reservation.personPhoneNumber !=
                  widget.reservation.updateRequest.phoneNumber)
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.phone,
                        size: 24, color: Theme.of(context).primaryColor),
                    SizedBox(width: 8),
                    Text(S.of(context).phoneNumber + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(widget.reservation.updateRequest.phoneNumber)
                  ],
                ),
              ),
            );

          /// Phone Number
          if (widget.reservation.updateRequest.personName != null &&
              widget.reservation.personName !=
                  widget.reservation.updateRequest.personName)
            updates.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.person,
                        size: 24, color: Theme.of(context).primaryColor),
                    SizedBox(width: 8),
                    Text(S.of(context).customerName + ": ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Text(widget.reservation.updateRequest.personName)
                  ],
                ),
              ),
            );
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF2F2F2),
              automaticallyImplyLeading: false,
              title: Text(
                S.of(context).reservationUpdates,
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
                        S.of(context).cancelUpdate,
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
          widget.reservation.updateRequest = null;
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
                    content:
                        S.of(context).confirmCancelUpdateRequestReservation,
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
    CustomerReservationApi api = CustomerReservationApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).cancelingUpdate);
    dialog.show();
    EntityDtoInt64 data = EntityDtoInt64(widget.reservation.id);
    api
        .apiServicesAppCustomerReservationCancelReservationUpdateRequestPost(
            input: data)
        .then((_) {
      dialog.hide();
      Navigator.of(context).pop(true);
      PapricaToast.showToast(S.of(context).successReservationCancel);
    }).catchError((err) {
      dialog.hide();
      Navigator.of(context).pop(false);
      DefaultErrorHandler.handle(context, err);
    });
  }
}

class ReservationCoverImage extends StatefulWidget {
  final _ReservationCoverImageState state = _ReservationCoverImageState();
  final String currentCoverPhoto;

  ReservationCoverImage(this.currentCoverPhoto);

  @override
  _ReservationCoverImageState createState() {
    return state;
  }
}

class _ReservationCoverImageState extends State<ReservationCoverImage> {
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
//    return FadeInImage.assetNetwork(
//      image: (this.url),
//      width: MediaQuery.of(context).size.width,
//      height: 180,
//      fit: BoxFit.cover,
//      placeholder: "assets/images/placeholder.png",
//    );

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

class _ReservationsPagePlaceHolder extends StatefulWidget {
  final Widget child;
  final RetryCallback getData;

  _ReservationsPagePlaceHolder(this.child, {this.getData});

  @override
  _ReservationsPagePlaceHolderState createState() =>
      _ReservationsPagePlaceHolderState();
}

class _ReservationsPagePlaceHolderState
    extends State<_ReservationsPagePlaceHolder> {
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: widget.getData,
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehaviour(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                ),
                Center(child: this.widget.child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
