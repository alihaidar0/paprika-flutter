import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/screens.dart';
import 'package:paprika/src/models/paprika_filter_model.dart';
import 'package:paprika/src/models/restaurants_list_model.dart';
import 'package:paprika/src/widgets/rating_bar.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';
import '../../widgets.dart';

class Restaurants extends StatelessWidget {
  final RestaurantsListModel restaurantsList;
  final String title;
  final Color titleColor;
  final bool reversed, isArrowShows, isFromMyPaprika;
  final PaprikaFilterModel filterModel;

  Restaurants(
      {@required this.restaurantsList,
      @required this.title,
      this.isFromMyPaprika = false,
      this.titleColor,
      this.isArrowShows = true,
      this.reversed = false,
      @required this.filterModel});

  @override
  Widget build(BuildContext context) {
    var imageWidth = MediaQuery.of(context).size.width * 0.3;

    List<Widget> widgets = [];
    for (var x = 0; x < restaurantsList.items.length; x++) {
      widgets.add(
        Container(
          width: imageWidth,
          child: isFromMyPaprika
              ? _buildMyPaprikaRestaurant(context, x, imageWidth)
              : _buildRestaurant(context, x),
        ),
      );
    }

    num parentHeight =
        isFromMyPaprika ? MediaQuery.of(context).size.height * 0.13 : 90; //103
    return Container(
      color: isFromMyPaprika ? Colors.white : Colors.transparent,
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isArrowShows
                    ? Container(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _onSeeMore(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).viewAll,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Icon(
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? Icons.keyboard_arrow_right
                                    : Icons.keyboard_arrow_left,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.23 + parentHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(5.0),
              children: widgets,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPaprikaRestaurant(BuildContext context, int x, imageHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RestaurantHome(restaurantId: restaurantsList.items[x].id);
        }));
      },
      child: Card(
        color: Colors.white70,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: imageHeight - 7,
              child: ClipRRect(
                borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                ),
//                child: FadeInImage.memoryNetwork(
//                  placeholder: kTransparentImage,
//                  image: restaurantsList.items[x].logoImage ?? "",
//                ),
                child: PaprikaCachedImage(
                  imageUrl: restaurantsList.items[x].logoImage,
                ),
              ),
            ),
            Padding(
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? EdgeInsets.fromLTRB(8, 3, 8, 0)
                    : EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  restaurantsList.items[x].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? 14
                            : 14,
                  ),
                )),
            Padding(
              padding: Localizations.localeOf(context).languageCode == 'en'
                  ? EdgeInsets.fromLTRB(6, 2, 6, 0)
                  : EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: FlutterRatingBarIndicator(
                rating: restaurantsList.items[x].restaurantRate,
                itemCount: 5,
                itemSize: 8.0,
                itemPadding: EdgeInsets.all(2.1),
              ),
            ),
            Padding(
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? EdgeInsets.fromLTRB(8, 3, 8, 3)
                    : EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  restaurantsList.items[x].isOpen
                      ? S.of(context).opened
                      : S.of(context).closed,
                  style: TextStyle(
                    fontSize:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? 10
                            : 10,
                    color: restaurantsList.items[x].isOpen
                        ? Colors.green
                        : Colors.red,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurant(BuildContext context, int x) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RestaurantHome(restaurantId: restaurantsList.items[x].id);
        }));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                          imageUrl: restaurantsList.items[x].logoImage,
                          placeholder: (context, url) => Image(
                                image:
                                    AssetImage("assets/images/placeholder.png"),
                                width: MediaQuery.of(context).size.width * 0.23,
                              ),
                          width: MediaQuery.of(context).size.width * 0.23),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 3, 10, 0),
                    child: Text(
                      restaurantsList.items[x].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: FlutterRatingBarIndicator(
                    rating: restaurantsList.items[x].restaurantRate,
                    itemCount: 5,
                    itemSize: 8.0,
                    itemPadding: EdgeInsets.all(2.1),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 3, 10, 3),
                    child: Text(
                      restaurantsList.items[x].isOpen
                          ? S.of(context).opened
                          : S.of(context).closed,
                      style: TextStyle(
                        fontSize: 10,
                        color: restaurantsList.items[x].isOpen
                            ? Colors.green
                            : Colors.red,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSeeMore(BuildContext mContext) {
    ApiTypesHelper helper = ApiTypesHelper();
    ApiClient client = PapricaApiClient();
    PlacesApi api = PlacesApi(client);
    ProgressDialog dialog = ProgressDialog(mContext);
    dialog.setMessage(S.of(mContext).loadingRestaurants);
    dialog.show();
    api
        .apiServicesAppPlacesGetAllGet(
      isFeatured: filterModel.isFeatured,
      longitude: filterModel.longitude,
      latitude: filterModel.latitude,
      restaurantTypes:
          helper.calculateTypeValue(filterModel.placesSelections, Type.places),
      cuisineTypes: helper.calculateTypeValue(
          filterModel.cuisinesSelections, Type.cuisines),
      ambianceType: helper.calculateTypeValue(
          filterModel.ambianceSelections, Type.ambiance),
      amenityTypes: helper.calculateTypeValue(
          filterModel.amenitiesSelections, Type.amenities),
      musicType: helper.calculateTypeValue(
          filterModel.musicTypesSelections, Type.music),
      parkingType: helper.calculateTypeValue(
          filterModel.parkingTypesSelections, Type.parking),
      hasOutdoor: filterModel.outdoor,
      isSmokeFree: filterModel.smokeFree,
      isAlcoholFree: filterModel.alcoholFree,
      is24Hour: filterModel.twentyFourHour,
    )
        .then((restaurantsDto) {
      dialog.hide();
      Navigator.of(mContext).push(MaterialPageRoute(builder: (context) {
        return RestaurantsListScreen(
          restaurants: restaurantsDto?.items,
          title: this.title != null && this.title.isNotEmpty
              ? this.title
              : S.of(context).discover,
          filterModel: filterModel,
        );
      }));
    }).catchError((err) {
      DefaultErrorHandler.handle(mContext, err);
    });
  }

  /// not used
// Widget _buildViewMoreCard(BuildContext context) {
//   return GestureDetector(
//     onTap: () {
//       _onSeeMore(context);
//     },
//     child: Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.5),
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//             ),
//           ),
//           Center(
//             child: Text(
//               S.of(context).seeMore,
//               textAlign: TextAlign.center,
//               softWrap: true,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 19,
//                 color: Colors.white,
//                 shadows: <Shadow>[
//                   Shadow(
//                     offset: Offset(2, 2),
//                     blurRadius: 8.0,
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}

class PlacesRestaurantsList extends StatelessWidget {
  final List<PlacesListItem> restaurantsList;
  final String title;
  final Color titleColor;
  final bool reversed, isArrowShows, isFromMyPaprika;
  final PaprikaFilterModel filterModel;

  PlacesRestaurantsList(
      {@required this.restaurantsList,
      @required this.title,
      this.isFromMyPaprika = false,
      this.titleColor,
      this.isArrowShows = true,
      this.reversed = false,
      @required this.filterModel});

  @override
  Widget build(BuildContext context) {
    var imageWidth = MediaQuery.of(context).size.width * 0.3;

    List<Widget> widgets = [];
    for (var x = 0; x < restaurantsList.length; x++) {
      widgets.add(
        Container(
          width: imageWidth,
          child: isFromMyPaprika
              ? _buildMyPaprikaRestaurant(context, x, imageWidth)
              : _buildRestaurant(context, x),
        ),
      );
    }

    num parentHeight =
        isFromMyPaprika ? MediaQuery.of(context).size.height * 0.13 : 90; //103
    return Container(
      color: isFromMyPaprika ? Colors.white : Colors.transparent,
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isArrowShows
                    ? Container(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _onSeeMore(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).viewAll,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Icon(
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? Icons.keyboard_arrow_right
                                    : Icons.keyboard_arrow_left,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.23 + parentHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(5.0),
              children: widgets,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPaprikaRestaurant(BuildContext context, int x, imageHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RestaurantHome(restaurantId: restaurantsList[x].id);
        }));
      },
      child: Card(
        color: Colors.white70,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: imageHeight - 7,
              child: ClipRRect(
                borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                ),
                child: PaprikaCachedImage(
                  imageUrl: restaurantsList[x].logoImage,
                ),
              ),
            ),
            Padding(
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? EdgeInsets.fromLTRB(8, 3, 8, 0)
                    : EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  restaurantsList[x].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? 14
                            : 14,
                  ),
                )),
            Padding(
              padding: Localizations.localeOf(context).languageCode == 'en'
                  ? EdgeInsets.fromLTRB(6, 2, 6, 0)
                  : EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: FlutterRatingBarIndicator(
                rating: restaurantsList[x].restaurantRate,
                itemCount: 5,
                itemSize: 8.0,
                itemPadding: EdgeInsets.all(2.1),
              ),
            ),
            Padding(
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? EdgeInsets.fromLTRB(8, 3, 8, 3)
                    : EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  restaurantsList[x].isOpen
                      ? S.of(context).opened
                      : S.of(context).closed,
                  style: TextStyle(
                    fontSize:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? 10
                            : 10,
                    color:
                        restaurantsList[x].isOpen ? Colors.green : Colors.red,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurant(BuildContext context, int x) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RestaurantHome(restaurantId: restaurantsList[x].id);
        }));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                          imageUrl: restaurantsList[x].logoImage,
                          placeholder: (context, url) => Image(
                                image:
                                    AssetImage("assets/images/placeholder.png"),
                                width: MediaQuery.of(context).size.width * 0.23,
                              ),
                          width: MediaQuery.of(context).size.width * 0.23),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 3, 10, 0),
                    child: Text(
                      restaurantsList[x].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: FlutterRatingBarIndicator(
                    rating: restaurantsList[x].restaurantRate,
                    itemCount: 5,
                    itemSize: 8.0,
                    itemPadding: EdgeInsets.all(2.1),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 3, 10, 3),
                    child: Text(
                      restaurantsList[x].isOpen
                          ? S.of(context).opened
                          : S.of(context).closed,
                      style: TextStyle(
                        fontSize: 10,
                        color: restaurantsList[x].isOpen
                            ? Colors.green
                            : Colors.red,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSeeMore(BuildContext mContext) {
    ApiTypesHelper helper = ApiTypesHelper();
    ApiClient client = PapricaApiClient();
    PlacesApi api = PlacesApi(client);
    ProgressDialog dialog = ProgressDialog(mContext);
    dialog.setMessage(S.of(mContext).loadingRestaurants);
    dialog.show();
    api
        .apiServicesAppPlacesGetAllGet(
      isFeatured: filterModel.isFeatured,
      longitude: filterModel.longitude,
      latitude: filterModel.latitude,
      restaurantTypes:
          helper.calculateTypeValue(filterModel.placesSelections, Type.places),
      cuisineTypes: helper.calculateTypeValue(
          filterModel.cuisinesSelections, Type.cuisines),
      ambianceType: helper.calculateTypeValue(
          filterModel.ambianceSelections, Type.ambiance),
      amenityTypes: helper.calculateTypeValue(
          filterModel.amenitiesSelections, Type.amenities),
      musicType: helper.calculateTypeValue(
          filterModel.musicTypesSelections, Type.music),
      parkingType: helper.calculateTypeValue(
          filterModel.parkingTypesSelections, Type.parking),
      hasOutdoor: filterModel.outdoor,
      isSmokeFree: filterModel.smokeFree,
      isAlcoholFree: filterModel.alcoholFree,
      is24Hour: filterModel.twentyFourHour,
    )
        .then((restaurantsDto) {
      dialog.hide();
      Navigator.of(mContext).push(MaterialPageRoute(builder: (context) {
        return RestaurantsListScreen(
          restaurants: restaurantsDto?.items,
          title: this.title != null && this.title.isNotEmpty
              ? this.title
              : S.of(context).discover,
          filterModel: filterModel,
        );
      }));
    }).catchError((err) {
      DefaultErrorHandler.handle(mContext, err);
    });
  }

  /// not used
// Widget _buildViewMoreCard(BuildContext context) {
//   return GestureDetector(
//     onTap: () {
//       _onSeeMore(context);
//     },
//     child: Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.5),
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//             ),
//           ),
//           Center(
//             child: Text(
//               S.of(context).seeMore,
//               textAlign: TextAlign.center,
//               softWrap: true,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 19,
//                 color: Colors.white,
//                 shadows: <Shadow>[
//                   Shadow(
//                     offset: Offset(2, 2),
//                     blurRadius: 8.0,
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
