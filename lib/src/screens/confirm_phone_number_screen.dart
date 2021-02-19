import 'package:flutter/material.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';

class ConfirmPhoneNumberScreen extends StatefulWidget {
  final String phoneNumber;

  const ConfirmPhoneNumberScreen({Key key, this.phoneNumber}) : super(key: key);

  @override
  _ConfirmPhoneNumberScreenState createState() =>
      _ConfirmPhoneNumberScreenState();
}

class _ConfirmPhoneNumberScreenState extends State<ConfirmPhoneNumberScreen> {
  TextEditingController _confirmationCodeController;
  TextEditingController _phoneNumberController;

  get _hasCodeChanged => _confirmationCodeController.text != "";

  get _profileHasPhoneNumber =>
      ApiTypesHelper().phoneNumber != null &&
      ApiTypesHelper().phoneNumber != "";

  get _confirmationText =>
      S.of(context).phoneNumberConfirmationText(ApiTypesHelper().phoneNumber);

  bool _sealed;

  @override
  void initState() {
    super.initState();
    _sealed = false;

    _confirmationCodeController = TextEditingController();
    _confirmationCodeController.addListener(() {
      setState(() {});
    });

    _phoneNumberController = TextEditingController();
    if (widget.phoneNumber != null) {
      _phoneNumberController.text = widget.phoneNumber;
    }
    _phoneNumberController.addListener(() {
      setState(() {});
    });

    Future.delayed(Duration.zero, () async {
      if (_profileHasPhoneNumber) {
        _sendCode(context);
      } else {
        setState(() {
          _sealed = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).confirmPhoneNumber)),
      backgroundColor: Color(0xFFF2F2F2),
      body: true == _sealed
          ? true == _profileHasPhoneNumber
              ? _renderConfirmation()
              : _renderUpdatePhoneNumber()
          : EmptyWidget(),
    );
  }

  Widget _renderConfirmation() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(_confirmationText,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Text(
            S.of(context).confirmationCode,
            style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
          ),
          SizedBox(height: 3),
          TextFormField(
            controller: _confirmationCodeController,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFaa757f)),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(3.0)),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomizedActiveButton(
                title: S.of(context).confirm,
                onPressed: true == _hasCodeChanged
                    ? () => _onConfirmPressed(context)
                    : null,
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _sendCode(context),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  S.of(context).resendCode,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderUpdatePhoneNumber() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                    S.of(context).phoneNumberDoesNotExistPleaseEnterYours,
                    style: Theme.of(context).textTheme.subtitle1)),
            Text(
              S.of(context).phoneNumber,
              style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
            ),
            SizedBox(height: 3),
            TextFormField(
              controller: _phoneNumberController,
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFaa757f)),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(3.0)),
                  )),
            ),
            Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomizedActiveButton(
                      title: S.of(context).confirm,
                      onPressed: _phoneNumberController != null &&
                              true == _phoneNumberController.text.isNotEmpty
                          ? () => _onUpdateNumberPressed(context)
                          : null,
                    ))),
          ],
        ));
  }

  void _onUpdateNumberPressed(BuildContext context) {
    if (_phoneNumberController.text.isNotEmpty) {
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      ApiClient client = PapricaApiClient();
      CustomerApi api = CustomerApi(client);

      dialog.show();

      UpdatePhoneNumberDto data = UpdatePhoneNumberDto.fromJson({
        'phoneNumber': _phoneNumberController.text,
      });

      api.apiServicesAppCustomerUpdatePhoneNumberPost(input: data).then((_) {
        dialog.hide();
        PapricaToast.showToast(S.of(context).phoneNumberUpdated);

        ApiTypesHelper().setPhoneNumber(_phoneNumberController.text);
        ApiTypesHelper().setIsPhoneNumberConfirmed(false);

        setState(() {});
      }).catchError((err) {
        dialog.hide();
        DefaultErrorHandler.handle(context, err);
      });
    }
  }

  void _onConfirmPressed(BuildContext context) {
    if (_confirmationCodeController.text.isNotEmpty) {
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      ApiClient client = PapricaApiClient();
      CustomerApi api = CustomerApi(client);

      ConfirmPhoneNumberDto data = ConfirmPhoneNumberDto.fromJson({
        'code': _confirmationCodeController.text,
      });
      dialog.show();
      api.apiServicesAppCustomerConfirmPhoneNumberPost(input: data).then((_) {
        dialog.hide();
        PapricaToast.showToast(S.of(context).successConfirmPhoneNumber);
        Navigator.of(context).pop(true);
      }).catchError((err) {
        dialog.hide();
        debugPrint(err.toString());
        DefaultErrorHandler.handle(context, err);
      });
    }
  }

  void _sendCode(BuildContext context) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).processing);
    ApiClient client = PapricaApiClient();
    CustomerApi api = CustomerApi(client);

    dialog.show();
    api.apiServicesAppCustomerResendConfirmationCodePost().then((_) {
      dialog.hide();
      PapricaToast.showToast(S.of(context).sentCode);
      setState(() {
        _sealed = true;
      });
    }).catchError((err) {
      dialog.hide();
      debugPrint(err.toString());
      setState(() {
        _sealed = true;
      });
      DefaultErrorHandler.handle(context, err);
    });
  }
}
