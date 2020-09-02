import 'package:flutter/material.dart';
import 'package:paprica/app.dart';
import 'package:paprica/error_handlers.dart';
import 'package:paprica/pages.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/screens/update_phone_number_screen.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:paprica/utils.dart';
import 'package:share/share.dart';
import 'package:swagger/api.dart';

class MorePage extends StatefulWidget {
  const MorePage();

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return ProfilePage();
            })),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text(S.of(context).profile),
                  Icon(
                    Localizations.localeOf(context).languageCode == 'en'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Share.share(
                S.of(context).shareTextApp("https://links.popina.me")),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text(S.of(context).inviteAFriend),
                  Icon(
                    Localizations.localeOf(context).languageCode == 'en'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return AboutUsScreen();
            })),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text(S.of(context).aboutUs),
                  Icon(
                    Localizations.localeOf(context).languageCode == 'en'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _showLanguageDialog(context),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text(S.of(context).language),
                  Icon(
                    Localizations.localeOf(context).languageCode == 'en'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              if (ApiTypesHelper().isAuthorized) {
                showDialog(
                    context: context,
                    builder: (_context) {
                      return PapricaSimpleDialog(
                        title: S.of(context).logOutConfirmation,
                        yesButton: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _logOut(context);
                            },
                            child: Text(S.of(context).yes)),
                      );
                    });
              } else {
                Navigator.of(context).pushNamed('/logIn');
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text(ApiTypesHelper().isAuthorized
                      ? S.of(context).logOut
                      : S.of(context).logIn),
                  Icon(
                    Localizations.localeOf(context).languageCode == 'en'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          ApiTypesHelper().isAuthorized ? Divider() : Container(),
        ],
      ),
    );
  }

  _showLanguageDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (context) => LanguageChangerDialog(),
    ).then((lang) {
      if (lang != null) {
        SharedPreference.saveLangToSharedPref(lang);
        PapricaApiClient().setLang(lang);
        ProgressDialog dialog = ProgressDialog(context);
        dialog.setMessage(S.of(context).changingLanguage);
        dialog.show();
        ApiTypesHelper().changeLanguage(context).then((_) {
          dialog.hide();
          PapricaApp.setLocale(context, lang);
          Navigator.of(context).pushReplacementNamed('/home');
        }).catchError((err) {
          dialog.hide();
          showDialog(
              context: context,
              builder: (context) {
                return PapricaErrorDialog(
                  title: S.of(context).error,
                  content: S.of(context).errorChangeLanguage,
                );
              });
        });
      }
    });
  }

  void _logOut(BuildContext context) {
    ApiClient client = PapricaApiClient();
    NotificationsApi api = NotificationsApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).loggingOut);
    dialog.show();
    api
        .apiServicesAppNotificationsUnregisterFirebaseNotificationsPost()
        .then((_) {
      SharedPreference.removeTokenFromSharedPrefs().then((_) {
        dialog.hide();
        ApiTypesHelper().setAuthorized(false);
        ApiTypesHelper().setIsPhoneNumberConfirmed(false);
        ApiTypesHelper().setPhoneNumber("");
        PapricaApiClient().setAccessToken("");
        Navigator.of(context).pushReplacementNamed('/logIn');
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((err) {
      dialog.hide();
      DefaultErrorHandler.handle(context, err);
    });
  }
}

class LanguageChangerDialog extends StatefulWidget {
  @override
  _LanguageChangerDialogState createState() => _LanguageChangerDialogState();
}

class _LanguageChangerDialogState extends State<LanguageChangerDialog> {
  String res;
  String value;

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    String defaultLang =
        langCode == 'en' ? S.of(context).english : S.of(context).arabic;

    return AlertDialog(
      title: Text(
        S.of(context).pleaseSelectLanguage,
        style: Theme.of(context).textTheme.subhead,
      ),
      content: Row(
        children: <Widget>[
          StringRadioButton(
            "English",
            radioValue: value != null ? value : defaultLang,
            onRadioTab: (_lang) {
              setState(() {
                value = _lang;
                res = 'en';
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          ),
          StringRadioButton(
            "العربية",
            radioValue: value != null ? value : defaultLang,
            onRadioTab: (_lang) {
              setState(() {
                value = _lang;
                res = 'ar';
              });
            },
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).cancel,
                style: TextStyle(color: Colors.grey))),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(res != null ? res : langCode);
            },
            child: Text(S.of(context).save))
      ],
    );
  }
}
