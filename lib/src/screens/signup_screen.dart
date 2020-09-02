import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';

class SignUpScreen extends StatefulWidget {
  final bool asAService;

  const SignUpScreen({Key key, this.asAService = false}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode fullNameFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  TextEditingController _nameController;
  TextEditingController _phoneNumberController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  ValidationMessage _nameValidationResult;
  ValidationMessage _phoneNumberValidationResults;
  ValidationMessage _passwordValidationResult;

  @override
  void initState() {
    super.initState();
    fullNameFocus = FocusNode();
    phoneNumberFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameValidationResult = ValidationMessage(isValid: true);
    _phoneNumberValidationResults = ValidationMessage(isValid: true);
    _passwordValidationResult = ValidationMessage(isValid: true);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    fullNameFocus.dispose();
    passwordFocus.dispose();
    phoneNumberFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    double textFieldsSpacing =
        Localizations.localeOf(context).languageCode == 'en' ? 10 : 2;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_su.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: PageScrollPhysics(),
          padding: EdgeInsets.only(left: 60.0, right: 60.0),
          reverse: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
                child: Image(
                  image: AssetImage('assets/images/logo_red_small.png'),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(S.of(context).createNewAccount,
                    style: TextStyle(fontSize: 18)),
              ),
              CustomInputText(
                S.of(context).yourName,
                controller: _nameController,
                lastTextField: false,
                mTextInputAction: TextInputAction.next,
                currentNodeFocus: fullNameFocus,
                nextNodeFocus: phoneNumberFocus,
                errorMessage: _nameValidationResult.isValid
                    ? null
                    : _nameValidationResult.message,
              ),
              SizedBox(height: textFieldsSpacing),
              CustomInputText(
                S.of(context).phoneNumber,
                controller: _phoneNumberController,
                textDirection: TextDirection.ltr,
                lastTextField: false,
                inputType: TextInputType.phone,
                mTextInputAction: TextInputAction.next,
                currentNodeFocus: phoneNumberFocus,
                nextNodeFocus: passwordFocus,
                errorMessage: _phoneNumberValidationResults.isValid
                    ? null
                    : _phoneNumberValidationResults.message,
              ),
              SizedBox(height: textFieldsSpacing),
              CustomInputText(
                S.of(context).password,
                controller: _passwordController,
                lastTextField: false,
                obscure: true,
                mTextInputAction: TextInputAction.next,
                currentNodeFocus: passwordFocus,
                nextNodeFocus: confirmPasswordFocus,
                errorMessage: _passwordValidationResult.isValid
                    ? null
                    : _passwordValidationResult.message,
              ),
              SizedBox(height: textFieldsSpacing),
              CustomInputText(
                S.of(context).confirmPassword,
                controller: _confirmPasswordController,
                lastTextField: true,
                obscure: true,
                mTextInputAction: TextInputAction.done,
                currentNodeFocus: confirmPasswordFocus,
                nextNodeFocus: confirmPasswordFocus,
                errorMessage: (_passwordValidationResult.isValid == false &&
                        _passwordValidationResult.reason ==
                            ValidationReason.mismatch)
                    ? _passwordValidationResult.message
                    : null,
              ),
              SizedBox(height: 20.0),
              CustomizedActiveButton(
                onPressed: () => _signUp(context),
                title: S.of(context).singUp,
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    widget.asAService
                        ? EmptyWidget()
                        : Text(
                            S.of(context).alreadyHaveAccount,
                            style: TextStyle(color: Colors.black45),
                          ),
                    widget.asAService
                        ? EmptyWidget()
                        : GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/logIn');
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                S.of(context).logIn,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) {
    _nameValidationResult = ValidationMessage(
        isValid: _nameController.text.isNotEmpty,
        message: S.of(context).errorEmptyField);
    _phoneNumberValidationResults =
        _validatePhoneNumber(context, _phoneNumberController.text);
    _passwordValidationResult = _validatePassword(context);
    if (_nameValidationResult.isValid &&
        _phoneNumberValidationResults.isValid &&
        _passwordValidationResult.isValid) {
      _nameValidationResult.isValid = _phoneNumberValidationResults.isValid =
          _passwordValidationResult.isValid = true;
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      CustomerApi api = CustomerApi();
      CreateCustomerDto data = CreateCustomerDto.fromJson({
        'name': _nameController.text,
        'phoneNumber': _phoneNumberController.text,
        'password': _passwordController.text,
      });
      dialog.show();
      api.apiServicesAppCustomerSignUpPost(input: data).then((_) {
        dialog.hide();
        showConfirmNumberForm(context);
      }).catchError((err) {
        dialog.hide();
        DefaultErrorHandler.handle(context, err);
      });
    }
    setState(() {});
  }

  ValidationMessage _validatePhoneNumber(
      BuildContext context, String phoneNumber,
      {Country country = Country.local}) {
    if (_phoneNumberController.text.isEmpty) {
      return ValidationMessage(
          isValid: false, message: S.of(context).errorEmptyField);
    }
    switch (country) {
      case Country.local:
        Pattern pattern = r'^(?:[+0]9)?[0-9]{8}$';
        RegExp regex = RegExp(pattern);
        return ValidationMessage(
            isValid: regex.hasMatch(phoneNumber),
            message: S.of(context).errorPhoneNumberFormat);
    }
    return ValidationMessage(isValid: false);
  }

  /// Applies password validation criteria
  ValidationMessage _validatePassword(BuildContext context) {
    if (_passwordController.text.isEmpty)
      return ValidationMessage(
          isValid: false,
          message: S.of(context).errorPasswordEmpty,
          reason: ValidationReason.empty);
    if (_passwordController.text != _confirmPasswordController.text)
      return ValidationMessage(
          isValid: false,
          message: S.of(context).errorPasswordMatch,
          reason: ValidationReason.mismatch);
    return ValidationMessage(isValid: true);
  }

  /// Logs in user after successful sign up
  void _login(BuildContext context, String phoneNumber, String password,
      bool phoneNumberConfirmed) {
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
          customerName: _nameController.text,
          phoneNumber: _phoneNumberController.text,
          isAuthorized: true,
          isPhoneNumberConfirmed: phoneNumberConfirmed);
      Firebase().init(context);
      if (widget.asAService) {
        Navigator.of(context).pop(true);
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }).catchError((err) {
      loginDialog.hide();
      DefaultErrorHandler.handle(context, err);
      Future.delayed(Duration.zero, () {});
    });
  }

  void showConfirmNumberForm(BuildContext generalContext) {
    showDialog(
        context: generalContext,
        builder: (_context) {
          return PapricaSimpleDialog(
            title: S.of(generalContext).confirmPhoneNumber,
            noButton: FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop();
                  _login(generalContext, _phoneNumberController.text,
                      _passwordController.text, false);
                },
                child: Text(S.of(generalContext).skip,
                    style: TextStyle(color: Colors.grey))),
            yesButton: FlatButton(
                onPressed: () {
                  Navigator.pop(generalContext);
                  Navigator.push(
                          generalContext,
                          MaterialPageRoute(
                              builder: (context) => ConfirmPhoneNumberScreen(
                                  phoneNumber: _phoneNumberController.text)))
                      .then((confirmed) {
                    if (confirmed == null || !confirmed) {
                      PapricaToast.showToast(S
                          .of(generalContext)
                          .loggingInRequired(S
                              .of(generalContext)
                              .failurePhoneNumberConfirmation));
                    }
                    _login(generalContext, _phoneNumberController.text,
                        _passwordController.text, confirmed);
                  });
                },
                child: Text(S.of(generalContext).confirm)),
          );
        });
  }
}

enum Country { local }

class ValidationMessage {
  bool isValid;
  String message;
  ValidationReason reason;

  ValidationMessage({@required this.isValid, this.message, this.reason});
}

enum ValidationReason { empty, mismatch }
