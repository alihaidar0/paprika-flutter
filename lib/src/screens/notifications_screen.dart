import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paprica/pages.dart';
import 'package:paprica/src/models/notification.dart';
import 'package:paprica/src/screens/deliveries_screen.dart';
import 'package:paprica/src/screens/offer_screen.dart';
import 'package:paprica/src/screens/pickups_screen.dart';
import 'package:paprica/src/widgets/login_promotion.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';
import '../../error_handlers.dart';
import '../../screens.dart';
import '../../utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen();

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<dynamic> _notifications = [];

  Future<NotificationsInfoDto> _futureNotifications;

  ScrollController _scrollController;

  bool _endOfNotificationsReached;

  bool _requestingData;

  @override
  void initState() {
    _requestingData = false;
    super.initState();
    _endOfNotificationsReached = false;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          !_requestingData &&
          !_endOfNotificationsReached) {
        _getNotifications();
      }
    });
    if (ApiTypesHelper().isAuthorized) _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    if (_requestingData) {
      _notifications.add(SpinKitCircle(color: Colors.grey, size: 32));
    }
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(
          S.of(context).myNotifications,
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ApiTypesHelper().isAuthorized
          ? FutureBuilder(
              future: _futureNotifications,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _notifications.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: _notifications.length,
                            itemBuilder: (context, index) {
                              if (_notifications[index]
                                  is NotificationInfoDto) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => _onTapNotification(
                                      context,
                                      NotificationModel.fromNotificationDto(
                                          _notifications[index])),
                                  child: NotificationCard(
                                      notification:
                                          NotificationModel.fromNotificationDto(
                                              _notifications[index])),
                                );
                              } else {
                                return _notifications[index];
                              }
                            },
                          ),
                        )
                      : NoNotificationsLayout();
                } else if (snapshot.hasError) {
                  return RequestRetry(retryCallback: _getNotifications);
                }
                return Center(child: CircularProgressIndicator());
              })
          : LogInPromotion(
              loginLine: S.of(context).loginPromotionNotifications),
    );
  }

  void _onClearNotifications(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return PapricaSimpleDialog(
              title: S.of(context).messageClearNotification,
              yesButton: RaisedButton(
                  child: Text(S.of(context).yes),
                  onPressed: () {
                    setState(() {
                      _notifications = [];
                    });
                    Navigator.of(context).pop();
                  }));
        });
  }

  Future _getNotifications() {
    setState(() {
      _requestingData = true;
    });
    ApiClient client = PapricaApiClient();
    NotificationsApi api = NotificationsApi(client);
    _futureNotifications =
        api.apiServicesAppNotificationsGetNotificationsInfoGet(
      skipCount: _notifications?.length ?? 0,
      maxResultCount: 10,
    );
    _futureNotifications.then((data) {
      if (data != null) {
        setState(() {
          _requestingData = false;
          if (_notifications.length > 0 &&
              _notifications.last is SpinKitCircle) {
            _notifications.removeLast();
          }
          if (data.notifications.isEmpty) {
            _endOfNotificationsReached = true;
          } else {
            _notifications.addAll(data.notifications);
          }
        });
      }
    }).catchError((err) {
      setState(() {
        _requestingData = false;
      });
      DefaultErrorHandler.handle(context, err);
    });
    return null;
  }

  _onTapNotification(BuildContext context, NotificationModel notification) {
    switch (notification.notificationName) {

      /// reservation
      case NotificationType.reservationApproved:
      case NotificationType.reservationRejected:
      case NotificationType.reservationUpdateRejected:
      case NotificationType.reservationUpdateApproved:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ReservationsScreen();
        }));
        break;

      /// pickup
      case NotificationType.pickupApproved:
      case NotificationType.pickupRejected:
      case NotificationType.pickupUpdateRejected:
      case NotificationType.pickupUpdateApproved:
      case NotificationType.pickupIsReady:
      case NotificationType.pickupResponseMessage:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return PickupsScreen();
        }));
        break;

      /// delivery
      case NotificationType.deliveryApproved:
      case NotificationType.deliveryRejected:
      case NotificationType.deliveryUpdateRejected:
      case NotificationType.deliveryUpdateApproved:
      case NotificationType.deliveryResponseMessage:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return DeliveriesScreen();
        }));
        break;

      /// newRestaurantAdded
      case NotificationType.newRestaurantAdded:
        int restId =
            (notification.data as NotificationRestaurantAdded).restaurantId;
        if (restId != null && restId > 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return RestaurantHome(restaurantId: restId);
          }));
        }
        break;

      /// newEventAdded
      case NotificationType.newEventAdded:
        int eventId = (notification.data as NotificationEventAdded).eventId;
        if (eventId != null && eventId > 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return EventScreen(eventId: eventId);
          }));
        }
        break;

      /// newOfferAdded
      case NotificationType.newOfferAdded:
        int offerId = (notification.data as NotificationOfferAdded).offerId;
        if (offerId != null && offerId > 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return OfferScreen(
              offerId: offerId,
            );
          }));
        }
        break;
    }
  }

  Future<void> _onRefresh() {
    _notifications.clear();
    _getNotifications();
    return Future.value();
  }
}

class NoNotificationsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              child: Image.asset("assets/images/no_notifications.png"),
            ),
            SizedBox(height: 16),
            Text(
              S.of(context).youCouldHearPinDrop,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return DiscoverPage();
                }));
              },
              child: Text(
                S.of(context).discoverNewRestaurants,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;

  NotificationCard({@required this.notification});

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  final double _cardHeight = 130;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: _cardHeight,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              widget.notification.data != null
                  ? ClipRRect(
                      borderRadius:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))
                              : BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: widget.notification.data.image,
                        height: _cardHeight,
                        width: _cardHeight - 30,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: Text(widget.notification.title ?? "",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.fade),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  widget.notification.data
                                              is NotificationReservation &&
                                          widget.notification.data
                                                  .reservationTime !=
                                              null
                                      ? Text(
                                          S.of(context).time +
                                              ": " +
                                              PapricaFormatter.formatDateTime(
                                                  context,
                                                  DateTime.parse(widget
                                                      .notification
                                                      .data
                                                      .reservationTime)),
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic))
                                      : EmptyWidget()
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: Text(
                                        widget.notification.data.message ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              PapricaFormatter.formatDateOnly(context,
                                  widget.notification.date ?? DateTime.now()),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w300)),
                          Text(
                              PapricaFormatter.formatTimeOnly(context,
                                  widget.notification.date ?? DateTime.now()),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w300)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
