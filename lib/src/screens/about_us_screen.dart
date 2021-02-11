import 'package:flutter/material.dart';
import 'package:paprica/translations.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUsScreen extends StatelessWidget {
  final String _phoneNumber = "+963 987 789 656";
  final String _email = "support@paprika-sy.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).aboutUs, style: TextStyle(fontSize: 18)),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_grey.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    S.of(context).aboutUsInfo,
                    textDirection:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () =>
                              UrlLauncher.launch('tel://' + this._phoneNumber),
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: Image.asset(
                                      "assets/icons/smartphone.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _phoneNumber,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () =>
                              UrlLauncher.launch('mailto:' + this._email),
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: Image.asset(
                                      "assets/icons/paper_plane.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _email,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
