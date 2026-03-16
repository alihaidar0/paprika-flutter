import 'package:flutter/material.dart';
import 'package:paprika/translations.dart';
import 'package:paprika/widgets.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _confirmationCodeController;
  TextEditingController _newPasswordController;
  TextEditingController _newPasswordConfirmationController;
  TextEditingController _phoneNumberController;

  get _hasCodeChanged => _confirmationCodeController.text != "";

  bool _requestForgottenPasswordSent = false;

  @override
  void initState() {
    super.initState();

    _confirmationCodeController = TextEditingController();
    _newPasswordConfirmationController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmationCodeController.addListener(() {
      setState(() {});
    });

    _phoneNumberController = TextEditingController();
    _phoneNumberController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).forgotPassword)),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
          child: true == _requestForgottenPasswordSent
              ? _renderCodeForm()
              : _renderPhoneNumberForm()),
    );
  }

  Widget _renderCodeForm() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(S.of(context).pleaseEnterTheCodeAndYourNewPassword,
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
          Text(
            S.of(context).newPassword,
            style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
          ),
          SizedBox(height: 3),
          TextFormField(
            controller: _newPasswordController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 14),
            obscureText: true,
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
          Text(
            S.of(context).confirmPassword,
            style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
          ),
          SizedBox(height: 3),
          TextFormField(
            controller: _newPasswordConfirmationController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 14),
            obscureText: true,
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CustomizedActiveButton(
              title: S.of(context).change,
              onPressed: true == _hasCodeChanged
                  ? () => _onChangePressed(context)
                  : null,
            ),
          )),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onRequestPressed(context),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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

  Widget _renderPhoneNumberForm() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(S.of(context).enterPhoneNumber,
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
                          ? () => _onRequestPressed(context)
                          : null,
                    ))),
          ],
        ));
  }

  void _onRequestPressed(BuildContext context) {
    // Dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    if (_phoneNumberController.text.isNotEmpty) {
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      ApiClient client = PapricaApiClient();
      CustomerApi api = CustomerApi(client);

      dialog.show();

      SendForgetPasswordCodeDto data = SendForgetPasswordCodeDto.fromJson({
        'userNameOrPhoneNumber': _phoneNumberController.text,
      });

      api
          .apiServicesAppCustomerSendForgetPasswordCodePost(input: data)
          .then((_) {
        dialog.hide();
        PaprikaToast.showToast(S.of(context).forgotPasswordCodeSent);

        setState(() {
          _requestForgottenPasswordSent = true;
        });
      }).catchError((err) {
        debugPrint(err.toString());
        dialog.hide();
        DefaultErrorHandler.handle(context, err);
      });
    }
  }

  void _onChangePressed(BuildContext context) {
    if (_newPasswordController.text !=
        _newPasswordConfirmationController.text) {
      PaprikaToast.showToast(S.of(context).errorPasswordMatch);
      return;
    }
    if (_confirmationCodeController.text.isNotEmpty &&
        _confirmationCodeController.text.isNotEmpty &&
        _newPasswordConfirmationController.text.isNotEmpty) {
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      ApiClient client = PapricaApiClient();
      CustomerApi api = CustomerApi(client);

      ResetForgottenPasswordDto data = ResetForgottenPasswordDto.fromJson({
        'code': _confirmationCodeController.text,
        'userNameOrPhoneNumber': _phoneNumberController.text,
        'newPassword': _newPasswordController.text
      });
      dialog.show();
      api
          .apiServicesAppCustomerResetForgottenPasswordPost(input: data)
          .then((_) {
        dialog.hide();
        PaprikaToast.showToast(S.of(context).successPasswordChanged);
        _login(
            context, _phoneNumberController.text, _newPasswordController.text);
      }).catchError((err) {
        dialog.hide();
        debugPrint(err.toString());
        DefaultErrorHandler.handle(context, err);
      });
    }
  }

  void _login(BuildContext context, String phoneNumber, String password) {
    TokenAuthApi authApi = TokenAuthApi();
    ProgressDialog loginDialog = ProgressDialog(context);
    loginDialog.setMessage(S.of(context).loggingIn);
    loginDialog.show();
    authApi
        .apiTokenAuthAuthenticatePost(
            model: AuthenticateModel.fromJson({
      "userNameOrPhoneNumber": phoneNumber,
      "password": password,
      "rememberClient": true,
      "scope": 1
    }))
        .then((AuthenticateResultModel authModel) {
      loginDialog.hide();
      SharedPreference.saveTokenToSharedPrefs(authModel.accessToken);
      PapricaApiClient().setToken(authModel.accessToken);
      ApiTypesHelper().initProfile(
          isAuthorized: true,
          phoneNumber: _phoneNumberController.text,
          isPhoneNumberConfirmed: true);
      Firebase().init(context);
      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((err) {
      loginDialog.hide();
      DefaultErrorHandler.handle(context, err);
      Future.delayed(Duration.zero, () {
        //PaprikaToast.showToast(S.of(context).errorUnknown, ToastType.Error);
      });
    });
  }
}
