import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprica/src/erro_handlers/api_error_handler.dart';
import 'package:paprica/src/models/create_delivery_meal_model.dart';
import 'package:paprica/src/models/create_pickup_meal_model.dart';
import 'package:paprica/src/models/delivery_model.dart';
import 'package:paprica/src/models/event_model.dart';
import 'package:paprica/src/models/pickup_model.dart';
import 'package:paprica/src/models/reservation_model.dart';
import 'package:paprica/src/screens/map_screen.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/utils.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../screens.dart';

enum ReservationType { NEW, UPDATE, EVENT }

enum PickupType { NEW, UPDATE }

enum DeliveryType { NEW, UPDATE }

class ReservationDialog extends StatefulWidget {
  final int restaurantId;
  final int maxPeopleAllowed;
  final String restaurantName;

  final ReservationModel oldReservation;

  final EventModel event;

  const ReservationDialog(
      this.restaurantId, this.restaurantName, this.maxPeopleAllowed,
      {this.oldReservation, this.event})
      : assert(event == null || oldReservation == null,
            "You should specify only an event or an old reservation ");

  @override
  ReservationDialogState createState() => ReservationDialogState();
}

class ReservationDialogState extends State<ReservationDialog> {
  int _peopleNumber;
  List<String> occasions;

  DateTime date;

  TextEditingController _customerNameController;
  TextEditingController _phoneNumberController;
  TextEditingController _additionalValueController;

  bool errorPeopleNumber;
  bool errorDate;

  bool error;

  bool reservationSucceeded;

  /// Whether the 'more information' section is shown
  bool _isShownCustomerInfo;

  /// Used when updating an old reservation
  bool isUpdatingReservation = false;

  bool get dataChange {
    if (widget.oldReservation == null) return true;
    return widget.oldReservation.date != date ||
        widget.oldReservation.numberOfPeople != _peopleNumber ||
        widget.oldReservation.personName != _customerNameController.text ||
        widget.oldReservation.phoneNumber != _phoneNumberController.text ||
        widget.oldReservation.moreInfo != _additionalValueController.text;
  }

  @override
  void initState() {
    super.initState();
    _isShownCustomerInfo = false;

    _customerNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _additionalValueController = TextEditingController();
    _customerNameController.text = ApiTypesHelper().customerName;
    _phoneNumberController.text = ApiTypesHelper().phoneNumber;

    errorPeopleNumber = false;
    errorDate = false;

    reservationSucceeded = false;

    if (widget.oldReservation != null) {
      date = widget.oldReservation.date;
      _peopleNumber = widget.oldReservation.numberOfPeople;
      _additionalValueController.text = widget.oldReservation.moreInfo;
    } else if (widget.event != null) {
      date = widget.event.date;
      _peopleNumber = 2;
    } else {
      var now = DateTime.now();
      date = DateTime(now.year, now.month, now.day, now.hour,
          _roundIntegerToNearest15(now.minute, forceCeil: true));
      _peopleNumber = 2;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    error = errorDate;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            widget.event != null
                                ? Text(
                                    S.of(context).reservationDialogHeader(
                                        widget.event.eventName,
                                        widget.restaurantName),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )
                                : EmptyWidget(),
                            this.error
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: _renderValidationSummery())
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      RawMaterialButton(
                                        onPressed: widget.event != null
                                            ? () => PapricaToast.showToast(
                                                S
                                                    .of(context)
                                                    .dateAndTimeCannotBeChanged,
                                                ToastType.Normal)
                                            : () => _showDatePicker(context),
                                        splashColor: Colors.transparent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(S.of(context).date,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(height: 16),
                                            Opacity(
                                              opacity: this.widget.event != null
                                                  ? 0.4
                                                  : 1,
                                              child: SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: Image.asset(
                                                    "assets/icons/date.png"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 7.0),
                                              child: Text(
                                                  PapricaFormatter
                                                      .formatDateOnly(
                                                          context, this.date),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        child: RawMaterialButton(
                                          onPressed: widget.event != null
                                              ? () => PapricaToast.showToast(
                                                  S
                                                      .of(context)
                                                      .dateAndTimeCannotBeChanged,
                                                  ToastType.Normal)
                                              : () => _showTimePicker(context),
                                          splashColor: Colors.transparent,
                                          child: Column(
                                            children: <Widget>[
                                              Text(S.of(context).time,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(height: 16),
                                              Opacity(
                                                opacity:
                                                    this.widget.event != null
                                                        ? 0.4
                                                        : 1,
                                                child: SizedBox(
                                                  width: 32,
                                                  height: 32,
                                                  child: Image.asset(
                                                      "assets/icons/clock.png"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Text(
                                                  PapricaFormatter
                                                      .formatTimeOnly(
                                                          context, this.date),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            _showPeopleNumberPicker(context);
                                          },
                                          splashColor: Colors.transparent,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(S.of(context).people,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(height: 12),
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: Image.asset(
                                                    "assets/icons/user.png"),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF707070)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: Text(_peopleNumber
                                                          .toString()),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF707070),
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xFF707070)),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft: Radius.circular(
                                                                Localizations.localeOf(context)
                                                                            .languageCode ==
                                                                        'en'
                                                                    ? 0
                                                                    : 6),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    Localizations.localeOf(context).languageCode ==
                                                                            'en'
                                                                        ? 0
                                                                        : 6),
                                                            topRight: Radius.circular(
                                                                Localizations.localeOf(context)
                                                                            .languageCode ==
                                                                        'en'
                                                                    ? 6
                                                                    : 0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    Localizations.localeOf(context).languageCode ==
                                                                            'en'
                                                                        ? 6
                                                                        : 0),
                                                          )),
                                                      child: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),

                            /// Customer Information
                            Column(
                              children: <Widget>[
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      _isShownCustomerInfo =
                                          !_isShownCustomerInfo;
                                    });
                                  },
                                  child: Card(
                                    elevation: 0,
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(3),
                                            topRight: Radius.circular(3))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            S.of(context).moreInformation,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          _isShownCustomerInfo
                                              ? Icon(Icons.keyboard_arrow_up)
                                              : Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                _isShownCustomerInfo
                                    ? AnimatedContainer(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Card(
                                                elevation: 0,
                                                margin: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(3),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    3))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .customerName,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      TextFormField(
                                                        controller:
                                                            _customerNameController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xFFF2F2F2),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          8),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFaa757f)),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    const Radius
                                                                            .circular(
                                                                        3.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .phoneNumber,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      TextFormField(
                                                        controller:
                                                            _phoneNumberController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        textAlign: Localizations
                                                                        .localeOf(
                                                                            context)
                                                                    .languageCode ==
                                                                "en"
                                                            ? TextAlign.left
                                                            : TextAlign.right,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xFFF2F2F2),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          8),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFaa757f)),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    const Radius
                                                                            .circular(
                                                                        3.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        24),
                                                            child: SizedBox(
                                                              width: 32,
                                                              height: 32,
                                                              child: Image.asset(
                                                                  "assets/icons/comment.png"),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  S
                                                                      .of(context)
                                                                      .notes,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      _additionalValueController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .done,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Color(
                                                                            0xFFF2F2F2),
                                                                    contentPadding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            12),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.white)),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Color(0xFFaa757f)),
                                                                      borderRadius: const BorderRadius
                                                                          .all(const Radius
                                                                              .circular(
                                                                          3.0)),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        curve: Curves.easeInOut,
                                        duration: const Duration(seconds: 1),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Spacer(),
                                CustomizedActiveButton(
                                  onPressed: isUpdatingReservation ||
                                          !dataChange ||
                                          error
                                      ? null
                                      : () => _onReserveClicked(context),
                                  title: _getReservationText(context),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: DialogCloseButton(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderValidationSummery() {
    var text = S.of(context).errorReservationValidation;
    if (DateTime.now().isAfter(date))
      text = S.of(context).reservationTimeShouldBeInTheFuture;

    return Text(text,
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14));
  }

  void _showPeopleNumberPicker(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              begin: 1,
              end: widget.maxPeopleAllowed ?? 24,
              initValue: _peopleNumber ?? 1),
        ]),
        looping: true,
        hideHeader: true,
        itemExtent: 50,
        title: Text(S.of(context).numberOfPeople),
        cancelText: S.of(context).cancelOrder.toUpperCase(),
        confirmText: S.of(context).okay.toUpperCase(),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _peopleNumber = picker.getSelectedValues()[0];
            if (_peopleNumber > 0) this.errorPeopleNumber = false;
          });

          // Dismiss keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        }).showDialog(context);
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: date.isAfter(DateTime.now()) ? date : DateTime.now(),
      lastDate: DateTime(date.year + 2),
    ).then((pickerDate) {
      if (pickerDate != null) {
        setState(() {
          date = DateTime(pickerDate.year, pickerDate.month, pickerDate.day,
              date.hour, date.minute, date.second);
          this.errorDate = errorDate = date.isBefore(DateTime.now());
        });
      }

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  void _showTimePicker(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(date))
        .then((pickerDate) {
      if (pickerDate != null) {
        setState(() {
          var selectedDateTime = DateTime(date.year, date.month, date.day,
              pickerDate.hour, pickerDate.minute);
          var roundedDateTime = _roundToNearest15Mins(selectedDateTime);
          date = roundedDateTime;
          if (selectedDateTime != roundedDateTime)
            PapricaToast.showToast(
                S.of(context).timeHasBeenRoundedToTheNearest15Minutes,
                ToastType.Normal);
          this.errorDate = errorDate = date.isBefore(DateTime.now());
        });
      }

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  DateTime _roundToNearest15Mins(DateTime value) {
    return DateTime(value.year, value.month, value.day, value.hour,
        _roundIntegerToNearest15(value.minute));
  }

  int _roundIntegerToNearest15(int value, {forceCeil = false}) {
    var overflowBy = value % 15;
    if (overflowBy != 0) {
      if (forceCeil || overflowBy > 7)
        value = ((value / 15).floor() + 1) * 15;
      else
        value = (value / 15).round() * 15;
    }
    return value;
  }

  void _onReserveClicked(BuildContext context) {
    if (ApiTypesHelper().isPhoneNumberConfirmed) {
      if (DateTime.now().isAfter(date) || DateTime.now() == date) {
        setState(() {
          errorDate = true;
        });
      } else {
        if (_reservationType() == ReservationType.NEW) {
          _showReservationConfirmationDialog(context);
        } else {
          _sendUpdateRequest(context);
        }
      }
    } else {
      _handleUnconfirmedPhoneNumber(context);
    }
  }

  void _showReservationConfirmationDialog(BuildContext context) {
    showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return ReservationConfirmationDialog(
                restaurantName: widget.restaurantName,
                count: _peopleNumber,
                date: date,
                restaurantId: widget.restaurantId,
                customerName: _customerNameController.text,
                phoneNumber: _phoneNumberController.text,
                additionalInformation: _additionalValueController.text,
              );
            },
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.white54,
            transitionDuration: const Duration(milliseconds: 150))
        .then((ok) {
      if (ok != null && ok) {
        Navigator.of(context).pop(ReservationModel(
            date: date,
            moreInfo: _additionalValueController.text,
            numberOfPeople: _peopleNumber));
      }

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  ReservationType _reservationType() {
    if (widget.oldReservation != null) {
      return ReservationType.UPDATE;
    }
    return ReservationType.NEW;
  }

  String _getReservationText(BuildContext context) {
    if (_reservationType() == ReservationType.NEW) {
      return S.of(context).reserve;
    } else {
      return S.of(context).update;
    }
  }

  void _sendUpdateRequest(BuildContext context) {
    setState(() {
      isUpdatingReservation = true;
    });
    ApiClient client = PapricaApiClient();
    var reservationApi = CustomerReservationApi(client);

    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).updatingReservation);
    dialog.show();
    UpdateReservationDto model = UpdateReservationDto.fromJson({
      'restaurantId': widget.restaurantId,
      'numberOfPeople': _peopleNumber,
      'time': date.toString(),
      'date': date.toString(),
      'customerAdditionalInfo': _additionalValueController.text,
      'id': widget.oldReservation.id,
      'personName': _customerNameController.text
    });
    reservationApi
        .apiServicesAppCustomerReservationUpdateReservationPost(input: model)
        .then((message) {
      dialog.hide();
      setState(() {
        isUpdatingReservation = false;
      });
      Navigator.of(context).pop(ReservationModel(
          date: date,
          moreInfo: _additionalValueController.text,
          numberOfPeople: _peopleNumber,
          personName: _customerNameController.text,
          phoneNumber: _phoneNumberController.text));

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    }).catchError((error) {
      dialog.hide();
      setState(() {
        isUpdatingReservation = false;
      });
      DefaultErrorHandler.handle(context, error);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}

void _handleUnconfirmedPhoneNumber(BuildContext context) {
  showDialog(
      context: context,
      builder: (_context) {
        return PaprikaSimpleDialog(
          title: S.of(context).phoneNumberConfirmationNeeded,
          yesButton: FlatButton(
              onPressed: () {
                Navigator.of(_context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ConfirmPhoneNumberScreen();
                })).then((confirmed) {
                  if (confirmed != null && confirmed) {
                    ApiTypesHelper().setIsPhoneNumberConfirmed(true);
                  }
                });
              },
              child: Text(S.of(context).ok)),
        );
      });
}

/// ReservationConfirmationDialog has to be stateful widget in order to be able to change its state
///  With a stateful widget we can print error messages
///  and show [CircularProgressIndicator] when request is being made
class ReservationConfirmationDialog extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final int count;
  final DateTime date;
  final String customerName;
  final String phoneNumber;
  final String occasion;
  final String additionalInformation;

  const ReservationConfirmationDialog(
      {@required this.restaurantName,
      @required this.count,
      @required this.date,
      this.phoneNumber,
      this.customerName,
      this.additionalInformation,
      this.occasion,
      this.restaurantId});

  @override
  _ReservationConfirmationDialogState createState() =>
      _ReservationConfirmationDialogState();
}

class _ReservationConfirmationDialogState
    extends State<ReservationConfirmationDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).confirmReservation,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        S.of(context).reservationSummary(
              widget.restaurantName,
              widget.count.toString(),
              widget.count <= 1 ? S.of(context).person : S.of(context).people,
              PapricaFormatter.formatDateOnly(context, widget.date),
              PapricaFormatter.formatTimeOnly(context, widget.date),
            ),
      ),
      actions: <Widget>[
        CustomizedInactiveButton(
          title: S.of(context).cancel,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CustomizedActiveButton(
          title: S.of(context).confirm,
          onPressed: () => _createReservation(context),
        )
      ],
    );
  }

  void _createReservation(BuildContext context) {
    ApiClient client = PapricaApiClient();
    var reservationApi = CustomerReservationApi(client);

    CreateReservationDto model = CreateReservationDto.fromJson({
      'restaurantId': widget.restaurantId,
      'numberOfPeople': widget.count,
      'time': widget.date.toString(),
      'date': widget.date.toString(),
      'customerAdditionalInfo': widget.additionalInformation,
      'phoneNumber': widget.phoneNumber,
      'personName': widget.customerName
    });
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).creatingReservation);
    dialog.show();
    reservationApi
        .apiServicesAppCustomerReservationCreateReservationPost(input: model)
        .then((message) {
      dialog.hide();
      Navigator.of(context).pop(true);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    }).catchError((error) {
      dialog.hide();
      DefaultErrorHandler.handle(context, error);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}

class DialogCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => Navigator.pop(context),
      fillColor: Colors.white30,
      child: Icon(
        Icons.close,
        color: Colors.white70,
        size: 24.0,
      ),
      shape: CircleBorder(side: BorderSide(color: Colors.white30)),
      elevation: 2.0,
      padding: const EdgeInsets.all(5.0),
    );
  }
}

class MessageDialog extends StatefulWidget {
  final String message;
  final Duration duration;
  final Widget footer;

  const MessageDialog(this.message, {this.duration, this.footer});

  @override
  State<StatefulWidget> createState() => MessageDialogState();
}

class MessageDialogState extends State<MessageDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration != null
          ? widget.duration
          : Duration(milliseconds: 450),
    );
    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Container(
              height: widget.footer == null ? 100 : 116,
              width: MediaQuery.of(context).size.width * .9,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 8),
                              child: Text(
                                widget.message,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            null == widget.footer ? EmptyWidget() : Spacer(),
                            null == widget.footer
                                ? EmptyWidget()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      EmptyWidget(),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 0, 30, 16),
                                        child: widget.footer,
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? 0
                              : null,
                      top: 0,
                      child: Container(
                        transform: Matrix4.translationValues(0.0, -20, 0.0),
                        child: RawMaterialButton(
                          onPressed: () => Navigator.pop(context),
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            color: Colors.black38,
                            size: 20.0,
                          ),
                          constraints: BoxConstraints(
                            minHeight: 24,
                            minWidth: 24,
                          ),
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white30)),
                          elevation: 2.0,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaprikaSimpleDialog extends StatelessWidget {
  final String title, content;
  final Widget yesButton, noButton;

//  final GestureTapCallback onYesPressed;

  const PaprikaSimpleDialog({
    @required this.title,
    this.content,
    this.yesButton,
    this.noButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title ?? S.of(context).confirm,
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.subhead),
      content: this.content != null ? Text(this.content) : null,
      actions: <Widget>[
        this.noButton ??
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.of(context).cancel,
                    style: TextStyle(color: Colors.grey))),
        this.yesButton ??
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(S.of(context).confirm),
            ),
      ],
    );
  }
}

String _dialogMessage = "Loading...";

bool _isShowing = false;

class ProgressDialog {
  _ProgressDialog _dialog;

  BuildContext _buildContext;
  BuildContext _context;

  ProgressDialog(BuildContext buildContext) {
    _buildContext = buildContext;
  }

  void setMessage(String mess) {
    _dialogMessage = mess;
  }

  bool isShowing() {
    return _isShowing;
  }

  void hide() {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(_buildContext).pop();
    }
  }

  void show() {
    if (!_isShowing) {
      _dialog = _ProgressDialog();
      _isShowing = true;
      showDialog<dynamic>(
        context: _buildContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _context = context;
          return Dialog(
              insetAnimationCurve: Curves.easeInOut,
              insetAnimationDuration: Duration(milliseconds: 100),
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: _dialog);
        },
      );
    }
  }
}

class _ProgressDialog extends StatefulWidget {
  @override
// ignore: must_be_immutable
  State<StatefulWidget> createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<_ProgressDialog> {
  @override
  void dispose() {
    super.dispose();
    _isShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.0,
        child: Row(children: <Widget>[
          const SizedBox(width: 15.0),
          SizedBox(
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Text(_dialogMessage,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500)),
          )
        ]));
  }
}

class CallRestaurantDialog extends StatelessWidget {
  final String restaurantName;

  final String phoneNumber;

  const CallRestaurantDialog(
      {Key key, this.restaurantName, @required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Text(
              S.of(context).callRestaurant(this.restaurantName != null
                  ? this.restaurantName
                  : this.phoneNumber),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )),
      actions: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? 16
                              : 24,
                      vertical: 3),
                  child: Text(
                    S.of(context).no,
                    style: TextStyle(),
                  ),
                ),
              ),
            )),
        GestureDetector(
            onTap: () {
              UrlLauncher.launch('tel://' + this.phoneNumber);
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? 16
                            : 24,
                    vertical: 4),
                child: Text(
                  S.of(context).yes,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class PaprikaErrorDialog extends StatelessWidget {
  final String title, content;
  final Widget extraButton;
  final VoidCallback actionHandler;

  const PaprikaErrorDialog(
      {@required this.title,
      this.content,
      this.extraButton,
      this.actionHandler});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title ?? S.of(context).error),
      content: this.content != null ? Text(this.content) : null,
      actions: <Widget>[
        this.extraButton ?? Container(),
        FlatButton(
          onPressed: () => this.actionHandler != null
              ? this.actionHandler()
              : Navigator.of(context).pop(),
          child: Text(S.of(context).ok),
        ),
      ],
    );
  }
}

typedef StringCallback(String str);

class PaprikaInputDialog extends StatelessWidget {
  final String title;
  final String content;
  final StringCallback confirmCallback;
  final TextEditingController _cancelReasonController;
  final String cancelText;
  final String confirmText;

  PaprikaInputDialog(
      {this.title,
      this.content,
      this.confirmCallback,
      this.cancelText,
      this.confirmText})
      : _cancelReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title == null ? null : Text(title),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            content != null ? Text(content) : Container(),
            TextFormField(
              maxLines: 5,
              minLines: 1,
              maxLength: 124,
              textAlign: Localizations.localeOf(context).languageCode == 'en'
                  ? TextAlign.left
                  : TextAlign.right,
              controller: _cancelReasonController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                hintText: S.of(context).cancelReason,
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(cancelText ?? S.of(context).cancel,
              style: TextStyle(color: Colors.grey)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        FlatButton(
          child: Text(confirmText ?? S.of(context).confirm),
          onPressed: () {
            if (confirmCallback != null && confirmCallback is StringCallback)
              confirmCallback(_cancelReasonController.text);
          },
        )
      ],
    );
  }
}

/// Pickup

class PickupDialog extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final List<CreatePickupMealModel> meals;
  final PickupModel oldPickup;

  const PickupDialog(
      {Key key,
      this.restaurantId,
      this.restaurantName,
      this.meals,
      this.oldPickup})
      : super(key: key);

  @override
  PickupDialogState createState() => PickupDialogState();
}

class PickupDialogState extends State<PickupDialog> {
  DateTime date;

  TextEditingController _customerNameController;
  TextEditingController _phoneNumberController;

  bool errorDate;

  bool error;

  bool pickupSucceeded;

  /// Whether the 'more information' section is shown
  bool _isShownCustomerInfo;

  /// Used when updating an old reservation
  bool isUpdatingPickup = false;

  List<Object> _meals = [];

  bool get dataChange {
    if (widget.oldPickup == null) return true;
    return widget.oldPickup.date != date;
  }

  @override
  void initState() {
    super.initState();
    _isShownCustomerInfo = false;

    _customerNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _customerNameController.text = ApiTypesHelper().customerName;
    _phoneNumberController.text = ApiTypesHelper().phoneNumber;

    errorDate = false;

    pickupSucceeded = false;

    if (widget.oldPickup != null) {
      date = widget.oldPickup.date;
    } else {
      var now = DateTime.now();
      date = DateTime(now.year, now.month, now.day, now.hour,
          _roundIntegerToNearest15(now.minute, forceCeil: true));
    }

    for (var i in widget.meals) {
      _meals.add(i.toJson());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    error = errorDate;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            this.error
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: _renderValidationSummery())
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      RawMaterialButton(
                                        onPressed: () =>
                                            _showDatePicker(context),
                                        splashColor: Colors.transparent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(S.of(context).date,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(height: 16),
                                            Opacity(
                                              opacity: 1,
                                              child: SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: Image.asset(
                                                    "assets/icons/date.png"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 7.0),
                                              child: Text(
                                                  PapricaFormatter
                                                      .formatDateOnly(
                                                          context, this.date),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        child: RawMaterialButton(
                                          onPressed: () =>
                                              _showTimePicker(context),
                                          splashColor: Colors.transparent,
                                          child: Column(
                                            children: <Widget>[
                                              Text(S.of(context).time,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(height: 16),
                                              Opacity(
                                                opacity: 1,
                                                child: SizedBox(
                                                  width: 32,
                                                  height: 32,
                                                  child: Image.asset(
                                                      "assets/icons/clock.png"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Text(
                                                  PapricaFormatter
                                                      .formatTimeOnly(
                                                          context, this.date),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),

                            /// Customer Information
                            Column(
                              children: <Widget>[
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      _isShownCustomerInfo =
                                          !_isShownCustomerInfo;
                                    });
                                  },
                                  child: Card(
                                    elevation: 0,
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(3),
                                            topRight: Radius.circular(3))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            S.of(context).moreInformation,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          _isShownCustomerInfo
                                              ? Icon(Icons.keyboard_arrow_up)
                                              : Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                _isShownCustomerInfo
                                    ? AnimatedContainer(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Card(
                                                elevation: 0,
                                                margin: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(3),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    3))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .customerName,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      TextFormField(
                                                        controller:
                                                            _customerNameController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xFFF2F2F2),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          8),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFaa757f)),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    const Radius
                                                                            .circular(
                                                                        3.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .phoneNumber,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      TextFormField(
                                                        controller:
                                                            _phoneNumberController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        textAlign: Localizations
                                                                        .localeOf(
                                                                            context)
                                                                    .languageCode ==
                                                                "en"
                                                            ? TextAlign.left
                                                            : TextAlign.right,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xFFF2F2F2),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          8),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFaa757f)),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    const Radius
                                                                            .circular(
                                                                        3.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        curve: Curves.easeInOut,
                                        duration: const Duration(seconds: 1),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Spacer(),
                                CustomizedActiveButton(
                                  onPressed:
                                      isUpdatingPickup || !dataChange || error
                                          ? null
                                          : () => _onSubmitClicked(context),
                                  title: _getPickupText(context),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: DialogCloseButton(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderValidationSummery() {
    var text = S.of(context).errorPickupValidation;
    if (DateTime.now().isAfter(date))
      text = S.of(context).pickupTimeShouldBeInTheFuture;

    return Text(text,
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14));
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: date.isAfter(DateTime.now()) ? date : DateTime.now(),
      lastDate: DateTime(date.year + 2),
    ).then((pickerDate) {
      if (pickerDate != null) {
        setState(() {
          date = DateTime(pickerDate.year, pickerDate.month, pickerDate.day,
              date.hour, date.minute, date.second);
          this.errorDate = errorDate = date.isBefore(DateTime.now());
        });
      }

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  void _showTimePicker(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(date))
        .then((pickerDate) {
      if (pickerDate != null) {
        setState(() {
          var selectedDateTime = DateTime(date.year, date.month, date.day,
              pickerDate.hour, pickerDate.minute);
          var roundedDateTime = _roundToNearest15Mins(selectedDateTime);
          date = roundedDateTime;
          if (selectedDateTime != roundedDateTime)
            PapricaToast.showToast(
                S.of(context).timeHasBeenRoundedToTheNearest15Minutes,
                ToastType.Normal);
          this.errorDate = errorDate = date.isBefore(DateTime.now());
        });
      }

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  DateTime _roundToNearest15Mins(DateTime value) {
    return DateTime(value.year, value.month, value.day, value.hour,
        _roundIntegerToNearest15(value.minute));
  }

  int _roundIntegerToNearest15(int value, {forceCeil = false}) {
    var overflowBy = value % 15;
    if (overflowBy != 0) {
      if (forceCeil || overflowBy > 7)
        value = ((value / 15).floor() + 1) * 15;
      else
        value = (value / 15).round() * 15;
    }
    return value;
  }

  void _onSubmitClicked(BuildContext context) {
    if (ApiTypesHelper().isPhoneNumberConfirmed) {
      if (DateTime.now().isAfter(date) || DateTime.now() == date) {
        setState(() {
          errorDate = true;
        });
      } else {
        if (_pickupType() == PickupType.NEW) {
          _showPickupConfirmationDialog(context);
        } else {
          _sendUpdateRequest(context);
        }
      }
    } else {
      _handleUnconfirmedPhoneNumber(context);
    }
  }

  void _showPickupConfirmationDialog(BuildContext context) {
    showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return PickupConfirmationDialog(
                widget.restaurantId,
                widget.restaurantName,
                date,
                widget.meals,
              );
            },
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.white54,
            transitionDuration: const Duration(milliseconds: 150))
        .then((ok) {
      if (ok != null && ok) {
        Navigator.of(context).pop(PickupModel(
          date: date,
          createPickupMeals: widget.meals,
        ));
      }
      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  PickupType _pickupType() {
    if (widget.oldPickup != null) {
      return PickupType.UPDATE;
    }
    return PickupType.NEW;
  }

  String _getPickupText(BuildContext context) {
    if (_pickupType() == PickupType.NEW) {
      return S.of(context).submit;
    } else {
      return S.of(context).update;
    }
  }

  void _sendUpdateRequest(BuildContext context) {
    setState(() {
      isUpdatingPickup = true;
    });
    ApiClient client = PapricaApiClient();
    var pickupApi = CustomerPickupApi(client);

    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).updatingPickup);
    dialog.show();
    UpdatePickupDto model = UpdatePickupDto.fromJson({
      'id': widget.oldPickup.id,
      'time': date.toString(),
      'pickupMeals': _meals,
    });
    pickupApi
        .apiServicesAppCustomerPickupUpdatePickupPost(input: model)
        .then((message) {
      dialog.hide();
      setState(() {
        isUpdatingPickup = false;
      });
      Navigator.of(context).pop(PickupModel(
        date: date,
        createPickupMeals: widget.meals,
      ));
      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    }).catchError((error) {
      dialog.hide();
      setState(() {
        isUpdatingPickup = false;
      });
      DefaultErrorHandler.handle(context, error);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}

class PickupConfirmationDialog extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final DateTime date;
  final List<CreatePickupMealModel> meals;

  const PickupConfirmationDialog(
      this.restaurantId, this.restaurantName, this.date, this.meals);

  @override
  _PickupConfirmationDialogState createState() =>
      _PickupConfirmationDialogState();
}

class _PickupConfirmationDialogState extends State<PickupConfirmationDialog> {
  List<Object> _meals = [];

  @override
  void initState() {
    for (var i in widget.meals) {
      _meals.add(i.toJson());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).confirmPickup,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        S.of(context).pickupSummary(
              widget.restaurantName,
              PapricaFormatter.formatDateOnly(context, widget.date),
              PapricaFormatter.formatTimeOnly(context, widget.date),
            ),
      ),
      actions: <Widget>[
        CustomizedInactiveButton(
          title: S.of(context).cancel,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CustomizedActiveButton(
          title: S.of(context).confirm,
          onPressed: () => _createPickup(context),
        )
      ],
    );
  }

  void _createPickup(BuildContext context) {
    ApiClient client = PapricaApiClient();
    var pickupApi = CustomerPickupApi(client);

    CreatePickupDto model = CreatePickupDto.fromJson({
      'restaurantId': widget.restaurantId,
      'time': widget.date.toString(),
      'pickupMeals': _meals,
    });
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).creatingPickup);
    dialog.show();
    pickupApi
        .apiServicesAppCustomerPickupCreatePickupPost(input: model)
        .then((message) {
      dialog.hide();
      Navigator.of(context).pop(true);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    }).catchError((error) {
      dialog.hide();
      DefaultErrorHandler.handle(context, error);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}

/// Delivery

class DeliveryDialog extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final double restaurantLatitude;
  final double restaurantLongitude;
  final List<CreateDeliveryMealModel> meals;
  final DeliveryModel oldDelivery;

  const DeliveryDialog(
      {Key key,
      this.restaurantId,
      this.restaurantName,
      this.restaurantLatitude,
      this.restaurantLongitude,
      this.meals,
      this.oldDelivery})
      : super(key: key);

  @override
  DeliveryDialogState createState() => DeliveryDialogState();
}

class DeliveryDialogState extends State<DeliveryDialog> {
  Future<DeliveryRegionsDto> futureDeliveryRegions;
  List<DropdownMenuItem<DeliveryRegion>> _dropdownMenuItems;
  List<DeliveryRegion> deliveryRegions = [];
  DeliveryRegion selectedDeliveryRegion;
  DeliveryRegion _selectedDeliveryRegion;
  bool firstTime;

  double _longitude;
  double _latitude;
  String _address;
  bool _addressIsExist;
  int _indexOfAddress;

  TextEditingController _customerNameController;
  TextEditingController _phoneNumberController;

  bool error = false;

  GoogleMapController mapController;
  List<Marker> myMarkers = List<Marker>();

  bool deliverySucceeded;

  /// Whether the 'more information' section is shown
  bool _isShownCustomerInfo;

  /// Used when updating an old reservation
  bool isUpdatingDelivery = false;

  List<Object> _meals = [];

  bool get dataChange {
    if (widget.oldDelivery == null) return true;
    return widget.oldDelivery.customerLatitude != _latitude ||
        widget.oldDelivery.customerLongitude != _longitude ||
        widget.oldDelivery.customerAddress != _address;
  }

  @override
  void initState() {
    super.initState();
    _getDeliveryRegionsAsync();

    _isShownCustomerInfo = false;

    deliveryRegions.clear();
    firstTime = true;
    myMarkers.add(Marker(
        markerId: MarkerId(widget.restaurantName),
        infoWindow: InfoWindow(title: widget.restaurantName),
        position:
            LatLng(widget.restaurantLatitude, widget.restaurantLongitude)));
    if (widget.oldDelivery != null) {
      if (widget.oldDelivery.customerLatitude != null &&
          widget.oldDelivery.customerLongitude != null) {
        myMarkers.add(Marker(
            markerId: MarkerId("your location"),
            infoWindow: InfoWindow(title: "your location"),
            position: LatLng(widget.oldDelivery.customerLatitude,
                widget.oldDelivery.customerLongitude)));
      }
    }

    _customerNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _customerNameController.text = ApiTypesHelper().customerName;
    _phoneNumberController.text = ApiTypesHelper().phoneNumber;

    deliverySucceeded = false;
    _addressIsExist = false;
    _indexOfAddress = null;

    if (widget.oldDelivery != null) {
      _latitude = widget.oldDelivery.customerLatitude;
      _longitude = widget.oldDelivery.customerLongitude;
      _address = widget.oldDelivery.customerAddress;
    } else {
      _latitude = null;
      _longitude = null;
      _address = null;
    }

    for (var i in widget.meals) {
      _meals.add(i.toJson());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<DeliveryRegion>> buildDropdownMenuItem(List regions) {
    List<DropdownMenuItem<DeliveryRegion>> items = List();
    for (DeliveryRegion deliveryRegion in regions) {
      items.add(
        DropdownMenuItem(
          value: deliveryRegion,
          child: Container(
            padding:
                EdgeInsets.only(left: 20.0, top: 5.0, right: 20.0, bottom: 5.0),
            child: Text(
              deliveryRegion.name,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(DeliveryRegion selectedDeliveryRegion) {
    setState(() {
      _selectedDeliveryRegion = selectedDeliveryRegion;
      _address = selectedDeliveryRegion.name;
    });
  }

  Future _getDeliveryRegionsAsync() {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = new CustomerRestaurantApi(apiClient);
    setState(() {
      futureDeliveryRegions = apiInstance
          .apiServicesAppCustomerRestaurantGetRestaurantDeliveryRegionsGet(
              id: widget.restaurantId);
    });
    return futureDeliveryRegions.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  Future<Widget> _getMapWidget() {
    return Future<Widget>.delayed(Duration(milliseconds: 500), () {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          child: GoogleMap(
            onTap: (latLog) {
              _selectOnMap();
            },
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.from(myMarkers),
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.restaurantLatitude, widget.restaurantLongitude),
              zoom: 10.0,
            ),
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: false,
            zoomGesturesEnabled: true,
          ),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _selectOnMap() async {
    final _selectedLocation = await Navigator.of(context)
        .push<LatLng>(_latitude == null || _longitude == null
            ? MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  resLatitude: widget.restaurantLatitude,
                  resLongitude: widget.restaurantLongitude,
                  isSelecting: false,
                ),
              )
            : MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  initialLatitude: _latitude,
                  initialLongitude: _longitude,
                  resLatitude: widget.restaurantLatitude,
                  resLongitude: widget.restaurantLongitude,
                  isSelecting: true,
                ),
              ));
    if (_selectedLocation != null) {
      setState(() {
        _latitude = _selectedLocation.latitude;
        _longitude = _selectedLocation.longitude;
        if (myMarkers.length >= 2) {
          myMarkers.removeLast();
        }
        myMarkers.add(Marker(
            markerId: MarkerId("your location"),
            infoWindow: InfoWindow(title: "your location"),
            position: LatLng(_latitude, _longitude)));
      });
    } else {
      return;
    }
  }

  DeliveryType _deliveryType() {
    if (widget.oldDelivery != null) {
      return DeliveryType.UPDATE;
    }
    return DeliveryType.NEW;
  }

  String _getDeliveryText(BuildContext context) {
    if (_deliveryType() == DeliveryType.NEW) {
      return S.of(context).submit;
    } else {
      return S.of(context).update;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    S.of(context).address,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                FutureBuilder(
                                  future: futureDeliveryRegions,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (firstTime) {
                                        for (var i
                                            in snapshot.data.deliveryRegions) {
                                          deliveryRegions.add(
                                              DeliveryRegion(i.name, i.id));
                                          if (_address == i.name) {
                                            _addressIsExist = true;
                                            _indexOfAddress = i.id;
                                          }
                                        }
                                        _dropdownMenuItems =
                                            buildDropdownMenuItem(
                                                deliveryRegions);
                                        if (!_addressIsExist) {
                                          _selectedDeliveryRegion =
                                              _dropdownMenuItems[0].value;
                                        } else {
                                          _selectedDeliveryRegion =
                                              _dropdownMenuItems[
                                                      _indexOfAddress - 1]
                                                  .value;
                                        }
                                        firstTime = false;
                                      }
                                      return snapshot.data.deliveryRegions
                                                  .length <=
                                              0
                                          ? Center(
                                              child: Text(S
                                                  .of(context)
                                                  .thereAreNoDeliveryRegions))
                                          : DropdownButton(
                                              value: _selectedDeliveryRegion,
                                              items: _dropdownMenuItems,
                                              onChanged: onChangeDropdownItem,
                                            );
                                    } else {
                                      return Center(
                                          child: Text(S
                                              .of(context)
                                              .loadingDeliveryRegions));
                                    }
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: RawMaterialButton(
                                onPressed: () {},
                                splashColor: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        S.of(context).yourLocation +
                                            " " +
                                            S.of(context).and +
                                            " " +
                                            S.of(context).restaurantsLocation +
                                            " " +
                                            S.of(context).onMap,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 16),
                                    FutureBuilder(
                                      future: _getMapWidget(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return snapshot.data;
                                        } else {
                                          return Center(
                                              child: Text(S
                                                  .of(context)
                                                  .loadingLocation));
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            /// Customer Information
                            Column(
                              children: <Widget>[
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      _isShownCustomerInfo =
                                          !_isShownCustomerInfo;
                                    });
                                  },
                                  child: Card(
                                    elevation: 0,
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(3),
                                            topRight: Radius.circular(3))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            S.of(context).moreInformation,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          _isShownCustomerInfo
                                              ? Icon(Icons.keyboard_arrow_up)
                                              : Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                _isShownCustomerInfo
                                    ? AnimatedContainer(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Card(
                                                elevation: 0,
                                                margin: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(3),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    3))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .customerName,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      TextFormField(
                                                        controller:
                                                            _customerNameController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xFFF2F2F2),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          8),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFaa757f)),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    const Radius
                                                                            .circular(
                                                                        3.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .phoneNumber,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      TextFormField(
                                                        controller:
                                                            _phoneNumberController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        textAlign: Localizations
                                                                        .localeOf(
                                                                            context)
                                                                    .languageCode ==
                                                                "en"
                                                            ? TextAlign.left
                                                            : TextAlign.right,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xFFF2F2F2),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          8),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFaa757f)),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    const Radius
                                                                            .circular(
                                                                        3.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        curve: Curves.easeInOut,
                                        duration: const Duration(seconds: 1),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Spacer(),
                                CustomizedActiveButton(
                                  onPressed:
                                      isUpdatingDelivery || !dataChange || error
                                          ? null
                                          : () => _onSubmitClicked(context),
                                  title: _getDeliveryText(context),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: DialogCloseButton(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitClicked(BuildContext context) {
    if (ApiTypesHelper().isPhoneNumberConfirmed) {
      if (_deliveryType() == DeliveryType.NEW) {
        _showDeliveryConfirmationDialog(context);
      } else {
        _sendUpdateRequest(context);
      }
    } else {
      _handleUnconfirmedPhoneNumber(context);
    }
  }

  void _showDeliveryConfirmationDialog(BuildContext context) {
    showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return DeliveryConfirmationDialog(
                widget.restaurantId,
                widget.restaurantName,
                _longitude,
                _latitude,
                _selectedDeliveryRegion.name,
                _selectedDeliveryRegion.id,
                widget.meals,
              );
            },
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.white54,
            transitionDuration: const Duration(milliseconds: 150))
        .then((ok) {
      if (ok != null && ok) {
        Navigator.of(context).pop(true);
      }
      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  void _sendUpdateRequest(BuildContext context) {
    setState(() {
      isUpdatingDelivery = true;
    });
    ApiClient client = PapricaApiClient();
    var deliveryApi = CustomerDeliveryApi(client);

    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).updatingDelivery);
    dialog.show();
    UpdateDeliveryDto model = UpdateDeliveryDto.fromJson({
      'id': widget.oldDelivery.id,
      'longitude': _longitude,
      'latitude': _latitude,
      'address': _selectedDeliveryRegion.name,
      'regionId': _selectedDeliveryRegion.id,
      'deliveryMeals': _meals,
    });
    deliveryApi
        .apiServicesAppCustomerDeliveryUpdateDeliveryPost(input: model)
        .then((message) {
      dialog.hide();
      setState(() {
        isUpdatingDelivery = false;
      });
      Navigator.of(context).pop(true);
      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    }).catchError((error) {
      dialog.hide();
      setState(() {
        isUpdatingDelivery = false;
      });
      DefaultErrorHandler.handle(context, error);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}

class DeliveryConfirmationDialog extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final double longitude;
  final double latitude;
  final String address;
  final int regionId;
  final List<CreateDeliveryMealModel> meals;

  const DeliveryConfirmationDialog(this.restaurantId, this.restaurantName,
      this.longitude, this.latitude, this.address, this.regionId, this.meals);

  @override
  _DeliveryConfirmationDialogState createState() =>
      _DeliveryConfirmationDialogState();
}

class _DeliveryConfirmationDialogState
    extends State<DeliveryConfirmationDialog> {
  List<Object> _meals = [];

  @override
  void initState() {
    for (var i in widget.meals) {
      _meals.add(i.toJson());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).confirmDelivery,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        S.of(context).deliverySummary(
              widget.restaurantName,
            ),
      ),
      actions: <Widget>[
        CustomizedInactiveButton(
          title: S.of(context).cancel,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CustomizedActiveButton(
          title: S.of(context).confirm,
          onPressed: () => _createDelivery(context),
        )
      ],
    );
  }

  void _createDelivery(BuildContext context) {
    ApiClient client = PapricaApiClient();
    var deliveryApi = CustomerDeliveryApi(client);

    CreateDeliveryDto model = CreateDeliveryDto.fromJson({
      'restaurantId': widget.restaurantId,
      'longitude': widget.longitude,
      'latitude': widget.latitude,
      'address': widget.address,
      'regionId': widget.regionId,
      'deliveryMeals': _meals,
    });
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).creatingDelivery);
    dialog.show();
    deliveryApi
        .apiServicesAppCustomerDeliveryCreateDeliveryPost(input: model)
        .then((message) {
      dialog.hide();
      Navigator.of(context).pop(true);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    }).catchError((error) {
      dialog.hide();
      DefaultErrorHandler.handle(context, error);

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}

class DeliveryRegion {
  int id;
  String name;

  DeliveryRegion(this.name, this.id);
}
