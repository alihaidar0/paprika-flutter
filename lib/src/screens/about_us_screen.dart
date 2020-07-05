import 'package:flutter/material.dart';
import 'package:paprica/translations.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUsScreen extends StatelessWidget {
  String _phoneNumber = "+963 938 086 306";
  String _email="support@paprica.sy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S
            .of(context)
            .aboutUs, style: TextStyle(fontSize: 18)),
      ),
      body: Container(
          decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_grey.png'), fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  elevation: 0,
                  color: Colors.black12,
                  shape: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              "assets/images/logo_red_small.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          "SoftUp",
                          style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () => UrlLauncher.launch('tel://' + this._phoneNumber),
                          behavior: HitTestBehavior.opaque,
                          child: Row(mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: Image.asset("assets/icons/smartphone.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _phoneNumber,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              )
                            ],),
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () => UrlLauncher.launch('mailto:' + this._email),
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: Image.asset("assets/icons/paper_plane.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _email,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
