import 'package:flutter/material.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/utils.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../utils.dart';

class ReviewResult extends StatelessWidget {
  final double restaurantRate;
  final RestaurantRatersDto restaurantRaters;
  final Color backgroundColor;

  ReviewResult(
      {@required this.restaurantRate,
      @required this.restaurantRaters,
      this.backgroundColor});

  int getTotalReviewers() {
    return restaurantRaters.oneStar +
        restaurantRaters.twoStars +
        restaurantRaters.threeStars +
        restaurantRaters.fourStars +
        restaurantRaters.fiveStars;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double lineBarWidth = screenWidth * 0.55;
    double mLineBarHeight = 10;

    return Container(
      color: this.backgroundColor,
      padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.restaurantRate.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width / 6,
                  ),
                ),
                FlutterRatingBarIndicator(
                  rating: this.restaurantRate,
                  itemCount: 5,
                  itemSize: 15.0,
                  emptyColor: Colors.black,
                  //Colors.amber.withAlpha(50),
                  itemPadding: EdgeInsets.all(2.1),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    S.of(context).total +
                        ": " +
                        "(" +
                        PapricaFormatter.formatNumber(
                            _countRater(restaurantRaters)) +
                        ")",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              BarLine(
                lineHeight: mLineBarHeight,
                totalWidth: lineBarWidth,
                value: getTotalReviewers() == 0
                    ? 0
                    : restaurantRaters.oneStar / getTotalReviewers(),
                mainBarColor: Colors.white,
                title: "1",
              ),
              BarLine(
                lineHeight: mLineBarHeight,
                totalWidth: lineBarWidth,
                value: getTotalReviewers() == 0
                    ? 0
                    : restaurantRaters.twoStars / getTotalReviewers(),
                mainBarColor: Colors.white,
                title: "2",
              ),
              BarLine(
                lineHeight: mLineBarHeight,
                totalWidth: lineBarWidth,
                value: getTotalReviewers() == 0
                    ? 0
                    : restaurantRaters.threeStars / getTotalReviewers(),
                title: "3",
                mainBarColor: Colors.white,
              ),
              BarLine(
                lineHeight: mLineBarHeight,
                totalWidth: lineBarWidth,
                value: getTotalReviewers() == 0
                    ? 0
                    : restaurantRaters.fourStars / getTotalReviewers(),
                mainBarColor: Colors.white,
                title: "4",
              ),
              BarLine(
                lineHeight: mLineBarHeight,
                totalWidth: lineBarWidth,
                mainBarColor: Colors.white,
                value: getTotalReviewers() == 0
                    ? 0
                    : restaurantRaters.fiveStars / getTotalReviewers(),
                title: "5",
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _countRater(RestaurantRatersDto restaurantRaters) {
    return restaurantRaters.oneStar +
        restaurantRaters.twoStars +
        restaurantRaters.threeStars +
        restaurantRaters.fourStars +
        restaurantRaters.fiveStars;
  }
}

class ServiceReviewsLine extends StatelessWidget {
  final double foodRate;
  final double serviceRate;
  final double shishaRate;
  final double ambianceRate;
  final String noiseLevel;

  final Color backgroundColor;

  const ServiceReviewsLine(
      {@required this.foodRate,
      @required this.serviceRate,
      @required this.shishaRate,
      @required this.ambianceRate,
      @required this.noiseLevel,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  S.of(context).food,
                ),
                Text(
                  foodRate.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  S.of(context).service,
                ),
                Text(
                  serviceRate.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  S.of(context).shisha,
                ),
                Text(
                  shishaRate.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  S.of(context).ambiance,
                ),
                Text(
                  ambianceRate.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  S.of(context).noiseLevel,
                ),
                Text(
                  noiseLevel.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
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

class ReviewCommentsListItem extends StatelessWidget {
  final ReviewSummaryDto userReview;

  const ReviewCommentsListItem(this.userReview);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircularAvatar(
            userReview.customerProfileImage != null
                ? userReview.customerProfileImage
                : "assets/icons/avatar_male.png",
            isLocal: userReview.customerProfileImage == null,
            elevation: 0,
            size: 46,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: Localizations.localeOf(context).languageCode == 'en'
                      ? const EdgeInsets.only(left: 10.0, top: 4)
                      : const EdgeInsets.only(right: 8.0, top: 4),
                  child: Text(
                    userReview.customerFullName,
                    style: TextStyle(fontWeight: FontWeight.w500, height: 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: FlutterRatingBarIndicator(
                    rating: userReview.rate,
                    itemCount: 5,
                    itemSize: 8.0,
                    itemPadding: EdgeInsets.all(2.1),
                  ),
                ),
                userReview.comment != null && userReview.comment.isNotEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: Text(
                                  userReview.comment,
                                  softWrap: true,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnSubmitReviewCallback(jsonData);

class ReviewForm extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final ReviewDto oldReview;
  final String customerProfileImage;
  final OnSubmitReviewCallback onSubmit;

  const ReviewForm(
      {@required this.restaurantId,
      this.restaurantName,
      this.customerProfileImage,
      this.oldReview,
      this.onSubmit});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  String noiseLevel;

  double foodRate;

  double restaurantRate;

  double serviceRate;

  double shishaRate;

  double ambianceRate;

  TextEditingController commentController;

  int noiseLevelInt;

  bool isSubmitting;

  bool get formEdited {
    return foodRateEdited ||
        restaurantRateEdited ||
        serviceRateEdited ||
        shishaRateEdited ||
        ambianceRateEdited ||
        noiseLevelEdited ||
        commentEdited;
  }

  bool foodRateEdited;
  bool restaurantRateEdited;
  bool serviceRateEdited;
  bool shishaRateEdited;
  bool ambianceRateEdited;
  bool noiseLevelEdited;
  bool commentEdited;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    commentController.text = oldReview ? widget.oldReview.comment : null;
    _initializeFormFields();
    commentController.addListener(() {
      setState(() {
        if (commentController.text != widget.oldReview.comment) {
          commentEdited = true;
        } else {
          commentEdited = false;
        }
      });
    });
    isSubmitting = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get oldReview {
    return widget.oldReview != null;
  }

  @override
  Widget build(BuildContext context) {
    var isLocalProfileImage = widget.customerProfileImage == null ||
        widget.customerProfileImage == '';

    noiseLevel ??= oldReview && widget.oldReview.noiseLevel != null
        ? ApiHelper.toStringNoiseLevel(context, widget.oldReview.noiseLevel)
        : "";
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Card(
              margin: EdgeInsets.all(18),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 42),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(7)
                          },
                          children: [
                            TableRow(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(null != widget.restaurantName
                                    ? widget.restaurantName
                                    : S.of(context).generalRate),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FlutterRatingBar(
                                  initialRating: restaurantRate,
                                  allowHalfRating: true,
                                  ignoreGestures: false,
                                  tapOnlyMode: false,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 6.0),
                                  onRatingUpdate: (rating) {
                                    restaurantRate = rating;
                                    setState(() {
                                      if (restaurantRate !=
                                          widget.oldReview.restaurantRate) {
                                        restaurantRateEdited = true;
                                      } else {
                                        restaurantRateEdited = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).food),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FlutterRatingBar(
                                  initialRating: foodRate,
                                  allowHalfRating: true,
                                  ignoreGestures: false,
                                  tapOnlyMode: false,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 6.0),
                                  onRatingUpdate: (rating) {
                                    foodRate = rating;
                                    setState(() {
                                      if (foodRate !=
                                          widget.oldReview.foodRate) {
                                        foodRateEdited = true;
                                      } else {
                                        foodRateEdited = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).service),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FlutterRatingBar(
                                  initialRating: serviceRate,
                                  allowHalfRating: true,
                                  ignoreGestures: false,
                                  tapOnlyMode: false,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 6.0),
                                  onRatingUpdate: (rating) {
                                    serviceRate = rating;
                                    setState(() {
                                      if (serviceRate !=
                                          widget.oldReview.serviceRate) {
                                        serviceRateEdited = true;
                                      } else {
                                        serviceRateEdited = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).shisha),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FlutterRatingBar(
                                  initialRating: shishaRate,
                                  allowHalfRating: true,
                                  ignoreGestures: false,
                                  tapOnlyMode: false,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 6.0),
                                  onRatingUpdate: (rating) {
                                    shishaRate = rating;
                                    setState(() {
                                      if (shishaRate !=
                                          widget.oldReview.shishaRate) {
                                        shishaRateEdited = true;
                                      } else {
                                        shishaRateEdited = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).ambiance),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FlutterRatingBar(
                                  initialRating: ambianceRate,
                                  allowHalfRating: true,
                                  ignoreGestures: false,
                                  tapOnlyMode: false,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 6.0),
                                  onRatingUpdate: (rating) {
                                    ambianceRate = rating;
                                    setState(() {
                                      if (ambianceRate !=
                                          widget.oldReview.ambianceRate) {
                                        ambianceRateEdited = true;
                                      } else {
                                        ambianceRateEdited = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ]),
                          ],
                        )),

                    /// Noise Level
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(S.of(context).noiseLevel),
                          ),
                          Row(
                              children: ApiTypesHelper()
                                  .types
                                  .noiseLevels
                                  .map<Widget>((enumValue) {
                            return StringRadioButton(
                              enumValue.name,
                              radioValue: noiseLevel,
                              onRadioTab: (value) {
                                setState(() {
                                  noiseLevel = value;
                                  noiseLevelInt = enumValue.value;
                                  if (noiseLevelInt !=
                                      widget.oldReview.noiseLevel) {
                                    noiseLevelEdited = true;
                                  } else {
                                    noiseLevelEdited = false;
                                  }
                                });
                              },
                            );
                          }).toList()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: commentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: null,
                        autofocus: false,
                        textAlign:
                            Localizations.localeOf(context).languageCode == 'en'
                                ? TextAlign.left
                                : TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                        decoration: InputDecoration(
                          hintText: S.of(context).addComment,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          icon: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset("assets/icons/comment_2.png")),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFaa757f)),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(3.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFaa757f)),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(3.0)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomizedActiveButton(
                            onPressed: !formEdited
                                ? null
                                : () => _onSubmitPressed(context),
                            title: S.of(context).save,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width / 2 - 30,
            child: CircularAvatar(
              isLocalProfileImage
                  ? "assets/icons/avatar_female.png"
                  : widget.customerProfileImage,
              isLocal: isLocalProfileImage,
              elevation: 0,
              size: 46,
            ),
          ),
        ],
      ),
    );
  }

  _onSubmitReview() {
    ProgressDialog sendingDialog = ProgressDialog(context);
    sendingDialog.setMessage(S.of(context).processing);
    setState(() {
      isSubmitting = true;
      sendingDialog.show();
    });
    ApiClient client = PapricaApiClient();
    CustomerReviewApi api = CustomerReviewApi(client);
    var jsonData = {
      "restaurantId": widget.restaurantId,
      "restaurantRate": restaurantRate,
      "foodRate": foodRate,
      "serviceRate": serviceRate,
      "shishaRate": shishaRate,
      "ambianceRate": ambianceRate,
      "noiseLevel": noiseLevelInt,
      "comment": commentController.text
    };
    CreateOrUpdateReviewDto data = CreateOrUpdateReviewDto.fromJson(jsonData);
    api.apiServicesAppCustomerReviewCreateOrUpdatePost(input: data).then((_) {
      sendingDialog.hide();

      // Only show message dialog after editing the comment
      if (data.comment != null &&
          data.comment != "" &&
          widget.oldReview.comment != data.comment) {
        showDialog(
            context: context,
            builder: (BuildContext context) => MessageDialog(
                  S.of(context).thankYouAdminWillReviewYourFeedback,
                  duration: Duration(seconds: 1),
                ));
      } else {
        PapricaToast.showToast(S.of(context).successRate);
      }

      widget.onSubmit(jsonData);
      setState(() {
        isSubmitting = false;
        widget.oldReview.restaurantRate = restaurantRate;
        widget.oldReview.foodRate = foodRate;
        widget.oldReview.serviceRate = serviceRate;
        widget.oldReview.shishaRate = shishaRate;
        widget.oldReview.ambianceRate = ambianceRate;
        widget.oldReview.noiseLevel = noiseLevelInt;
        widget.oldReview.comment = commentController.text;
      });

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());

      _initializeFormFields();
    }).catchError((err) {
      sendingDialog.hide();
      setState(() {
        isSubmitting = false;
      });
      PapricaToast.showToast(S.of(context).errorUnknown, ToastType.Error);
    });
  }

  void _initializeFormFields() {
    restaurantRateEdited = false;
    foodRateEdited = false;
    serviceRateEdited = false;
    shishaRateEdited = false;
    ambianceRateEdited = false;
    noiseLevelEdited = false;
    commentEdited = false;

    restaurantRate = (oldReview && null != widget.oldReview.restaurantRate)
        ? widget.oldReview.restaurantRate
        : 0;
    foodRate = (oldReview && null != widget.oldReview.foodRate)
        ? widget.oldReview.foodRate
        : 0;
    serviceRate = (oldReview && null != widget.oldReview.serviceRate)
        ? widget.oldReview.serviceRate
        : 0;
    shishaRate = (oldReview && null != widget.oldReview.shishaRate)
        ? widget.oldReview.shishaRate
        : 0;
    ambianceRate = (oldReview && null != widget.oldReview.ambianceRate)
        ? widget.oldReview.ambianceRate
        : 0;

    noiseLevelInt = (oldReview && null != widget.oldReview.noiseLevel)
        ? widget.oldReview.noiseLevel
        : 0;
  }

  void _onSubmitPressed(context) {
    if (ApiTypesHelper().isAuthorized) {
      if (!isSubmitting) _onSubmitReview();
    } else {
      if (ApiTypesHelper().isAuthorized) {
        _onSubmitReview();
      } else {
        showDialog(
            context: context,
            builder: (_context) {
              return PapricaSimpleDialog(
                title:
                    S.of(context).loggingInRequired(S.of(context).actionReview),
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
                          _onSubmitReview();
                        } else {
                          PapricaToast.showToast(S
                              .of(context)
                              .loggingInRequired(S.of(context).actionReview));
                        }
                      });
                    },
                    child: Text(S.of(context).logIn)),
              );
            });
      }
    }
  }
}
