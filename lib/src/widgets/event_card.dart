import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprika/screens.dart';
import 'package:paprika/src/models/event_model.dart';
import 'package:paprika/src/screens/event_screen.dart';
import 'package:paprika/translations.dart';
import 'package:share/share.dart';
import 'package:swagger/api.dart';

import '../../utils.dart';

class EventCardThemeData {
  Color backgroundColor, titleColor, actionTextColor;

  EventCardThemeData(
      {@required this.backgroundColor,
      @required this.titleColor,
      @required this.actionTextColor});
}

class EventCard extends StatelessWidget {
  final EventModel event;
  final EventCardThemeData cardThemeData;
  final GestureTapCallback onPressed;

  final EdgeInsets margin;

  final double borderRadius;

  EventCard({
    @required this.event,
    this.cardThemeData,
    this.onPressed,
    this.margin,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    bool isLtr = Localizations.localeOf(context).languageCode == 'en';
    Radius radiusTopRight = isLtr ? Radius.circular(borderRadius) : Radius.zero;
    Radius radiusBottomRight =
        isLtr ? Radius.circular(borderRadius) : Radius.zero;
    Radius radiusTopLeft = isLtr ? Radius.zero : Radius.circular(borderRadius);
    Radius radiusBottomLeft =
        isLtr ? Radius.zero : Radius.circular(borderRadius);

    //Initiate card theme data
    EventCardThemeData themeData = cardThemeData ?? /*if not null, else */
        EventCardThemeData(
            backgroundColor: Colors.white,
            titleColor: Colors.black,
            actionTextColor: Theme.of(context).primaryColor);
    return GestureDetector(
      onTap: () => this.onPressed != null && this.onPressed is Function
          ? this.onPressed()
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventScreen(
                        eventId: event.id,
                      ))),
      child: Card(
        margin: margin ?? EdgeInsets.all(4),
        color: themeData?.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: radiusTopRight,
              topLeft: radiusTopLeft,
              bottomRight: radiusBottomRight,
              bottomLeft: radiusBottomLeft),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: event.imageUrl,
                width: MediaQuery.of(context).size.width * 0.25,
                height: Localizations.localeOf(context).languageCode == 'en'
                    ? 100
                    : 113,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image(
                  image: AssetImage("assets/images/placeholder.png"),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: Localizations.localeOf(context).languageCode == 'en'
                      ? 100
                      : 113,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width * 0.35,
                          child: Text(
                            event.eventName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      event.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          PaprikaFormatter.formatDateOnly(context, event.date),
                          style: TextStyle(
                              color: themeData.titleColor, fontSize: 12),
                        ),
                        Text(
                          PaprikaFormatter.formatTimeOnly(context, event.date),
                          style: TextStyle(
                              color: themeData.titleColor, fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).checkOut,
                                style: TextStyle(
                                  color: themeData.actionTextColor,
                                  fontSize: 14,
//                                  fontWeight: FontWeight.,
                                ),
                              ),
                              Icon(
                                Icons.navigate_next,
                                size: 15,
                                color: themeData.actionTextColor,
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
          ],
        ),
      ),
    );
  }
}

class MyPaprikaEventCard extends StatefulWidget {
  final EventPapricaItemDto event;
  final EventCardThemeData cardThemeData;
  final GestureTapCallback onPressed;

  const MyPaprikaEventCard(
      {Key key, this.event, this.cardThemeData, this.onPressed})
      : super(key: key);

  @override
  _MyPaprikaEventCardState createState() => _MyPaprikaEventCardState();
}

class _MyPaprikaEventCardState extends State<MyPaprikaEventCard> {
  String eventName;

  String get _eventId => widget.event.id.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EventCardThemeData themeData =
        widget.cardThemeData ?? /*if not null, else */
            EventCardThemeData(
                backgroundColor: Colors.white,
                titleColor: Colors.black,
                actionTextColor: Theme.of(context).primaryColor);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          this.widget.onPressed != null && this.widget.onPressed is Function
              ? this.widget.onPressed()
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventScreen(
                      event: EventModel.fromEventPaprikaItemDto(widget.event),
                    ),
                  ),
                ),
      child: Container(
        color: themeData?.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 55),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: widget.event.image,
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
                  ),
                  Positioned(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return RestaurantHome(
                                restaurantId: widget.event.restaurantId,
                              );
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
                                  widget.event.restaurantLogo,
                                ),
                                backgroundColor: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            widget.event.restaurantName,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.event.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: themeData.actionTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.event.id != null ? _actionShare : () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.share, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            PaprikaFormatter.formatDateOnly(
                                context, widget.event.time),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: themeData.actionTextColor, fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          PaprikaFormatter.formatTimeOnly(
                              context, widget.event.time),
                          style: TextStyle(
                              color: themeData.actionTextColor, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    widget.event.description != null &&
                            widget.event.description.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.event.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (DateTime.now().isAfter(widget.event.time)
                                ? Colors.grey
                                : Theme.of(context).primaryColor),
                            width: 1,
                            style: BorderStyle.solid)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Text(
                        (DateTime.now().isAfter(widget.event.time)
                            ? S.of(context).oldEvent.toUpperCase()
                            : S.of(context).event.toUpperCase()),
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 18,
                          color: (DateTime.now().isAfter(widget.event.time)
                              ? Colors.grey
                              : Theme.of(context).primaryColor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _actionShare() {
    Share.share(S.of(context).shareTextEvent(
        widget.event.restaurantName ?? '',
        widget.event.name ?? "",
        "https://links.paprika-sy.com/event/" + _eventId));
  }
}

// class MyPaprikaEventCard extends StatelessWidget {
//   final EventPapricaItemDto event;
//   final EventCardThemeData cardThemeData;
//   final GestureTapCallback onPressed;
//
//   MyPaprikaEventCard({
//     @required this.event,
//     this.cardThemeData,
//     this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     EventCardThemeData themeData = cardThemeData ?? /*if not null, else */
//         EventCardThemeData(
//             backgroundColor: Colors.white,
//             titleColor: Colors.black,
//             actionTextColor: Theme.of(context).primaryColor);
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () => this.onPressed != null && this.onPressed is Function
//           ? this.onPressed()
//           : Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => EventScreen(
//                   event: EventModel.fromEventPaprikaItemDto(event),
//                 ),
//               ),
//             ),
//       child: Container(
//         color: themeData?.backgroundColor,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 8),
//           child: Column(
//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 55),
//                     child: GestureDetector(
//                       child: CachedNetworkImage(
//                         imageUrl: event.image,
//                         placeholder: (context, url) => Image(
//                           image: AssetImage("assets/images/placeholder.png"),
//                           width: MediaQuery.of(context).size.width,
//                           height: 250,
//                           fit: BoxFit.cover,
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         height: 250,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     child: Row(
//                       children: <Widget>[
//                         GestureDetector(
//                           behavior: HitTestBehavior.opaque,
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (BuildContext context) {
//                               return RestaurantHome(
//                                 restaurantId: event.restaurantId,
//                               );
//                             }));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Colors.white,
//                               child: CircleAvatar(
//                                 radius: 35,
//                                 backgroundImage: CachedNetworkImageProvider(
//                                   event.restaurantLogo,
//                                 ),
//                                 backgroundColor: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: Text(
//                             event.restaurantName,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 21,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Flexible(
//                           child: Text(
//                             event.name,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: themeData.actionTextColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: _actionShare(context),
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Icon(Icons.share, color: Colors.black87),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Flexible(
//                           child: Text(
//                             PaprikaFormatter.formatDateOnly(
//                                 context, event.time),
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: themeData.actionTextColor, fontSize: 12),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           PaprikaFormatter.formatTimeOnly(context, event.time),
//                           style: TextStyle(
//                               color: themeData.actionTextColor, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     event.description != null && event.description.isNotEmpty
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               Flexible(
//                                 child: Text(
//                                   event.description,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Container(),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             color: (DateTime.now().isAfter(event.time)
//                                 ? Colors.grey
//                                 : Theme.of(context).primaryColor),
//                             width: 1,
//                             style: BorderStyle.solid)),
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                       child: Text(
//                         (DateTime.now().isAfter(event.time)
//                             ? S.of(context).oldEvent.toUpperCase()
//                             : S.of(context).event.toUpperCase()),
//                         style: TextStyle(
//                           letterSpacing: 1.5,
//                           fontSize: 18,
//                           color: (DateTime.now().isAfter(event.time)
//                               ? Colors.grey
//                               : Theme.of(context).primaryColor),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _actionShare(BuildContext context) {
//     Share.share(S.of(context).shareTextEvent(
//         event.restaurantName ?? '',
//         event ?? "",
//         "https://links.paprika-sy.com/event/" + event.id.toString()));
//   }
// }
