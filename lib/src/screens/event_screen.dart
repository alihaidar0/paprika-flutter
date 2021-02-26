import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paprika/src/models/event_model.dart';
import 'package:paprika/translations.dart';
import 'package:paprika/widgets.dart';
import 'package:share/share.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../utils.dart';

class EventScreen extends StatefulWidget {
  final EventModel event;

  final int eventId;

  const EventScreen({this.event, this.eventId})
      : assert(event != null || eventId != null,
            "You must supply an event or an event id");

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Future<EventModel> _futureEvent;
  String eventName;

  String get _eventId => widget.eventId != null
      ? widget.eventId.toString()
      : widget.event?.id?.toString();

  @override
  void initState() {
    super.initState();
    _checkEventData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.event == null && widget.eventId == null) {
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: FutureBuilder<EventModel>(
          future: _futureEvent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              eventName = snapshot.data.restaurantName;
              return Scaffold(
                backgroundColor: Color(0xFFF2F2F2),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 320,
                        backgroundColor: Colors.white,
                        actions: <Widget>[],
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return FullscreenPhoto(
                                            provider:
                                                CachedNetworkImageProvider(
                                                    snapshot.data.imageUrl));
                                      });
                                },
//                                child: FadeInImage.assetNetwork(
//                                  image: snapshot.data.imageUrl ?? "",
//                                  placeholder: "assets/images/placeholder.png",
//                                  fit: BoxFit.cover,
//                                ),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data.imageUrl,
                                  placeholder: (context, url) => Image(
                                    image: AssetImage(
                                        "assets/images/placeholder.png"),
                                    fit: BoxFit.cover,
                                  ),
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
                                  Flexible(
                                    child: Column(
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
                                                      snapshot.data
                                                              .restaurantLogo ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4,
                                                        vertical: 1),
                                                    child: Text(
                                                      snapshot.data.eventName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 6,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: 18,
                                                          height: 1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4,
                                                        vertical: 1),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          S.of(context).at,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          snapshot.data
                                                              .restaurantName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                PaprikaFormatter.formatDateOnly(
                                                    context,
                                                    snapshot.data.date),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                PaprikaFormatter.formatTimeOnly(
                                                    context,
                                                    snapshot.data.date),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          alignment: DateTime.now()
                                                  .isAfter(snapshot.data.date)
                                              ? Localizations.localeOf(context)
                                                          .languageCode ==
                                                      'en'
                                                  ? new FractionalOffset(
                                                      1.5, 0.0)
                                                  : new FractionalOffset(
                                                      -0.5, 0.0)
                                              : null,
                                          width: 50,
                                          child: GestureDetector(
                                            onTap: _actionShare,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(Icons.share,
                                                  color: Colors.black87),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              (DateTime.now().isAfter(
                                                      snapshot.data.date)
                                                  ? S.of(context).oldEvent
                                                  : S.of(context).event),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: (DateTime.now().isAfter(
                                                        snapshot.data.date)
                                                    ? Colors.grey
                                                    : Theme.of(context)
                                                        .primaryColor),
                                                fontWeight: FontWeight.bold,
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
                floatingActionButton: !(snapshot.data.isReservable ?? false)
                    ? null
                    : CustomizedActiveButton(
                        onPressed: () {
                          _onReserveEventPressed(snapshot);
                        },
                        title: S.of(context).reserveNow,
                      ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            } else if (snapshot.hasError) {
              Navigator.of(context).pop();
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }),
    );
  }

  void _onReserveEventPressed(AsyncSnapshot<EventModel> snapshot) {
    if (ApiTypesHelper().isAuthorized) {
      _showReservationDialog(snapshot);
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
                        _showReservationDialog(snapshot);
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

  void _showReservationDialog(AsyncSnapshot<EventModel> snapshot) {
    showDialog(
        context: context,
        builder: (BuildContext context) => ReservationDialog(
              snapshot.data.restaurantId,
              snapshot.data.restaurantName,
              snapshot.data.maxPeopleAllowed,
              event: snapshot.data,
            )).then((ok) {
      if (ok != null)
        showDialog(
          context: context,
          builder: (BuildContext context) => MessageDialog(
            message: S.of(context).successReservation,
          ),
        );
    });
  }

  void _checkEventData() {
    if (widget.event != null) {
      setState(() {
        _futureEvent = Future.value(widget.event);
      });
    } else {
      ApiClient client = PapricaApiClient();
      CustomerEventApi api = CustomerEventApi(client);
      api
          .apiServicesAppCustomerEventGetGet(id: widget.eventId)
          .then((eventDto) {
        setState(() {
          _futureEvent =
              Future.value(EventModel.fromCustomerEventDto(eventDto));
        });
      }).catchError((err) {
        Navigator.of(context).pop();
        PaprikaToast.showToast(S.of(context).messageEventNotFound,
            ToastType.Normal, Toast.LENGTH_LONG);
      });
    }
  }

  void _actionShare() {
    Share.share(S.of(context).shareTextEvent(
        widget.event.restaurantName ?? '',
        widget.event?.eventName ?? eventName ?? "",
        "https://links.paprika-sy.com/event/" + _eventId));
  }
}
