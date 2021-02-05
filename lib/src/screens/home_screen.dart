import 'dart:async';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paprica/pages.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/models/meal_share.dart';
import 'package:paprica/src/models/search_item.dart';
import 'package:paprica/src/pages/my_paprica_page.dart';
import 'package:paprica/translations.dart';
import 'package:swagger/api.dart';
import 'package:uni_links/uni_links.dart';
import '../../utils.dart';
import '../../widgets.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenAction action;
  final int initialIndex;

  const HomeScreen({Key key, this.initialIndex, this.action}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  BuildContext buildContext;
  int _currentIndex = 0;
  bool _actionHandled = false;

  List<Widget> _tabList = [];

  TabController _tabController;
  ScrollController _scrollController = ScrollController();

  StreamController<bool> _refreshStream;

  Animation<Offset> offset;

  StreamController<bool> resetScrollPositionStream;
  int _notificationCounts;

  bool _firebaseInitiatedWithContext = false;

  DateTime _backButtonLastPress;

  @override
  void initState() {
    super.initState();
    initUniLinks();
    _checkNotificationsCount();
    _refreshStream = StreamController<bool>.broadcast();
    resetScrollPositionStream = StreamController<bool>.broadcast();
    _tabList
      ..add(MyPapricaPage(
        resetScrollPositionStream: resetScrollPositionStream.stream,
        parentScrollNotifier: _handleChildScroll,
      ))
      ..add(PlacesPage())
      ..add(ServicePage(changeHomePageIndexHandler))
      ..add(MorePage());

    _tabController = TabController(vsync: this, length: _tabList.length);
    if (widget.initialIndex != null) _currentIndex = widget.initialIndex;
  }

  _handleChildScroll(ScrollDirection direction, double offset) {
    if (direction == ScrollDirection.reverse &&
        _scrollController.offset != 55) {
      _scrollController.animateTo(55,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 500));
    } else if (direction == ScrollDirection.forward &&
        _scrollController.offset != 0)
      _scrollController.animateTo(0,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _refreshStream.close();
    resetScrollPositionStream.close();

    _subUri.cancel();
    super.dispose();
  }

  Future<bool> _onWillPop() {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      _changeTab(_currentIndex);
      return Future.value(false);
    } else {
      DateTime currentTime = DateTime.now();
      bool backButton = _backButtonLastPress == null ||
          currentTime.difference(_backButtonLastPress) > Duration(seconds: 3);
      if (backButton) {
        _backButtonLastPress = currentTime;
        resetScrollPositionStream.add(true);
        _scrollController.animateTo(0,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 500));
        return Future.value(false);
      }
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');

      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Navigate to pages on demand
    // TODO: this should be refactored to handle all actions
    if (widget.action != null &&
        !_actionHandled &&
        widget.action == HomeScreenAction.reservations) {
      setState(() {
        _goToReservationsPage();
        _actionHandled = true;
      });
    }

    buildContext = context;
    if (!_firebaseInitiatedWithContext) {
      Firebase().init(context, onMessageCallback: _onMessageCallback);
      _firebaseInitiatedWithContext = true;
    }
    Firebase().addReservationCallback(_reservationOpenCallback);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehaviour(),
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 40,
                  title: Text(S.of(context).title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  backgroundColor: Theme.of(context).primaryColor,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                            context: context, delegate: CustomSearchDelegate());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_alt),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DiscoverPage();
                        }));
                      },
                    ),
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              setState(() {
                                _notificationCounts = 0;
                              });
                              Navigator.push<HomeScreenAction>(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationsScreen()),
                              ).then((HomeScreenAction screenAction) {
                                _handlerActionRequest(screenAction);
                              });
                            },
                          ),
                        ),
                        _notificationCounts != null &&
                                _notificationCounts > 0 &&
                                _notificationCounts < 999
                            ? Positioned(
                                right: 4,
                                left: 4,
                                child: Padding(
                                  padding: Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? const EdgeInsets.only(
                                          top: 10, left: 8.0)
                                      : const EdgeInsets.only(
                                          top: 10, right: 8.0),
                                  child: Container(
                                    height: _notificationCounts < 99 ? 16 : 20,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Text(
                                          _notificationCounts > 9
                                              ? S.of(context).ninePlus
                                              : '$_notificationCounts',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.deepOrangeAccent),
                                  ),
                                ),
                              )
                            : EmptyWidget(),
                      ],
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, _) => Container(
                            height: MediaQuery.of(context).size.height - 70,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, 0, 0, _currentIndex == 0 ? 0 : 60),
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: _tabList,
                              ),
                            ),
                          ),
                      childCount: 1),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 50.0,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (currentIndex) {
              if (currentIndex != _currentIndex) {
                setState(() {
                  _currentIndex = currentIndex;
                });
                _changeTab(currentIndex);
              } else {
                if (currentIndex == 0) {
                  resetScrollPositionStream.add(true);
                  _scrollController.animateTo(0,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(milliseconds: 500));
                }
              }
            },
            selectedFontSize: 12.0,
            showUnselectedLabels: true,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Color(0xFF727272),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/home_inactive.png"),
                ),
                activeIcon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/home_active.png"),
                ),
                title: Text(
                  S.of(context).home,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/restaurants_inactive.png"),
                ),
                activeIcon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/restaurants_active.png"),
                ),
                title: Text(
                  S.of(context).restaurants,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/activities_inactive.png"),
                ),
                activeIcon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/activities_active.png"),
                ),
                title: Text(
                  S.of(context).activities,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/more_inactive.png"),
                ),
                activeIcon: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/icons/more_active.png"),
                ),
                title: Text(
                  S.of(context).more,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkNotificationsCount() {
    if (ApiTypesHelper().notificationsCount != null &&
        ApiTypesHelper().notificationsCount > 0)
      setState(() {
        _notificationCounts = ApiTypesHelper().notificationsCount;
      });
  }

  void _handlerActionRequest(HomeScreenAction screenAction) {
    switch (screenAction) {
      case HomeScreenAction.reservations:
        _goToReservationsPage();
        break;
    }
  }

  void _goToReservationsPage() {
    setState(() {
      _currentIndex = 1;
    });
    _changeTab(1);
  }

  changeHomePageIndexHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
    _changeTab(index);
  }

  _reservationOpenCallback() {
    Navigator.popUntil(context, ModalRoute.withName('/home'));
    _goToReservationsPage();
  }

  // ignore: unused_field
  StreamSubscription _subUri;

  Future<Null> initUniLinks() async {
    _subUri = getUriLinksStream().listen((Uri uri) {
      Future.delayed(Duration(milliseconds: 500), () {
        processUri(uri);
      });
    }, onError: (err) {});
    try {
      Uri initialUri = await getInitialUri();
      Future.delayed(Duration(milliseconds: 500), () {
        processUri(initialUri);
      });
    } on FormatException {}
  }

  void processUri(Uri uri) {
    if (uri == null) return;

    List<String> splits = uri.toString().split('/');
    if (splits == null || splits.isEmpty) return;

    if (splits.length <= 2) return;

    String domain = splits[splits.length - 2];
    int id;
    try {
      id = int.parse(splits[splits.length - 1]);
    } catch (e) {
      return;
    }

    if (id == null || id <= 0) return;

    //Restaurant
    if (domain == "restaurant") {
      openRestaurantScreen(id);
      return;
    }
    //Event
    if (domain == "event") {
      openEventcreen(id);
      return;
    }
    //Offer
    if (domain == "offer") {
      openOfferScreen(id);
      return;
    }

    // if non of the previous cases applied, try the meal
    if (splits.length >= 4) {
      String domain = splits[splits.length - 4];
      if (domain == null) return;
      try {
        int restaurantId = int.parse(splits[splits.length - 3]);
        int categoryId = int.parse(splits[splits.length - 2]);
        int mealId = int.parse(splits[splits.length - 1]);

        if (restaurantId == null ||
            categoryId == null ||
            mealId == null ||
            restaurantId <= 0 ||
            categoryId <= 0 ||
            mealId <= 0) return;
        openRestaurantScreenForMeal(restaurantId, categoryId, mealId);
      } catch (e) {
        return;
      }
    }
  }

  void openRestaurantScreen(int restaurantId) {
    if (buildContext == null) return;
    Navigator.pushNamed(buildContext, '/restaurant', arguments: restaurantId);
  }

  void openEventcreen(int eventId) {
    if (buildContext == null) return;
    Navigator.pushNamed(buildContext, '/event', arguments: eventId);
  }

  void openOfferScreen(int offerId) {
    if (buildContext == null) return;
    Navigator.pushNamed(buildContext, '/offer', arguments: offerId);
  }

  void openRestaurantScreenForMeal(
      int restaurantId, int categoryId, int mealId) {
    if (buildContext == null) return;
    Navigator.pushNamed(buildContext, '/meal',
        arguments: MealShare(restaurantId, categoryId, mealId));
  }

  _onMessageCallback() {
    _notificationCounts ??= 0;
    setState(() {
      _notificationCounts = _notificationCounts + 1;
    });
  }

  _changeTab(int newIndex) {
    _scrollController.animateTo(0,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 500));
    _tabController.animateTo(newIndex, curve: Curves.fastOutSlowIn);
  }
}

enum HomeScreenAction { reservations }

class CustomSearchDelegate extends SearchDelegate<SearchItem> {
  ApiClient client;
  CustomerSearchApi api;

  CustomSearchDelegate() {
    client = PapricaApiClient();
    api = CustomerSearchApi(client);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: S.of(context).clearAll,
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
//      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == null || query.isEmpty) return Container();
    return FutureBuilder<SearchResultDto>(
      future: api.apiServicesAppCustomerSearchQueryGet(keyword: query),
      builder: (BuildContext context, AsyncSnapshot<SearchResultDto> snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Color(0xfff2f2f2),
            child: ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return RestaurantHome(
                        restaurantId:
                            snapshot.data.restaurants[index].relatedItemId);
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(4.0),
                      leading: SizedBox(
                          height: 56,
                          width: 56,
                          child: Image.network(
                              snapshot.data.restaurants[index].relatedImage)),
                      title: Text(
                        snapshot.data.restaurants[index].text,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: snapshot.data.restaurants.length,
            ),
          );
        }
        return Center(
            child: SizedBox(
                height: 24, width: 24, child: CircularProgressIndicator()));
      },
    );
  }
}
