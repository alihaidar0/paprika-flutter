import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';
import 'package:paprica/utils.dart';
import '../../error_handlers.dart';
import '../../utils.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInScreen extends StatefulWidget {
  final bool asAService;

  const LogInScreen({Key key, this.asAService = false}) : super(key: key);

  @override
  _MyLogInState createState() => _MyLogInState();
}

class _MyLogInState extends State<LogInScreen> {
  FocusNode _phoneNumberFocusLogin;
  FocusNode _passwordFocusLogin;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  bool _errorUserName;
  bool _errorPassword;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusLogin = FocusNode();
    _passwordFocusLogin = FocusNode();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _errorUserName = false;
    _errorPassword = false;
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _phoneNumberFocusLogin.dispose();
    _passwordFocusLogin.dispose();
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
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_white.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            reverse: true,
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Row(children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(S.of(context).logIn,
                          style: TextStyle(fontSize: 18)),
                    ),
                    Spacer()
                  ]),
                  Row(children: <Widget>[
                    new Flexible(
                        flex: 4,
                        child: RawMaterialButton(
                          onPressed: () => _googleLogin(),
                          fillColor: Colors.white,
                          splashColor: Colors.grey,
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              Text(S.of(context).google),
                              SizedBox(width: 10),
                              Image(
                                image: AssetImage('assets/icons/google.png'),
                                width: 23,
                                height: 23,
                                filterQuality: FilterQuality.high,
                              ),
                              Spacer(),
                            ],
                          ),
                        )),
                    new Flexible(
                        flex: 1,
                        child: Row(
                          children: <Widget>[SizedBox()],
                        )),
                    new Flexible(
                        flex: 4,
                        child: RawMaterialButton(
                          onPressed: () => _facebookLogin(context),
                          fillColor: Colors.white,
                          splashColor: Colors.grey,
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              Text(S.of(context).facebook),
                              SizedBox(width: 10),
                              Image(
                                image: AssetImage('assets/icons/facebook.png'),
                                width: 30,
                                height: 30,
                                filterQuality: FilterQuality.high,
                              ),
                              Spacer(),
                            ],
                          ),
                        ))
                  ]),
                  HorizontalLineWithWidget(
                    child: Text(S.of(context).or),
                  ),
                  CustomInputText(
                    S.of(context).loginPhoneNumber,
                    controller: _usernameController,
                    lastTextField: false,
                    // not the last input text
                    inputType: TextInputType.text,
                    mTextInputAction: TextInputAction.next,
                    currentNodeFocus: _phoneNumberFocusLogin,
                    nextNodeFocus: _passwordFocusLogin,
                    errorMessage:
                        _errorUserName ? S.of(context).errorEmptyField : null,
                  ),
                  SizedBox(height: textFieldsSpacing),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomInputText(
                        S.of(context).password,
                        controller: _passwordController,
                        lastTextField: false,
                        obscure: true,
                        mTextInputAction: TextInputAction.next,
                        currentNodeFocus: _passwordFocusLogin,
                        errorMessage: _errorPassword
                            ? S.of(context).errorEmptyField
                            : null,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      widget.asAService
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  S.of(context).continueAsGuest,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ForgotPasswordScreen();
                          }));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            S.of(context).forgotYourPasswordQuestion,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: CustomizedActiveButton(
                        onPressed: () => _login(context),
                        title: S.of(context).logIn,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          S.of(context).doNotHaveAccount,
                          style: TextStyle(color: Colors.black45),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup',
                                    arguments: widget.asAService)
                                .then((signedUp) {
                              if (widget.asAService)
                                Navigator.of(context).pop(signedUp);
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              S.of(context).createNewAccount,
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
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    // Dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    _errorUserName = _usernameController.text.isEmpty;
    _errorPassword = _passwordController.text.isEmpty;
    if (_errorPassword || _errorUserName) {
      setState(() {
        _errorUserName = _usernameController.text.isEmpty;
        _errorPassword = _passwordController.text.isEmpty;
      });
      return;
    }

    TokenAuthApi authApi = TokenAuthApi();
    ProgressDialog loginDialog = ProgressDialog(context);
    loginDialog.setMessage(S.of(context).loggingIn);
    loginDialog.show();
    authApi
        .apiTokenAuthAuthenticatePost(
            model: AuthenticateModel.fromJson({
      "userNameOrPhoneNumber": _usernameController.text,
      "password": _passwordController.text,
      "rememberClient": true,
      "scope": 1
    }))
        .then((AuthenticateResultModel authModel) async {
      loginDialog.hide();
      _onSuccessLogin(context, authModel);
    }).catchError((err) {
      loginDialog.hide();
      DefaultErrorHandler.handle(context, err);
      Future.delayed(Duration.zero, () {
        //PapricaToast.showToast(S.of(context).errorUnknown, ToastType.Error);
      });
    });

    setState(() {});
  }

  Future _facebookLogin(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    final result = await facebookLogin.logIn(["email"]);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _sendTokenToServer(context, 'Facebook', result.accessToken.token,
            result.accessToken.userId);
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        PapricaToast.showToast(S.of(context).errorLogin);
        break;
    }
  }

  /// Log in with Google utility
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future _googleLogin() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      _sendTokenToServer(context, 'Google',
          googleSignInAuthentication.accessToken, googleSignInAccount.id);
    } catch (error) {
      PapricaToast.showToast(S.of(context).errorUnknown, ToastType.Error);
    }
  }

  void _sendTokenToServer(
      BuildContext context, String provider, String token, String userId) {
    ApiClient client = PapricaApiClient();
    TokenAuthApi api = TokenAuthApi(client);
    ExternalAuthenticateModel data = ExternalAuthenticateModel.fromJson({
      'authProvider': provider,
      'providerKey': userId,
      'providerAccessCode': token
    });
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).loggingIn);
    dialog.show();
    api.apiTokenAuthExternalAuthenticatePost(model: data).then((result) {
      dialog.hide();
      _onSuccessLogin(context, result);
    }).catchError((err) {
      dialog.hide();
      DefaultErrorHandler.handle(context, err);
    });
  }

  Future _onSuccessLogin(context, result) async {
    await SharedPreference.saveTokenToSharedPrefs(result.accessToken);
    PapricaApiClient().setToken(result.accessToken);
    ApiTypesHelper().setAuthorized(true);
    ApiTypesHelper().setPhoneNumber(result.phoneNumber);
    ApiTypesHelper().setIsPhoneNumberConfirmed(result.isPhoneNumberConfirmed);
    Firebase().init(context);
    if (widget.asAService) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
