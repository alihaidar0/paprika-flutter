import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/erro_handlers/api_error_handler.dart';
import 'package:paprica/src/utils/paprica_api_client.dart';
import 'package:paprica/src/utils/paprica_formatter.dart';
import 'package:paprica/src/widgets/accessories.dart';
import 'package:paprica/src/widgets/dialog.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
          child: PollItem(
            openPollItem: widget.openPollItems.items[x],
            title: widget.title,
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        children: _widgets,
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
          widget.openPollItem.restaurants[x].id) {
        _checkBoxValues.add(true);
      } else {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 12.0, top: 12.0, right: 12.0),
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.openPollItem.restaurants.length,
            itemBuilder: (context, index) {
              return _restaurant(
                  context, widget.openPollItem.restaurants[index]);
            },
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget _restaurant(
      BuildContext context, RestaurantPollInPapricaItem restaurant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.19 * 0.5),
                child: CachedNetworkImage(
                    imageUrl: restaurant.logoImage,
                    placeholder: (context, url) => Image(
                          image: AssetImage("assets/images/placeholder.png"),
                          width: MediaQuery.of(context).size.width * 0.19,
                        ),
                    width: MediaQuery.of(context).size.width * 0.19),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 3.0,
                top: 8.0,
                bottom: 8.0,
                right: 3.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(
                        height: 0.5,
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${restaurant.votes} " +
                        S.of(context).outOf +
                        " ${widget.openPollItem.totalVotes} " +
                        S.of(context).votes,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  LinearPercentIndicator(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    alignment: MainAxisAlignment.start,
                    width: MediaQuery.of(context).size.width * 0.6,
                    lineHeight: 8.0,
                    percent: widget.openPollItem.totalVotes == 0
                        ? 0
                        : restaurant.votes / widget.openPollItem.totalVotes,
                    progressColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 28.0,
            ),
            CircularCheckBox(
                activeColor: Theme.of(context).primaryColor,
                value: _checkBoxValues[_idRestaurants.indexOf(restaurant.id)],
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: (bool newValue) {
                  setState(() {
                    if (ApiTypesHelper().isAuthorized) {
                      if (_checkBoxValues.indexOf(true) != -1) {
                        if (_idRestaurants[_checkBoxValues.indexOf(true)] ==
                            restaurant.id) {
                          _checkBoxValues[_idRestaurants.indexOf(restaurant.id)] =
                              newValue;
                          _onClearVote(context);
                        } else {
                          _checkBoxValues[_checkBoxValues.indexOf(true)] = false;
                          _checkBoxValues[_idRestaurants.indexOf(restaurant.id)] =
                              newValue;
                          _onAddVote(context,
                              _idRestaurants[_checkBoxValues.indexOf(true)]);
                        }
                      } else {
                        _checkBoxValues[_idRestaurants.indexOf(restaurant.id)] =
                            newValue;
                        _onAddVote(
                            context, _idRestaurants[_checkBoxValues.indexOf(true)]);
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
                                            LogInScreen(asAService: true),
                                      ),
                                    ).then((loggedIn) {
                                      if (loggedIn != null && loggedIn) {
                                      } else {
                                        PapricaToast.showToast(S
                                            .of(context)
                                            .loggingInRequired(S.of(context).vote));
                                      }
                                    });
                                  },
                                  child: Text(S.of(context).logIn)),
                            );
                          });
                    }
                  });
                }),
          ],
        ),
      ],
    );
  }

  _onAddVote(BuildContext context, int idRestaurant) {
    ApiClient client = PapricaApiClient();
    CustomerPollApi api = CustomerPollApi(client);
    PollAddVoteDto _data = PollAddVoteDto.fromJson(
        {'pollId': widget.openPollItem.id, 'restaurantId': idRestaurant});
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).voting);
    dialog.show();
    api.apiServicesAppCustomerPollAddVotePost(input: _data).then((_) {
      dialog.hide();
      PapricaToast.showToast(S.of(context).thankYouForVoting);
    }).catchError((err) {
      dialog.hide();
      DefaultErrorHandler.handle(context, err);
    });
  }

  _onClearVote(BuildContext context) {
    ApiClient client = PapricaApiClient();
    CustomerPollApi api = CustomerPollApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).clearVoting);
    dialog.show();
    api.apiServicesAppCustomerPollClearVotePost(pollId: widget.openPollItem.id).then((_) {
      dialog.hide();
      PapricaToast.showToast(S.of(context).theVotingHasBeenCleared);
    }).catchError((err) {
      dialog.hide();
      DefaultErrorHandler.handle(context, err);
    });
  }
}
