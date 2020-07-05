import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/models/event_model.dart';
import 'package:paprica/src/models/offer_model.dart';
import 'package:paprica/src/screens/offer_screen.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../screens.dart';
import '../../utils.dart';

class OfferCard extends StatelessWidget {
  final CustomerOfferDto offer;

  OfferCard({
    @required this.offer,
  });

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
//                FadeInImage.assetNetwork(
//                  width: MediaQuery.of(context).size.width * 0.38,
//                  height: MediaQuery.of(context).size.width * 0.38,
//                  image: offer.image,
//                  fit: BoxFit.cover,
//                  placeholder: "assets/images/placeholder.png",
//                ),

                CachedNetworkImage(
                  imageUrl: offer.image,
                  placeholder: (context, url) => Image(
                    image: AssetImage("assets/images/placeholder.png"),
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.width * 0.38,
                    fit: BoxFit.cover,
                  ),
                  width: MediaQuery.of(context).size.width * 0.38,
                  height: MediaQuery.of(context).size.width * 0.38,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            offer.restaurantName,
                            style: TextStyle(
                                fontSize: 18, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            offer.description,
                          ),
                        ),
                        SizedBox(height: 4),
//                        Text(
//                          offer.description2,
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        SizedBox(height: 4),
//                        Text(
//                          offer.description3,
//                          overflow: TextOverflow.ellipsis,
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 14,
//                          ),
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Container(
//                          decoration: new BoxDecoration(
//                              border: new Border.all(
//                                  color: Colors.black, width: 0.5)),
//                          child: Padding(
//                            padding: const EdgeInsets.all(3.0),
//                            child: Text(
//                              offer.price,
//                              style: TextStyle(
//                                color: Colors.black,
//                                fontSize: 14,
//                              ),
//                            ),
//                          ),
//                        ),
//                        SizedBox(
//                          height: 4,
//                        ),
//                        Text(
//                          S.of(context).from +
//                              " " +
//                              offer.dateFrom +
//                              " " +
//                              S.of(context).to +
//                              " " +
//                              offer.dateTo,
//                          softWrap: true,
//                          style: TextStyle(
//                            color: Theme.of(context).primaryColor,
//                            fontSize: 14,
//                          ),
//                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyPapricaOfferCard extends StatelessWidget {
  final OfferPapricaItemDto offer;

  MyPapricaOfferCard({
    @required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferScreen(
                offer: OfferModel.fromMyPapricaEventDto(offer),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 55),
//                    child: FadeInImage.assetNetwork(
//                      width: MediaQuery.of(context).size.width,
//                      height: 250,
//                      image: offer.image,
//                      fit: BoxFit.cover,
//                      placeholder: "assets/images/placeholder.png",
//                    ),
                    child: CachedNetworkImage(
                      imageUrl: offer.image,
                      placeholder: (context, url) => Image(
                        image: AssetImage("assets/images/placeholder.png"),
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                              return RestaurantHome(restaurantId: offer.restaurantId);
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: CachedNetworkImageProvider(
                                  offer.restaurantLogo,
                                ),
                                backgroundColor: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            offer.restaurantName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              offer.description != null || offer.description.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                offer.description,
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor, width: 1, style: BorderStyle.solid)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Text(
                          S.of(context).offer.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1.5,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OfferCardInList extends StatelessWidget {
  final OfferPapricaItemDto offer;

  OfferCardInList({
    @required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferScreen(
                offer: OfferModel.fromMyPapricaEventDto(offer),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 55),
//                    child: FadeInImage.assetNetwork(
//                      width: MediaQuery.of(context).size.width,
//                      height: 250,
//                      image: offer.image,
//                      fit: BoxFit.cover,
//                      placeholder: "assets/images/placeholder.png",
//                    ),
                    child: CachedNetworkImage(
                      imageUrl: offer.image,
                      placeholder: (context, url) => Image(
                        image: AssetImage("assets/images/placeholder.png"),
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                              return RestaurantHome(restaurantId: offer.restaurantId);
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: CachedNetworkImageProvider(
                                  offer.restaurantLogo,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            offer.restaurantName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          offer.description,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
