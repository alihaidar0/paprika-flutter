import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/models/offer_model.dart';
import 'package:paprika/src/screens/offer_screen.dart';
import 'package:paprika/src/screens/offers_list_screen.dart';
import 'package:swagger/api.dart';

class OffersListInMyPaprika extends StatelessWidget {
  final PagedResultDtoMyPapricaOfferDto offersList;
  final String title;
  final Color titleColor;
  final bool reversed, isArrowShows, isFromMyPaprika;

//  final PaprikaFilterModel filterModel;

  OffersListInMyPaprika({
    @required this.offersList,
    @required this.title,
    this.isFromMyPaprika = false,
    this.titleColor,
    this.isArrowShows = true,
    this.reversed = false,
  });

/* @required this.filterModel*/
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var x = 0; x < offersList.items.length; x++) {
      widgets.add(
        Container(
          height: MediaQuery.of(context).size.width * 0.70,
          child:
              isFromMyPaprika ? _buildMyPaprikaOffers(context, x) : Container(),
        ),
      );
    }

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
            height: MediaQuery.of(context).size.width * 0.53 + 90,
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

  Widget _buildMyPaprikaOffers(BuildContext context, int x) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return OfferScreen(
              offer: OfferModel.fromMyPaprikaEventDto(offersList.items[x]));
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
            ClipRRect(
              borderRadius: new BorderRadius.only(
                topRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.30,
                child: CachedNetworkImage(
                  imageUrl: offersList.items[x].image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image(
                    image: AssetImage("assets/images/placeholder.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 5, 8, 1),
                child: Text(
                  offersList.items[x].restaurantName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  offersList.items[x].description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _onSeeMore(BuildContext mContext) {
    Navigator.of(mContext)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return OffersListScreen();
    }));
  }
}
