import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/erro_handlers/api_error_handler.dart';
import 'package:paprica/src/utils/paprica_api_client.dart';
import 'package:paprica/src/utils/paprica_formatter.dart';
import 'package:paprica/src/widgets/accessories.dart';
import 'package:paprica/src/widgets/dialog.dart';
import 'package:swagger/api.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:paprica/src/utils/api_types_helper.dart';
import '../../screens.dart';

class OpenPollCard extends StatefulWidget {
  final OpenPollInPapricaItem openPollItems;
  final String title;
  final Color titleColor;

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
  final String title;
  final Color titleColor;

  const PollItem({Key key, this.openPollItem, this.title, this.titleColor})
      : super(key: key);

  @override
  _PollItemState createState() => _PollItemState();
}

class _PollItemState extends State<PollItem> {
  List<bool> _checkBoxValues = [];
  List<int> _idRestaurants = [];
  List<String> _nameOfRestaurants = [];
  List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();
    _checkBoxValues.clear();
    _idRestaurants.clear();
    _nameOfRestaurants.clear();
    _widgets.clear();
    for (var x = 0; x < widget.openPollItem.restaurants.length; x++) {
      if (widget.openPollItem.selectedRestaurant ==
          widget.openPollItem.restaurants[x].id){
        _checkBoxValues.add(true);}
      else {
        _checkBoxValues.add(false);
      }
      _idRestaurants.add(widget.openPollItem.restaurants[x].id);
      _nameOfRestaurants.add(widget.openPollItem.restaurants[x].name);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                // children: _widgets,
                children: List.generate(widget.openPollItem.restaurants.length,
                    (index) {
                  return _restaurant(
                      context, widget.openPollItem.restaurants[index]);
                }),
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
                if (ApiTypesHelper().isAuthorized) {
                  if (_checkBoxValues.indexOf(true) != -1) {
                    _onSubmitVoteSelected(
                        context,
                        _nameOfRestaurants[_checkBoxValues.indexOf(true)],
                        _idRestaurants[_checkBoxValues.indexOf(true)]);
                    // _onConfirmSubmit(context, _idRestaurants[_checkBoxValues.indexOf(true)]);
                  } else {
                    debugPrint('852255658');
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (_context) {
                        return PapricaSimpleDialog(
                          title: S.of(context).pleaseLoginInOrderToVote,
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
                                    if (_checkBoxValues.indexOf(true) != -1) {
                                      _onSubmitVoteSelected(
                                          context,
                                          _nameOfRestaurants[_checkBoxValues.indexOf(true)],
                                          _idRestaurants[_checkBoxValues.indexOf(true)],);
                                    } else {
                                      debugPrint('852255658');
                                    }
                                  } else {
                                    PapricaToast.showToast(S
                                        .of(context)
                                        .loggingInRequired(S.of(context).actionReserve));
                                  }
                                });
                              },
                              child: Text(S.of(context).logIn)),
                        );
                      });
                }
              },
              child: Padding(
                padding: Localizations.localeOf(context).languageCode == 'en'
                    ? const EdgeInsets.only(left: 8.0, top: 5.0)
                    : const EdgeInsets.only(top: 5.0, right: 8.0),
                child: Center(
                    child: Text(
                  S.of(context).submitVote,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
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
            value: _checkBoxValues[_idRestaurants.indexOf(restaurant.id)],
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: (bool newValue) {
              setState(() {
                if (_checkBoxValues.indexOf(true) != -1) {
                  _checkBoxValues[_checkBoxValues.indexOf(true)] = false;
                }
                _checkBoxValues[_idRestaurants.indexOf(restaurant.id)] =
                    newValue;
              });
            }),
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
            totalValue: widget.openPollItem.totalVotes,
            value: restaurant.votes,
            positiveColor: Colors.black26,
            negativeColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  void _onSubmitVoteSelected(
      BuildContext context, String restName, int idRestaurant) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).alert),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(S.of(context).youWillVoteFor),
                Text(S.of(context).restaurant + ': ' + restName),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                _onConfirmSubmit(context, idRestaurant);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _onConfirmSubmit(BuildContext context, int idRestaurant) {
    ApiClient client = PapricaApiClient();
    CustomerPollApi api = CustomerPollApi(client);
    PollAddVoteDto data = PollAddVoteDto.fromJson(
        {'pollId': widget.openPollItem.id, 'restaurantId': idRestaurant});
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).voting);
    dialog.show();
    api.apiServicesAppCustomerPollAddVotePost(input: data).then((_)
    {
      dialog.hide();
      PapricaToast.showToast(S.of(context).successVoting);

    }).catchError((err) {
      dialog.hide();
      DefaultErrorHandler.handle(context, err);
    });
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
            width: totalValue == 0 ? 0 : width * value / totalValue,
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
