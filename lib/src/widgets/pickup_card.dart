import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/models/pickup_model.dart';
import 'package:paprica/src/widgets/accessories.dart';
import 'package:swagger/api.dart';

import '../../translations.dart';
import '../../utils.dart';

class PickupCard extends StatelessWidget {
  final PickupModel pickup;
  final String title;
  final Color titleColor;
  final GestureTapCallback deleteCallback;

  PickupCard({
    this.pickup,
    this.title,
    this.titleColor,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return pickup != null
        ? Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title != null
              ? Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 34),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.black,
              ),
            ),
          )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return RestaurantHome(
                            restaurantId: pickup.restaurantId);
                      }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 4, left: 2.5, right: 2.5),
                  child: CircleAvatar(
                    backgroundImage:
                    CachedNetworkImageProvider(pickup.imageUrl),
                    radius: MediaQuery.of(context).size.width * 0.09,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.18,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          child: SizedBox(
                            width:
                            MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              S.of(context).pickup +
                                  " " +
                                  S.of(context).at +
                                  " " +
                                  pickup.restaurantName,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            PapricaFormatter.formatDateOnly(
                                context, pickup.date) +
                                "    " +
                                PapricaFormatter.formatTimeOnly(
                                    context, pickup.date),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )
        : Container();
  }
}