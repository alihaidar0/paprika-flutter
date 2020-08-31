import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/models/reservation_model.dart';
import 'package:paprica/src/widgets/accessories.dart';
import 'package:swagger/api.dart';

import '../../translations.dart';
import '../../utils.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;
  final String title;
  final Color titleColor;
  final GestureTapCallback deleteCallback;

  ReservationCard({
    this.reservation,
    this.title,
    this.titleColor,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return reservation != null
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
                              restaurantId: reservation.restaurantId);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4, left: 2.5, right: 2.5),
                        child: CircleAvatar(
//                          backgroundImage: NetworkImage(reservation.imageUrl),
                          backgroundImage:
                              CachedNetworkImageProvider(reservation.imageUrl),
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
                                    S.of(context).reservation +
                                        " " +
                                        S.of(context).forWord +
                                        " " +
                                        reservation.numberOfPeople.toString() +
                                        " " +
                                        S.of(context).at +
                                        " " +
                                        reservation.restaurantName,
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
                                          context, reservation.date) +
                                      "    " +
                                      PapricaFormatter.formatTimeOnly(
                                          context, reservation.date),
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

class MyPapricaReservationCard extends StatelessWidget {
  final ReservationPapricaItemDto reservation;

  MyPapricaReservationCard({
    this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    var isLtr = Localizations.localeOf(context).languageCode == 'en';
    return reservation != null
        ? Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: isLtr ? 0 : 10),
                right: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: !isLtr ? 0 : 10),
              ),
              color: Colors.white,
            ),
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return RestaurantHome(
                          restaurantId: reservation.restaurantId);
                    }));
                  },
//                  child: FadeInImage.memoryNetwork(
//                    image: reservation.restaurantLogo,
//                    fit: BoxFit.cover,
//                    placeholder: kTransparentImage,
//                  ),
                  child: PapricaCachedImage(
                    imageUrl: reservation.restaurantLogo,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          reservation.status ==
                                  ApiHelper.reservationTypeApproved
                              ? S.of(context).youHaveUpcoming
                              : S.of(context).youHavePending,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          S.of(context).reservation +
                              " " +
                              S.of(context).forWord +
                              " " +
                              reservation.numberOfPeople.toString() +
                              " " +
                              S.of(context).at +
                              " " +
                              reservation.restaurantName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          PapricaFormatter.formatDateOnly(
                                  context, reservation.time) +
                              "    " +
                              PapricaFormatter.formatTimeOnly(
                                  context, reservation.time),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
