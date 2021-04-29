import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/models/paprika_filter_model.dart';
import 'package:paprika/src/models/restaurants_list_model.dart';
import 'package:paprika/src/models/search_item.dart';
import 'package:paprika/src/widgets/event_card.dart';
import 'package:paprika/src/widgets/offer_card.dart';
import 'package:paprika/src/widgets/offers_list_view.dart';
import 'package:paprika/src/widgets/open_poll_card.dart';
import 'package:paprika/src/widgets/published_poll_card.dart';
import 'package:paprika/src/widgets/reservation_card.dart';
import 'package:paprika/src/widgets/restaurant_list_view.dart';
import 'package:paprika/widgets.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../utils.dart';

class MyPaprikaPage extends StatefulWidget {
  final Stream<bool> resetScrollPositionStream;
  final parentScrollNotifier;

  MyPaprikaPage({this.resetScrollPositionStream, this.parentScrollNotifier});

  @override
  _MyPaprikaPageState createState() => _MyPaprikaPageState();
}

class _MyPaprikaPageState extends State<MyPaprikaPage>
    with AutomaticKeepAliveClientMixin<MyPaprikaPage> {
  Future<FeaturedAndNearbyRestaurantDto> placesFutureRestData;
  PagedResultDtoRestaurantLiteDto restaurantsList;
  int _notificationCounts;

  Future<PapricaItemsDto> futureRestData;
  Future<PapricaItemsDto> futureLoadMoreData;
  List<dynamic> paprikaItemsList;

  bool noMorePaprikaItems = false;
  int lastOffersStamp = 0,
      lastEventsStamp = 0,
      lastReservationStamp = 0,
      lastRestaurantsListStamp = 0,
      lastOffersListStamp = 0;

  ScrollController _scrollController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future onRefresh() {
    futureRestData = null;
    futureLoadMoreData = null;
    restaurantsList = null;
    _notificationCounts = null;
    paprikaItemsList.clear();
    lastOffersStamp = null;
    lastEventsStamp = null;
    lastRestaurantsListStamp = null;
    lastOffersListStamp = null;
    lastReservationStamp = null;
    noMorePaprikaItems = false;
    return _initialLoad();
  }

  @override
  void initState() {
    futureRestData = null;
    futureLoadMoreData = null;
    restaurantsList = null;
    _notificationCounts = null;
    lastOffersStamp = null;
    lastEventsStamp = null;
    lastRestaurantsListStamp = null;
    lastOffersListStamp = null;
    lastReservationStamp = null;
    noMorePaprikaItems = false;

    super.initState();
    _initialLoad();
    _checkNotificationsCount();
    widget.resetScrollPositionStream?.listen((reset) {
      if (reset != null && reset) {
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 2000),
            curve: Curves.fastOutSlowIn);
      }
    });
    paprikaItemsList = [];
    _scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    _notifyParent(_scrollController.position.userScrollDirection,
        _scrollController.offset);
  }

  Future _initialLoad() {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = CustomerPapricaItemApi(apiClient);

    futureRestData = apiInstance.apiServicesAppCustomerPapricaItemLoadItemsPost(
      input: PapricaItemQueryDto.init(),
    );
    setState(() {
      futureRestData.then((onValue) {
        _updateStamps(onValue.papricaItems);
        paprikaItemsList.addAll(onValue.papricaItems);
      });
    });

    return futureRestData.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  Future _loadMoreData(
      {int offerStamp,
      int eventStamp,
      int restaurantListStamp,
      int reservationsStamp,
      int listOffersStamp}) async {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = CustomerPapricaItemApi(apiClient);
    PapricaItemQueryDto jsonInput = PapricaItemQueryDto();

    PapricaItemStampDto jsonOffer = PapricaItemStampDto();
    if (offerStamp != null) {
      jsonOffer.stamp = offerStamp;
      jsonOffer.type = ApiHelper.MyPaprikaTypeOffer;
      jsonInput.stamps.add(jsonOffer);
    }

    PapricaItemStampDto jsonEvent = PapricaItemStampDto();
    if (eventStamp != null) {
      jsonEvent.stamp = eventStamp;
      jsonEvent.type = ApiHelper.MyPaprikaTypeEvent;
      jsonInput.stamps.add(jsonEvent);
    }

    if (reservationsStamp != null) {
      PapricaItemStampDto jsonReservations = PapricaItemStampDto();
      jsonReservations.stamp = reservationsStamp;
      jsonReservations.type = ApiHelper.MyPaprikaTypeReservation;
      jsonInput.stamps.add(jsonReservations);
    }

    if (restaurantListStamp != null) {
      PapricaItemStampDto jsonRestaurantsList = PapricaItemStampDto();
      jsonRestaurantsList.stamp = restaurantListStamp;
      jsonRestaurantsList.type = ApiHelper.MyPaprikaTypeRestaurants;
      jsonInput.stamps.add(jsonRestaurantsList);
    }

    if (listOffersStamp != null) {
      PapricaItemStampDto jsonOffersList = PapricaItemStampDto();
      jsonOffersList.stamp = listOffersStamp;
      jsonOffersList.type = ApiHelper.MyPaprikaTypeListOffers;
      jsonInput.stamps.add(jsonOffersList);
    }
    futureLoadMoreData =
        apiInstance.apiServicesAppCustomerPapricaItemLoadItemsPost(
      input: jsonInput,
    );

    return futureLoadMoreData.then((onValue) {
      _updateStamps(onValue.papricaItems);
      if (onValue.papricaItems == null || onValue.papricaItems.length == 0) {
        setState(() {
          noMorePaprikaItems = true;
        });
      }
      if (!noMorePaprikaItems) {
        paprikaItemsList.addAll(onValue.papricaItems);
      }
      return Future.value();
    }).catchError((err) {
      if (paprikaItemsList != null &&
          paprikaItemsList.length > 0 &&
          paprikaItemsList.last is SpinKitCircle) paprikaItemsList.removeLast();
      return Future.value();
    });
  }

  void _checkNotificationsCount() {
    if (ApiTypesHelper().notificationsCount != null &&
        ApiTypesHelper().notificationsCount > 0)
      setState(() {
        _notificationCounts = ApiTypesHelper().notificationsCount;
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: FutureBuilder(
        future: futureRestData,
        builder: (context, snapshot) {
          {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.connectionState == ConnectionState.done ||
                snapshot.hasData) {
              if (snapshot.data != null)
                return Container(
                  color: Color(0xFFE5E5E5),
                  height: MediaQuery.of(context).size.height - 60,
                  child: RefreshIndicator(
                    onRefresh: onRefresh,
                    key: _refreshIndicatorKey,
                    child: OnlineStatus(
                      child: IncrementallyLoadingListView(
                          controller: _scrollController,
                          hasMore: () => !noMorePaprikaItems,
                          itemCount: () => paprikaItemsList.length + 1,
                          loadMore: () async {
                            await _loadMoreData(
                                eventStamp: lastEventsStamp,
                                listOffersStamp: lastOffersListStamp,
                                offerStamp: lastOffersStamp,
                                reservationsStamp: lastReservationStamp,
                                restaurantListStamp: lastRestaurantsListStamp);
                          },
                          loadMoreOffsetFromBottom: 2,
                          itemBuilder: (context, index) {
                            if (index < paprikaItemsList.length)
                              return _buildMyPaprikaItem(
                                  context, paprikaItemsList[index]);
                            else if (noMorePaprikaItems &&
                                index == paprikaItemsList.length)
                              return _buildYouAreAllCaughtUp();
                            else
                              return EmptyWidget();
                          }),
                    ),
                  ),
                );
              else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/application_crash.png'),
                      height: 280,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RequestRetry(
                        message: S.of(context).errorUnknown,
                        retryCallback: () {
                          setState(() {
                            paprikaItemsList = [];
                          });
                          return _initialLoad();
                        }),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                );
              }
            }
            if (snapshot.hasError) {
              return RequestRetry(
                  message: S.of(context).errorUnknown,
                  retryCallback: () {
                    setState(() {
                      paprikaItemsList = [];
                    });
                    return _initialLoad();
                  });
            }
            return EmptyWidget();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _updateStamps(List<PapricaItemDto> loadedItems) {
    loadedItems.forEach((item) {
      switch (item.type) {
        case ApiHelper.MyPaprikaTypeRestaurants:
          lastRestaurantsListStamp = item.stamp;
          break;
        case ApiHelper.MyPaprikaTypeListOffers:
          lastOffersListStamp = item.stamp;
          break;
        case ApiHelper.MyPaprikaTypeReservation:
          lastReservationStamp = item.stamp;
          break;
        case ApiHelper.MyPaprikaTypeEvent:
          lastEventsStamp = item.stamp;
          break;
        case ApiHelper.MyPaprikaTypeOffer:
          lastOffersStamp = item.stamp;
          break;
        default:
          break;
      }
    });
  }

  Widget _buildMyPaprikaItem(BuildContext context, PapricaItemDto papricaItem) {
    switch (papricaItem.type) {
      case ApiHelper.MyPaprikaTypeRestaurants:
        ListPapricaItemDto temp = papricaItem.model;
        return Column(
          children: <Widget>[
            Restaurants(
              isFromMyPaprika: false,
              restaurantsList:
                  RestaurantsListModel.fromMyPaprikaModel(papricaItem.model),
              title: temp.title,
              titleColor: Theme.of(context).primaryColor,
              filterModel: PaprikaFilterModel.apiToFilterModelAdapter(
                  temp.filter, context),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        );
        break;

      case ApiHelper.MyPaprikaTypeListOffers:
        PagedResultDtoMyPapricaOfferDto temp = papricaItem.model;
        return Column(
          children: <Widget>[
            OffersListInMyPaprika(
              titleColor: Theme.of(context).primaryColor,
              isArrowShows: true,
              isFromMyPaprika: true,
              title: temp.title,
              offersList: papricaItem.model,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
        break;

      case ApiHelper.MyPaprikaTypeReservation:
        return Column(
          children: <Widget>[
            MyPaprikaReservationCard(
              reservation: papricaItem.model,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
        break;

      case ApiHelper.MyPaprikaTypeEvent:
        return Column(
          children: <Widget>[
            MyPaprikaEventCard(
              event: papricaItem.model,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
        break;

      case ApiHelper.MyPaprikaTypeOffer:
        return Column(
          children: <Widget>[
            MyPaprikaOfferCard(
              offer: papricaItem.model,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
        break;

      case ApiHelper.MyPaprikaTypePublishedPoll:
        PublishedPollInPapricaItem temp = papricaItem.model;
        return Column(
          children: <Widget>[
            PublishedPollCard(
              publishedPollItem: papricaItem.model,
              title: temp.title,
              titleColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
        break;

      case ApiHelper.MyPaprikaTypeOpenPoll:
        OpenPollInPapricaItem temp = papricaItem.model;
        return Column(
          children: <Widget>[
            OpenPollCard(
              openPollItems: papricaItem.model,
              title: temp.title,
              titleColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
        break;

      default:
        return Container();
    }
  }

  void _notifyParent(ScrollDirection direction, double offset) {
    if (widget.parentScrollNotifier is Function(ScrollDirection, double) &&
        widget.parentScrollNotifier != null) {
      widget.parentScrollNotifier(direction, offset);
    }
  }

  Widget _buildYouAreAllCaughtUp() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: <Widget>[
          HorizontalLineWithWidget(
            child: Icon(Icons.check_circle_outline,
                size: 40, color: Theme.of(context).primaryColor),
          ),
          Text(S.of(context).youAreAllCaughtUp,
              style: TextStyle(fontSize: 22, color: Colors.black54))
        ],
      ),
    );
  }
}

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
