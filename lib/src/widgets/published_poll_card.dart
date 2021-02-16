import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/widgets/rating_bar.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';

class PublishedPollCard extends StatelessWidget {
  final PublishedPollInPapricaItem publishedPollItem;
  final String title;
  final Color titleColor;

  PublishedPollCard({
    @required this.publishedPollItem,
    this.titleColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var x = 0; x < publishedPollItem.items.length; x++) {
      widgets.add(
        Container(
          width: MediaQuery.of(context).size.width,
          child: _pollItem(context, publishedPollItem.items[x]),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        children: widgets,
      ),
    );
  }

  Widget _pollItem(BuildContext context, item) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: item.meal.thumbnailImage,
                  placeholder: (context, url) => Image(
                    image: AssetImage("assets/images/placeholder.png"),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  alignment: Alignment.topRight,
                  child: Image(
                    image: AssetImage("assets/icons/bookmark.png"),
                    width: MediaQuery.of(context).size.width * 0.13,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                    children: [
                      Text(item.meal.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: FlutterRatingBarIndicator(
                          rating: item.meal.mealRate,
                          itemCount: 5,
                          itemSize: 25.0,
                          itemPadding: EdgeInsets.all(2.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return RestaurantHome(restaurantId: item.restaurant.id);
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.23 * 0.5),
                      child: CachedNetworkImage(
                          imageUrl: item.restaurant.logoImage,
                          placeholder: (context, url) => Image(
                                image:
                                    AssetImage("assets/images/placeholder.png"),
                                width: MediaQuery.of(context).size.width * 0.23,
                              ),
                          width: MediaQuery.of(context).size.width * 0.23),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.restaurant.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text(
                          "${item.restaurant.votes} " +
                              S.of(context).outOf +
                              " ${item.totalVotes} " +
                              S.of(context).votes,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.resaultText,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
