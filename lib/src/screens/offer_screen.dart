import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paprika/src/models/offer_model.dart';
import 'package:paprika/translations.dart';
import 'package:paprika/widgets.dart';
import 'package:share/share.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../utils.dart';

class OfferScreen extends StatefulWidget {
  final OfferModel offer;

  final int offerId;

  const OfferScreen({this.offer, this.offerId})
      : assert(offer != null || offerId != null,
            "You must supply an offer or an offer id");

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  Future<OfferModel> _futureOffer;

  String get _offerId => (widget.offerId != null)
      ? widget.offerId.toString()
      : widget.offer?.id?.toString();

  @override
  void initState() {
    super.initState();
    _checkOfferData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offer == null && widget.offerId == null) {
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: FutureBuilder<OfferModel>(
          future: _futureOffer,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Color(0xFFF2F2F2),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 320,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Hero(
                                          tag: snapshot.data.image,
                                          child: FullscreenPhoto(
                                              provider: NetworkImage(
                                                  snapshot.data.image)),
                                          placeholderBuilder:
                                              (BuildContext context,
                                                  Size heroSize, Widget child) {
                                            return Container(
                                              height: 150.0,
                                              width: 150.0,
                                              child: Image.asset(
                                                  "assets/images/placeholder.png"),
                                            );
                                          },
                                        );
                                      });
                                },
                                child: FadeInImage.assetNetwork(
                                  image: snapshot.data.image ?? "",
                                  placeholder: "assets/images/placeholder.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: EdgeInsets.all(0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return RestaurantHome(
                                                    restaurantId: snapshot
                                                        .data.restaurantId);
                                              }));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    snapshot
                                                        .data.restaurantLogo,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 1),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data.restaurantName,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: _actionShare,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(Icons.share,
                                              color: Colors.black87),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          S.of(context).offer,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Text(
                            S.of(context).description,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        (snapshot.data.description != null &&
                                snapshot.data.description.length != 0 &&
                                snapshot.data.description != "")
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(snapshot.data.description),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  S.of(context).noExtraInfo,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                )),
                        SizedBox(height: 75),
                      ],
                    ),
                  ),
                ),
//                floatingActionButton: !(snapshot.data.isReservable ?? false)
//                    ? null
//                    : CustomizedActiveButton(
//                  onPressed: () {
//                    showDialog(
//                        context: context,
//                        builder: (BuildContext context) =>
//                            ReservationDialog(
//                              snapshot.data.restaurantId,
//                              snapshot.data.restaurantName,
//                              event: this.widget.offer,
//                            ));
//                  },
//                  title: S.of(context).reserveNow,
//                ),
//                floatingActionButtonLocation:
//                FloatingActionButtonLocation.centerFloat,
              );
            } else
              return Scaffold(body: Center(child: CircularProgressIndicator()));
          }),
    );
  }

  void _checkOfferData() {
    if (widget.offer != null) {
      setState(() {
        _futureOffer = Future.value(widget.offer);
      });
    } else {
      ApiClient client = PapricaApiClient();
      CustomerOfferApi api = CustomerOfferApi(client);
      api.apiServicesAppCustomerOfferGetGet(id: widget.offerId).then((offer) {
        setState(() {
          _futureOffer = Future.value(OfferModel.fromCustomerOfferDto(offer));
        });
      }).catchError((err) {
        Navigator.of(context).pop();
        PaprikaToast.showToast(S.of(context).messageOfferNotFound,
            ToastType.Normal, Toast.LENGTH_LONG);
      });
    }
  }

  void _actionShare() {
    Share.share(S
        .of(context)
        .shareTextOffer(widget.offer.restaurantName ?? '','', "https://links.paprika-sy.com/offer/" + _offerId));
  }
}
