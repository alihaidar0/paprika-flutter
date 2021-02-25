import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/models/event_model.dart';
import 'package:paprika/src/widgets/accessories.dart' show LoadingPlaceHolder;
import 'package:paprika/src/widgets/event_card.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';

class EventsListScreen extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;

  const EventsListScreen(
      {@required this.restaurantId, @required this.restaurantName});

  @override
  _EventsListScreenState createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  Future<PagedResultDtoCustomerEventDto> eventFuture;

  ScrollController _scrollController;

  bool _requestingData;
  List<dynamic> events;

  bool _endOfEvents;

  @override
  void initState() {
    super.initState();
    _requestingData = false;
    _endOfEvents = false;
    events = [];
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          !_requestingData &&
          events.isNotEmpty &&
          context != null &&
          !_endOfEvents) {
        _getEvents(skipCount: events.length);
      }
    });
    _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    if (_requestingData) {
      events.add(SpinKitCircle(color: Colors.grey, size: 32));
    }
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text(S.of(context).eventsListTitle(widget.restaurantName)),
        ),
        body: FutureBuilder(
            future: eventFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return events.length > 0
                    ? ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          if (events[index] is CustomerEventDto) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Opacity(
                                opacity: DateTime.now().isAfter(
                                        (events[index] as CustomerEventDto)
                                            .time)
                                    ? 0.5
                                    : 1,
                                child: EventCard(
                                  event: EventModel.fromCustomerEventDto(
                                      events[index]),
                                ),
                              ),
                            );
                          } else {
                            return events[index];
                          }
                        },
                      )
                    : Center(
                        child: NoEventsLayout(
                        restaurantName: widget.restaurantName,
                      ));
              }
              return LoadingPlaceHolder(
                icon: SpinKitFadingCube(
                  color: Theme.of(context).primaryColor,
                ),
                line: S.of(context).findingEvents,
              );
            }));
  }

  _getEvents({int skipCount = 0, int maxResult = 7}) {
    setState(() {
      _requestingData = true;
    });
    ApiClient client = PapricaApiClient();
    CustomerEventApi api = CustomerEventApi(client);
    eventFuture = api.apiServicesAppCustomerEventGetAllGet(
        restaurantId: widget.restaurantId,
        skipCount: skipCount,
        maxResultCount: maxResult);
    eventFuture.then((data) {
      setState(() {
        if (events.last is SpinKitCircle) events.removeLast();
        _requestingData = false;
        if (data.items.isEmpty) {
          _endOfEvents = true;
        } else {
          events.addAll(data.items);
        }
      });
    });
    eventFuture.catchError((err) {
      setState(() {
        if (events.last is SpinKitCircle) events.removeLast();
        _requestingData = false;
      });
      DefaultErrorHandler.handle(context, err);
    });
  }
}

class NoEventsLayout extends StatelessWidget {
  final String restaurantName;

  const NoEventsLayout({Key key, @required this.restaurantName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            child: Image.asset("assets/images/no_events.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).noEvents(restaurantName),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_left,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    S.of(context).goBack,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
