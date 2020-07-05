import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprica/src/models/event_model.dart';

import '../../utils.dart';

class EventsListView extends StatelessWidget {
  final List<EventModel> eventsList;
  final String title;
  final Color titleColor;

  EventsListView({this.eventsList, this.title, this.titleColor});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var x = 0; x < eventsList.length; x++) {
      widgets.add(
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: _buildEventCard(context, x),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: titleColor,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.23 + 90,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(5.0),
            children: widgets,
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, int x) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: <Widget>[
          Image(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.25,
            image: AssetImage(eventsList[x].imageUrl),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        eventsList[x].eventName,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        eventsList[x].restaurantName,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 3, 8, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        eventsList[x].bandName,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        PapricaFormatter.formatDateOnly(context, eventsList[x].date),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        PapricaFormatter.formatTimeOnly(context, eventsList[x].date),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Check out",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
