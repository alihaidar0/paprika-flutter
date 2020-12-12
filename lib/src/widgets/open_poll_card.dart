import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/utils/paprica_formatter.dart';
import 'package:swagger/api.dart';
import 'package:circular_check_box/circular_check_box.dart';

class OpenPollCard extends StatefulWidget {
  final OpenPollInPapricaItem openPollItems;
  final title;
  final titleColor;

  const OpenPollCard({Key key, this.openPollItems, this.title, this.titleColor})
      : super(key: key);

  @override
  _OpenPollCardState createState() => _OpenPollCardState();
}

class _OpenPollCardState extends State<OpenPollCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [];
    for (var x = 0; x < widget.openPollItems.items.length; x++) {
      _widgets.add(
        Container(
          width: MediaQuery.of(context).size.width,
          child: PollItem(openPollItem: widget.openPollItems.items[x]),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                color: widget.titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Column(
              children: _widgets,
            ),
          ),
        ],
      ),
    );
  }
}

class PollItem extends StatefulWidget {
  final OpenPollItem openPollItem;
  final title;
  final titleColor;

  const PollItem({Key key, this.openPollItem, this.title, this.titleColor})
      : super(key: key);

  @override
  _PollItemState createState() => _PollItemState();
}

class _PollItemState extends State<PollItem> {
  bool checkBoxValue;

  @override
  void initState() {
    super.initState();
    checkBoxValue = false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [];
    for (var x = 0; x < widget.openPollItem.restaurants.length; x++) {
      _widgets.add(
        Container(
          width: MediaQuery.of(context).size.width,
          child: _restaurant(context, widget.openPollItem.restaurants[x]),
        ),
      );
    }

    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 12.0, top: 12.0, right: 12.0, bottom: 5.0),
                child: Text(widget.openPollItem.pollText,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              Container(
                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                child: Text(
                    S.of(context).closeDate +
                        ": " +
                        PapricaFormatter.formatDateOnly(
                            context, widget.openPollItem.closeDate) +
                        "  " +
                        PapricaFormatter.formatTimeOnly(
                            context, widget.openPollItem.closeDate),
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              Column(
                children: _widgets,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(offset: Offset(3, 6), color: Colors.black38)
              ],
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 40,
            child: InkWell(
              onTap: () {
                debugPrint('852255658');
              },
              child: Padding(
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? const EdgeInsets.only(left: 8.0, top: 5.0)
                    : const EdgeInsets.only(top: 5.0, right: 8.0),
                child: Center(child: Text(S.of(context).submitVote,style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),)),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _restaurant(
      BuildContext context, RestaurantPollInPapricaItem restaurant) {
    double _percent = restaurant.votes / widget.openPollItem.totalVotes;
    return Row(
      children: [
        CircularCheckBox(
          activeColor: Colors.green,
            value: checkBoxValue,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: (bool newValue) {
              debugPrint('-*-*-*-*-');
              debugPrint('${newValue}');
              debugPrint('-*-*-*-*-');
              setState(() {
                checkBoxValue = newValue;
              });
            }
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.23 * 0.5),
            child: CachedNetworkImage(
                imageUrl: restaurant.logoImage,
                placeholder: (context, url) => Image(
                      image: AssetImage("assets/images/placeholder.png"),
                      width: MediaQuery.of(context).size.width * 0.23,
                    ),
                width: MediaQuery.of(context).size.width * 0.23),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _Slider(
            title: restaurant.name,
            height: 50,
            width: MediaQuery.of(context).size.width * 0.5,
            // totalValue: widget.openPollItem.totalVotes,
            // value: restaurant.votes,
            totalValue: 100,
            value: 50,
            positiveColor: Colors.black26,
            negativeColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class _Slider extends StatelessWidget {
  String title;
  double height;
  double width;
  int totalValue;
  int value;
  Color positiveColor;
  Color negativeColor;

  _Slider(
      {this.title,
      this.height,
      this.width,
      this.totalValue,
      this.value,
      this.positiveColor,
      this.negativeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
              color: negativeColor,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(2),
            width: width * value / totalValue,
            decoration: BoxDecoration(
              color: positiveColor,
            ),
          ),
          Container(
            padding: Localizations.localeOf(context).languageCode == 'en'
                ? EdgeInsets.only(left: 10, top: 2)
                : EdgeInsets.only(right: 10, top: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(
                    "${value} " +
                        S.of(context).outOff +
                        " ${totalValue} " +
                        S.of(context).votes,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
