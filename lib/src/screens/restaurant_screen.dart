import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paprika/pages.dart';
import 'package:paprika/src/models/meal_share.dart';
import 'package:paprika/src/models/menu_state.dart';
import 'package:paprika/src/models/reviews_state.dart';
import 'package:paprika/src/utils/api_types_helper.dart';
import 'package:paprika/src/utils/paprica_api_client.dart';
import 'package:paprika/translations.dart';
import 'package:paprika/widgets.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';

class RestaurantHome extends StatefulWidget {
  final int restaurantId;

  final MealShare mealShare;

  const RestaurantHome({Key key, this.restaurantId, this.mealShare})
      : super(key: key);

  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

typedef ReviewStateStore(ReviewDto newState);

class _RestaurantHomeState extends State<RestaurantHome>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Future<RestaurantHomeDto> futureRestData;
  RestaurantHomeDto restData;
  ScrollController _scrollController;
  TabController _tabController;
  StreamController<bool> _screenActivity;

  MenuState menuState;
  ReviewsState reviewsState;

  CachedNetworkImageProvider widgetLogoImage;

  get _reservable {
    return restData.settings.services
        .where((service) => service.code == 'reservation')
        .isNotEmpty;
  }

  get _pickupable {
    return restData.settings.services
        .where((service) => service.code == 'pickup')
        .isNotEmpty;
  }

  get _deliverable {
    return restData.settings.services
        .where((service) => service.code == 'delivery')
        .isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _getRestaurantDataAsync();
    });
    WidgetsBinding.instance.addObserver(this);

    menuState ??= MenuState(isGrid: true);
    reviewsState ??= ReviewsState();
    _scrollController = ScrollController();
    _tabController = TabController(
        initialIndex: widget.mealShare != null ? 1 : 0, length: 3, vsync: this);
    _screenActivity = StreamController<bool>.broadcast();
    _tabController.addListener(() {
      if (_scrollController.offset != 0) {
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: ElasticInOutCurve());
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    _isFavorite = null;
    _isNotificationsOn = null;
    _isMusicPlaying = null;
    _wasMusicPlaying = null;
    _audioPlayer = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _onScreenInactive();
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

  void _onScreenInactive() {
    if (_screenActivity.hasListener) _screenActivity.add(false);
  }

  void _onScreenActive() {
    _screenActivity.add(true);
  }

  int get currentIndex {
    return _tabController.index;
  }

  scrollDelegate(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(milliseconds: 1), curve: ElasticInCurve());
  }

  storeMenuState(MenuState newState) {
    menuState = newState;
  }

  storeReviewsState(ReviewsState newState) {
    reviewsState = newState;
  }

  Future _getRestaurantDataAsync() {
    if (widget.restaurantId == null &&
        (widget.mealShare == null ||
            widget.mealShare.restaurantId == null ||
            widget.mealShare.restaurantId <= 0)) {
      return Future.value();
    }
    ApiClient client = PapricaApiClient();
    CustomerRestaurantApi apiInstance = CustomerRestaurantApi(client);
    setState(() {
      futureRestData = apiInstance.apiServicesAppCustomerRestaurantGetGet(
          id: widget.restaurantId ?? widget.mealShare.restaurantId);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.restaurantId == null &&
        (widget.mealShare == null ||
            widget.mealShare.restaurantId == null ||
            widget.mealShare.restaurantId <= 0)) {
      Navigator.of(context).pop();
    }
    return WillPopScope(
      onWillPop: () {
        if (_tabController.index == 1 && !menuState.isGrid) {
          setState(() {
            menuState.isGrid = true;
          });
        } else {
          _screenActivity.add(false);
          Navigator.of(context).pop();
        }
        return;
      },
      child: FutureBuilder<RestaurantHomeDto>(
          future: futureRestData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              restData = snapshot.data;
              widgetLogoImage ??=
                  CachedNetworkImageProvider(restData.logoImage);
              return Scaffold(
                bottomSheet: restData.settings.services.length == 0
                    ? Container(
                        height: 0.0,
                        width: 0.0,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 0.0,
                                    width: 0.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: _reservable
                                        ? InkWell(
                                            onTap: () {
                                              _onReservePressed(context);
                                            },
                                            child: Center(
                                              child: Text(
                                                S.of(context).reserveNow,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          )
                                        : _pickupable
                                            ? InkWell(
                                                onTap: () {
                                                  _onOrderPickupPressed(
                                                      context);
                                                },
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).orderPickup,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )),
                                              )
                                            : _deliverable
                                                ? InkWell(
                                                    onTap: () {
                                                      _onOrderDeliveryPressed(
                                                          context);
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .orderDelivery,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 0.0,
                                                    width: 0.0,
                                                  ),
                                  ),
                                  restData.settings.services.length > 1
                                      ? PopupMenuButton<int>(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            child: Center(
                                              child: SizedBox(
                                                height: 8,
                                                child: Image.asset(
                                                    "assets/icons/more_filled_black.png"),
                                              ),
                                            ),
                                          ),
                                          itemBuilder: (context) {
                                            List<PopupMenuItem<int>> items = [];
                                            if (_reservable && _pickupable)
                                              items.add(PopupMenuItem(
                                                  value: 1,
                                                  child: Text(S
                                                      .of(context)
                                                      .orderPickup)));
                                            if ((_reservable || _pickupable) &&
                                                _deliverable) {
                                              items.add(PopupMenuItem(
                                                  value: 2,
                                                  child: Text(S
                                                      .of(context)
                                                      .orderDelivery)));
                                            }
                                            return items;
                                          },
                                          onSelected: (selection) {
                                            switch (selection) {
                                              case 1:
                                                _onOrderPickupPressed(context);
                                                break;
                                              case 2:
                                                _onOrderDeliveryPressed(
                                                    context);
                                                break;
                                            }
                                          },
                                        )
                                      : Container(
                                          height: 0.0,
                                          width: 0.0,
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                body: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            textDirection:
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        expandedHeight: 160.0,
                        floating: false,
                        pinned: true,
                        titleSpacing: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          title: Title(snapshot.data.name, _scrollController),
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: restData.coverImage,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image(
                                  image: AssetImage(
                                      "assets/images/placeholder.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.black38,
                                      Colors.black12,
                                      Colors.black12,
                                      Colors.black
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? 0
                                    : null,
                                right: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? null
                                    : 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Container(
                                                  child: Container(
                                                    width: 55.0,
                                                    height: 55.0,
                                                    decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                            image:
                                                                widgetLogoImage)),
                                                  ),
                                                  decoration: new BoxDecoration(
                                                    border: new Border.all(
                                                      width: 1.0,
                                                      color: Colors.transparent,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent,
                                                  )),
                                              decoration: new BoxDecoration(
                                                border: new Border.all(
                                                  width: 2.0,
                                                  color: snapshot.data.isOpen
                                                      ? Colors.green
                                                      : Colors.grey,
                                                ),
                                                shape: BoxShape.circle,
                                                color: Color(0xffa5a5a5),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth: 140),
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 15, 0, 0),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Text(snapshot.data.name,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        22,
                                                                        0,
                                                                        0),
                                                                child: _getRestaurantOpenLabel(
                                                                    snapshot
                                                                        .data))
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? 0
                                      : null,
                                  left: Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? null
                                      : 0,
                                  bottom: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ActionsRow(
                                        restData,
                                        _scrollController,
                                        false,
                                        _screenActivity.stream),
                                  )),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          ActionsRow(restData, _scrollController, true,
                              _screenActivity.stream),
                        ],
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _CustomTabsSliverDelegate(
                          currentIndex,
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RestaurantTab(
                                    0,
                                    "assets/icons/home_filled.png",
                                    "assets/icons/home_empty.png",
                                    S.of(context).homePage,
                                    _tabController),
                                DotsSeparator(),
                                RestaurantTab(
                                    1,
                                    "assets/icons/menu_filled.png",
                                    "assets/icons/menu_empty.png",
                                    S.of(context).menu,
                                    _tabController),
                                DotsSeparator(),
                                RestaurantTab(
                                    2,
                                    "assets/icons/star_filled.png",
                                    "assets/icons/star_empty.png",
                                    S.of(context).reviews,
                                    _tabController),
                              ],
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      RestaurantHomePage(snapshot.data),
                      RestaurantMenuPage(restData, menuState, storeMenuState,
                          _scrollController, scrollDelegate,
                          mealShare: widget.mealShare),
                      RestaurantReviewsPage(reviewsState, storeReviewsState,
                          snapshot.data, _scrollController),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return _RestaurantPlaceHolder(RequestRetry(
                  message: S.of(context).errorUnknown,
                  retryCallback: _getRestaurantDataAsync));
            }
            return _RestaurantPlaceHolder(CircularProgressIndicator());
          }),
    );
  }

  void _onReservePressed(context) {
    _screenActivity.add(false);
    if (ApiTypesHelper().isAuthorized) {
      _showReservationDialog();
    } else {
      showDialog(
          context: context,
          builder: (_context) {
            return PaprikaSimpleDialog(
              title: S.of(context).pleaseLoginInOrderToReserve,
              yesButton: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LogInScreen(asAService: true)))
                        .then((loggedIn) {
                      if (loggedIn != null && loggedIn) {
                        _showReservationDialog();
                      } else {
                        PaprikaToast.showToast(S
                            .of(context)
                            .loggingInRequired(S.of(context).actionReserve));
                      }
                    });
                  },
                  child: Text(S.of(context).logIn)),
            );
          });
    }
  }

  void _onOrderPickupPressed(context) {
    _screenActivity.add(false);
    if (ApiTypesHelper().isAuthorized) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return PickupScreen(
          restaurantId: widget.restaurantId,
          restaurantName: restData.name,
        );
      }));
    } else {
      showDialog(
          context: context,
          builder: (_context) {
            return PaprikaSimpleDialog(
              title: S.of(context).pleaseLoginInOrderToOrderPickup,
              yesButton: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LogInScreen(asAService: true)))
                        .then((loggedIn) {
                      if (loggedIn != null && loggedIn) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return PickupScreen(
                            restaurantId: widget.restaurantId,
                            restaurantName: restData.name,
                          );
                        }));
                      } else {
                        PaprikaToast.showToast(S
                            .of(context)
                            .loggingInRequired(S.of(context).actionPickup));
                      }
                    });
                  },
                  child: Text(S.of(context).logIn)),
            );
          });
    }
  }

  void _onOrderDeliveryPressed(context) {
    _screenActivity.add(false);
    if (ApiTypesHelper().isAuthorized) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return DeliveryScreen(
          restaurantId: widget.restaurantId,
          restaurantName: restData.name,
          restaurantLongitude: restData.longitude,
          restaurantLatitude: restData.latitude,
        );
      }));
    } else {
      showDialog(
          context: context,
          builder: (_context) {
            return PaprikaSimpleDialog(
              title: S.of(context).pleaseLoginInOrderToOrderDelivery,
              yesButton: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LogInScreen(asAService: true)))
                        .then((loggedIn) {
                      if (loggedIn != null && loggedIn) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DeliveryScreen(
                            restaurantId: widget.restaurantId,
                            restaurantName: restData.name,
                            restaurantLongitude: restData.longitude,
                            restaurantLatitude: restData.latitude,
                          );
                        }));
                      } else {
                        PaprikaToast.showToast(S
                            .of(context)
                            .loggingInRequired(S.of(context).actionDelivery));
                      }
                    });
                  },
                  child: Text(S.of(context).logIn)),
            );
          });
    }
  }

  void _showReservationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => ReservationDialog(restData?.id,
            restData?.name, restData?.settings?.maxPeopleAllowed)).then((ok) {
      if (ok != null)
        showDialog(
          context: context,
          builder: (BuildContext context) => MessageDialog(
            message: S.of(context).successReservation,
            footer: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _viewMyReservations(context),
              child: Text(S.of(context).viewReservations,
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ),
        );
    });
  }

  void _viewMyReservations(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ReservationsScreen();
    }));
  }

  _getRestaurantOpenLabel(RestaurantHomeDto data) {
    if (data.isOpen)
      return Text(S.of(context).opened,
          style: TextStyle(color: Colors.green, fontSize: 12));
    else
      return Text(S.of(context).closed,
          style: TextStyle(color: Colors.grey, fontSize: 12));
  }
}

class _RestaurantPlaceHolder extends StatelessWidget {
  final Widget child;

  _RestaurantPlaceHolder(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  textDirection:
                      Localizations.localeOf(context).languageCode == 'en'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(S.of(context).loading),
              expandedHeight: 160.0,
              floating: false,
              pinned: true,
              titleSpacing: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Container(
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.all(2.0),
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Shimmer.fromColors(
                                                  baseColor: Colors.white30,
                                                  highlightColor:
                                                      Colors.white70,
                                                  child: Container(
                                                    width: 55.0,
                                                    height: 55.0,
                                                    decoration:
                                                        new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 6),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.white30,
                                                        highlightColor:
                                                            Colors.white70,
                                                        child: Container(
                                                          width: 120.0,
                                                          height: 14.0,
                                                          decoration:
                                                              new BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.white30,
                                                        highlightColor:
                                                            Colors.white70,
                                                        child: Container(
                                                          width: 80.0,
                                                          height: 14.0,
                                                          decoration:
                                                              new BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.white30,
                                              highlightColor: Colors.white70,
                                              child: Container(
                                                width: 100.0,
                                                height: 24.0,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.red,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Center(child: this.child),
      ),
    );
  }
}

class _CustomTabsSliverDelegate extends SliverPersistentHeaderDelegate {
  _CustomTabsSliverDelegate(this.currentTab, this.widget);

  Widget widget;
  int currentTab;

  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 80;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(_CustomTabsSliverDelegate oldDelegate) {
    return currentTab != oldDelegate.currentTab;
  }
}

class Title extends StatefulWidget {
  final ScrollController scrollController;
  final String title;

  const Title(this.title, this.scrollController);

  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<Title> {
  double offset = 0;

  bool get _showTitle {
    return offset > 85;
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController..addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController..removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _showTitle ? 1 : 0,
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          height: 25,
          child: Text(widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)),
      duration: Duration(milliseconds: 500),
    );
  }

  void _scrollListener() {
    setState(() {
      offset = widget.scrollController.offset;
    });
  }
}

class RestaurantTab extends StatefulWidget {
  final TabController tabController;
  final int index;
  final String title;
  final String selectedImage;
  final String unSelectedImage;

  RestaurantTab(this.index, this.selectedImage, this.unSelectedImage,
      this.title, this.tabController);

  @override
  _RestaurantTabState createState() => _RestaurantTabState();
}

class _RestaurantTabState extends State<RestaurantTab> {
  @override
  void initState() {
    super.initState();
    widget.tabController..addListener(_tabListener);
  }

  @override
  void dispose() {
    widget.tabController..removeListener(_tabListener);
    super.dispose();
  }

  void _tabListener() {
    setState(() {});
  }

  int get currentIndex {
    return widget.tabController.index;
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => _onTabPressed(widget.index),
      splashColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: widget.index == 0 ||
                    (widget.index == 2 &&
                        Localizations.localeOf(context).languageCode == 'ar')
                ? 4
                : 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(currentIndex == widget.index
                  ? widget.selectedImage
                  : widget.unSelectedImage),
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.title,
                style: TextStyle(
                  color: widget.index == currentIndex
                      ? Theme.of(context).primaryColor
                      : Colors.black45,
                )),
          ],
        ),
      ),
    );
  }

  _onTabPressed(int index) {
    widget.tabController.animateTo(index);
  }
}

AudioPlayer _audioPlayer;
bool _isMusicPlaying;

bool _wasMusicPlaying;
bool _isFavorite;
bool _isNotificationsOn;

class ActionsRow extends StatefulWidget {
  final ScrollController scrollController;
  final Stream<bool> screenActivityStream;
  final bool isExtra;
  final RestaurantHomeDto restData;

  const ActionsRow(this.restData, this.scrollController, this.isExtra,
      this.screenActivityStream);

  @override
  _ActionsRowState createState() => _ActionsRowState();
}

class _ActionsRowState extends State<ActionsRow> {
  bool isAddingToFavorite = false;

  bool isAddingToNotificationsOn = false;

  bool downloading = false;

  bool loadingShareApps = false;

  double offset = 0;

  get _isFavoriteColor {
    if (isAddingToFavorite)
      return Color(0xffcccccc);
    else
      return _isFavorite != null && _isFavorite
          ? Colors.redAccent
          : Colors.white;
  }

  get _isNotificationsOnColor {
    if (isAddingToNotificationsOn)
      return Color(0xffcccccc);
    else
      return _isNotificationsOn != null && _isNotificationsOn
          ? Colors.redAccent
          : Colors.white;
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer ??= AudioPlayer();
    _isFavorite ??= widget.restData.isFavorite;
    _isNotificationsOn ??= widget.restData.isNotificationsOn;
    _isMusicPlaying ??= false;
    if (widget.isExtra) {
      widget.scrollController..addListener(_scrollListener);
    }
    widget.screenActivityStream.listen((isScreenActive) {
      streamCallback(isScreenActive);
    });
  }

  @override
  void dispose() {
    widget.scrollController..removeListener(_scrollListener);
    super.dispose();
  }

  void streamCallback(bool isScreenActive) {
    if (false == isScreenActive) {
      _wasMusicPlaying = _isMusicPlaying;
      stop();
    } else {
      if (_wasMusicPlaying != null && _wasMusicPlaying) play();
    }
  }

  bool get _showActions {
    return offset > 85;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isExtra) {
      return AnimatedOpacity(
        opacity: _showActions ? 1 : 0,
        duration: Duration(milliseconds: 500),
        child: Row(
          children: getActions(),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: getActions(),
      );
    }
  }

  List<Widget> getActions() {
    return [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _actionCallRestaurant(context),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(Icons.phone, color: Colors.white),
        ),
      ),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _actionShare,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(Icons.share, color: Colors.white),
        ),
      ),
      widget.restData.audioTrack != null &&
              widget.restData.audioTrack.isNotEmpty
          ? GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _actionToggleMusic,
              child: Padding(
                  padding: const EdgeInsets.all(4.0), child: _getMusicIcon()),
            )
          : Container(),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _onTapAddToFavorite();
          if (!ApiTypesHelper().isAuthorized) {
            _actionToggleMusic();
          }
        },
        child: Padding(
            padding: Localizations.localeOf(context).languageCode == "en"
                ? const EdgeInsets.only(left: 4, right: 8.0)
                : const EdgeInsets.only(left: 8, right: 4.0),
            child: Icon(Icons.favorite, color: _isFavoriteColor)),
      ),
      _isFavorite
          ? GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _onTapChangeRestaurantNotifications,
              child: Padding(
                  padding: Localizations.localeOf(context).languageCode == "en"
                      ? const EdgeInsets.only(left: 4, right: 8.0)
                      : const EdgeInsets.only(left: 8, right: 4.0),
                  child: Icon(Icons.notifications,
                      color: _isNotificationsOnColor)),
            )
          : Container(),
    ];
  }

  void _actionAddToFavorite() {
    if (isAddingToFavorite) return;

    setState(() {
      isAddingToFavorite = true;
    });
    ApiClient client = PapricaApiClient();
    var restaurantApi = CustomerRestaurantApi(client);
    AddFavoriteRestaurantDto input = AddFavoriteRestaurantDto.fromJson(
        {"restaurantId": widget.restData?.id});
    if (_isFavorite) {
      restaurantApi
          .apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost(
              input: input)
          .then((_) {
        if (mounted) {
          setState(() {
            isAddingToFavorite = false;
            _isFavorite = false;
            _isNotificationsOn = false;
          });
        }
        PaprikaToast.showToast(
            S
                .of(context)
                .restaurantRemovedFromFavorites(widget.restData?.name ?? ""),
            ToastType.Normal);
      }).catchError((_) {
        if (mounted) {
          setState(() {
            isAddingToFavorite = false;
          });
        }
      });
    } else {
      restaurantApi
          .apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost(
              input: input)
          .then((_) {
        if (mounted) {
          setState(() {
            isAddingToFavorite = false;
            _isFavorite = true;
          });
        }
        PaprikaToast.showToast(
            S
                .of(context)
                .restaurantAddedToFavorites(widget.restData?.name ?? ""),
            ToastType.Normal);
      }).catchError((_) {
        if (mounted) {
          setState(() {
            isAddingToFavorite = false;
          });
        }
      });
    }
  }

  void _actionChangeRestaurantNotifications() {
    if (isAddingToNotificationsOn) return;

    setState(() {
      isAddingToNotificationsOn = true;
    });
    ApiClient client = PapricaApiClient();
    var restaurantApi = CustomerRestaurantApi(client);

    if (_isNotificationsOn) {
      ChangeRestaurantNotificationsDto input =
          ChangeRestaurantNotificationsDto.fromJson({
        "restaurantId": widget.restData?.id,
        "isNotificationsOn": false
      });
      restaurantApi
          .apiServicesAppCustomerRestaurantChangeRestaurantNotificationsPost(
              input: input)
          .then((_) {
        if (mounted) {
          setState(() {
            isAddingToNotificationsOn = false;
            _isNotificationsOn = false;
          });
        }
        PaprikaToast.showToast(
            S
                .of(context)
                .turnOffRestaurantNotifications(widget.restData?.name ?? ""),
            ToastType.Normal);
      }).catchError((_) {
        if (mounted) {
          setState(() {
            isAddingToNotificationsOn = false;
          });
        }
      });
    } else {
      ChangeRestaurantNotificationsDto input =
          ChangeRestaurantNotificationsDto.fromJson(
              {"restaurantId": widget.restData?.id, "isNotificationsOn": true});
      restaurantApi
          .apiServicesAppCustomerRestaurantChangeRestaurantNotificationsPost(
              input: input)
          .then((_) {
        if (mounted) {
          setState(() {
            isAddingToNotificationsOn = false;
            _isNotificationsOn = true;
          });
        }
        PaprikaToast.showToast(
            S
                .of(context)
                .turnOnRestaurantNotifications(widget.restData?.name ?? ""),
            ToastType.Normal);
      }).catchError((_) {
        if (mounted) {
          setState(() {
            isAddingToNotificationsOn = false;
          });
        }
      });
    }
  }

  void _actionToggleMusic() {
    _isMusicPlaying ? pause() : play();
  }

  void _actionCallRestaurant(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CallRestaurantDialog(
          phoneNumber: widget.restData?.phoneNumber,
          restaurantName: widget.restData.name,
        );
      },
    );
  }

  void _actionShare() {
    Share.share(S.of(context).shareText(
        widget.restData.name,
        "https://links.paprika-sy.com/restaurant/" +
            widget.restData.id.toString()));
  }

  Future<void> play() async {
    if (mounted) {
      setState(() {
        downloading = true;
      });
    }
    if (_isMusicPlaying != null && !_isMusicPlaying) {
      _audioPlayer.setVolume(1);
      _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
      _audioPlayer.onPlayerStateChanged.listen((state) {});
      _audioPlayer.play(widget.restData.audioTrack).then((status) {
        if (mounted) {
          setState(() {
            downloading = false;
            if (status == 1) _isMusicPlaying = true;
          });
        }
      }).catchError((err) {
        setState(() {
          downloading = false;
          _isMusicPlaying = false;
        });
        PaprikaToast.showToast(S.of(context).errorPlayingAudio);
      });
    }
  }

  Future<void> pause() async {
    if (_isMusicPlaying != null && _isMusicPlaying) {
      _audioPlayer.pause().then((status) {
        if (mounted) {
          setState(() {
            _isMusicPlaying = false;
            downloading = false;
          });
        }
      }).catchError((err) {
        setState(() {
          downloading = false;
          _isMusicPlaying = false;
        });
      });
    }
  }

  Future<void> stop() async {
    if (_isMusicPlaying != null && _isMusicPlaying) {
      _audioPlayer.stop().then((status) {
        if (mounted) {
          setState(() {
            _isMusicPlaying = false;
            downloading = false;
          });
        }
      }).catchError((err) {
        setState(() {
          downloading = false;
          _isMusicPlaying = false;
        });
      });
    }
  }

  void _scrollListener() {
    setState(() {
      offset = widget.scrollController.offset;
    });
  }

  Widget _getMusicIcon() {
    if (_isMusicPlaying != null && _isMusicPlaying && !downloading)
      return SizedBox(
        height: 24,
        width: 24,
        child: SpinKitWave(
          type: SpinKitWaveType.center,
          size: 16,
          itemBuilder: (_, index) {
            return Container(
              color: Colors.redAccent,
            );
          },
        ),
      );
    else if (downloading)
      return SizedBox(
        height: 24,
        width: 24,
        child: SpinKitThreeBounce(color: Colors.white),
      );
    else
      return Icon(Icons.music_note,
          color: _isMusicPlaying != null && _isMusicPlaying
              ? Colors.redAccent
              : Colors.white);
  }

  void _onTapAddToFavorite() {
    if (ApiTypesHelper().isAuthorized) {
      _actionAddToFavorite();
    } else {
      showDialog(
          context: context,
          builder: (_context) {
            return PaprikaSimpleDialog(
              title: S
                  .of(context)
                  .loggingInRequired(S.of(context).actionAddToFavorite),
              yesButton: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LogInScreen(asAService: true)))
                        .then((loggedIn) {
                      if (loggedIn != null && loggedIn) {
                        _actionAddToFavorite();
                      } else {
                        PaprikaToast.showToast(S.of(context).loggingInRequired(
                            S.of(context).actionAddToFavorite));
                      }
                    });
                  },
                  child: Text(S.of(context).logIn)),
            );
          });
    }
  }

  void _onTapChangeRestaurantNotifications() {
    if (ApiTypesHelper().isAuthorized) {
      _actionChangeRestaurantNotifications();
    } else {
      showDialog(
          context: context,
          builder: (_context) {
            return PaprikaSimpleDialog(
              title: S.of(context).loggingInRequired(
                  S.of(context).actionChangeRestaurantNotifications),
              yesButton: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LogInScreen(asAService: true)))
                        .then((loggedIn) {
                      if (loggedIn != null && loggedIn) {
                        _actionChangeRestaurantNotifications();
                      } else {
                        PaprikaToast.showToast(S.of(context).loggingInRequired(
                            S.of(context).actionChangeRestaurantNotifications));
                      }
                    });
                  },
                  child: Text(S.of(context).logIn)),
            );
          });
    }
  }
}
