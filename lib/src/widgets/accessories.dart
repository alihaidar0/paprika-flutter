import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paprika/translations.dart';
import 'package:photo_view/photo_view.dart';

import '../../screens.dart';

class CircularAvatar extends StatelessWidget {
  final String path;
  final bool isLocal;
  final double size;
  final double elevation;

  final Color color;

  CircularAvatar(this.path,
      {this.elevation = 3,
      this.size = 42,
      this.color = Colors.white,
      this.isLocal = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.color,
      elevation: this.elevation,
      shape: CircleBorder(),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: this.size,
            width: this.size,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(this.size),
                image: DecorationImage(
                    image: this.isLocal
                        ? AssetImage(this.path)
                        : NetworkImage(
                            this.path,
                          ),
                    fit: this.isLocal ? BoxFit.contain : BoxFit.cover)),
          )),
    );
  }
}

class DotsSeparator extends StatelessWidget {
  final double size;

  DotsSeparator({this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: this.size,
      height: this.size,
      child: Image.asset("assets/icons/dots_vert.png"),
    ));
  }
}

class Label extends StatelessWidget {
  final String text;
  final double fontSize;

  Label(this.text, {this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16, left: 16, bottom: 0),
      child: Text(
        this.text,
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontSize: this.fontSize),
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String text;
  final double fontSize;

  Paragraph(this.text, {this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Text(
        this.text,
        style: TextStyle(fontSize: this.fontSize),
      ),
    );
  }
}

class PaprikaToast {
  static void showToast(String text,
      [ToastType type = ToastType.Normal, Toast length = Toast.LENGTH_SHORT]) {
    Color backgroundColor;
    switch (type) {
      case ToastType.Normal:
        backgroundColor = Colors.grey[600];
        break;
      case ToastType.Success:
        backgroundColor = Colors.green[300];
        break;
      case ToastType.Error:
        backgroundColor = Colors.red[300];
        break;
      default:
        backgroundColor = Colors.grey[300];
    }
    Fluttertoast.showToast(
      msg: text,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

enum ToastType { Normal, Success, Error }

typedef Future RetryCallback();

class RequestRetry extends StatefulWidget {
  final String message;
  final RetryCallback retryCallback;

  const RequestRetry({Key key, this.message, @required this.retryCallback})
      : super(key: key);

  @override
  _RequestRetryState createState() => _RequestRetryState();
}

class _RequestRetryState extends State<RequestRetry> {
  bool isRetrying = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.message != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.message),
                )
              : Container(),
          Padding(
            padding: Localizations.localeOf(context).languageCode == 'en'
                ? const EdgeInsets.only(left: 32.0)
                : const EdgeInsets.only(right: 24.0),
            child: SizedBox(
              width: 144,
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text(S.of(context).retry),
                    onPressed: !isRetrying
                        ? () {
                            if (widget.retryCallback != null) {
                              setState(() {
                                isRetrying = true;
                              });
                              widget.retryCallback().then((_) {
                                if (mounted)
                                  setState(() {
                                    isRetrying = false;
                                  });
                              });
                            }
                          }
                        : null,
                    textColor: Colors.white,
                  ),
                  this.isRetrying
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaprikaVerticalDivider extends StatelessWidget {
  final double height;
  final Color color;

  const PaprikaVerticalDivider(
      {Key key, this.height = 12, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Center(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            border: Border(
              left: createBorderSide(context, color: color),
            ),
          ),
        ),
      ),
    );
  }

  BorderSide createBorderSide(BuildContext context,
      {Color color, double width = 0.0}) {
    assert(width != null);
    return BorderSide(
      color: color ?? Theme.of(context).dividerColor,
      width: width,
    );
  }
}

class RestaurantNamedLink extends StatelessWidget {
  final String restaurantName;

  final restaurantId;
  final Color textColor;
  final Padding padding;

  const RestaurantNamedLink(
      {@required this.restaurantName,
      @required this.restaurantId,
      this.textColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding ?? const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return RestaurantHome(restaurantId: restaurantId);
          }));
        },
        child: Text(
          restaurantName,
          style: TextStyle(
              color: this.textColor ?? Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class DotsLoader extends StatefulWidget {
  final int dotsCount;
  final Duration duration;

  final double size;

  const DotsLoader(
      {Key key,
      this.dotsCount = 6,
      this.duration = const Duration(milliseconds: 150),
      this.size = 14})
      : super(key: key);

  @override
  _DotsLoaderState createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<DotsLoader> {
  int _current = 0;

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(widget.duration, (Timer t) {
      setState(() {
        _current == widget.dotsCount - 1 ? _current = 0 : _current++;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(widget.dotsCount, (index) {
            return SizedBox(
              width: widget.size + 2,
              child: Container(
                width: _current == index ? widget.size + 2 : widget.size,
                height: _current == index ? widget.size + 2 : widget.size,
                margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.white : Colors.white70,
                ),
              ),
            );
          })),
    );
  }
}

class OnlineStatus extends StatefulWidget {
  final Widget child;

  const OnlineStatus({@required this.child});

  @override
  _OnlineStatusState createState() => _OnlineStatusState();
}

class _OnlineStatusState extends State<OnlineStatus>
    with TickerProviderStateMixin {
  StreamSubscription<ConnectivityResult> _subscription;
  bool _connected = true;

  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  /// Used to prevent stream listener from being called on initiation
  bool _firstTimeInitiation = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _offsetFloat = Tween(begin: Offset(0.0, -24), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (_firstTimeInitiation) {
        _firstTimeInitiation = false;
        return;
      }
      _controller.forward();

      setState(() {
        _connected = result != ConnectivityResult.none;
      });
      Future.delayed(Duration(seconds: 1), () {
        Connectivity().checkConnectivity().then((result) {
          setState(() {
            if (_connected) _controller.reverse();
          });
        });
      });
    });
  }

  @override
  dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        Positioned(
          height: 24.0,
          left: 0.0,
          right: 0.0,
          child: SlideTransition(
            position: _offsetFloat,
            child: Container(
              color:
                  _connected ? Colors.lightGreen[300] : Colors.redAccent[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _connected ? S.of(context).online : S.of(context).offline,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  _connected
                      ? SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: Colors.transparent,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingPlaceHolder extends StatefulWidget {
  final Widget icon;
  final String line;

  const LoadingPlaceHolder({Key key, this.icon, this.line}) : super(key: key);

  @override
  _LoadingPlaceHolderState createState() => _LoadingPlaceHolderState();
}

class _LoadingPlaceHolderState extends State<LoadingPlaceHolder> {
  int dotsCount = 3;
  String dots = "...";

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      setState(() {
        if (dotsCount == 3) dotsCount = 0;
        dotsCount++;
        dots = "";
        for (int i = 1; i <= dotsCount; i++) {
          dots += ".";
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        widget.icon ??
            SpinKitCircle(
              color: Theme.of(context).primaryColor,
            ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                (widget.line ?? S.of(context).loading),
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              SizedBox(
                  width: 20,
                  child: Text(
                    dots,
                    style: TextStyle(color: Colors.black54),
                  ))
            ],
          ),
        )
      ],
    );
  }
}

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 0, height: 0);
  }
}

class FullscreenPhoto extends StatelessWidget {
  final ImageProvider provider;

  const FullscreenPhoto({Key key, @required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Container(
            child: PhotoView(
          loadingBuilder: (context, progress) => Container(),
          // loadingChild: Container(),
          backgroundDecoration: BoxDecoration(color: Colors.black87),
          minScale: PhotoViewComputedScale.contained * 0.8,
          imageProvider: provider,
        )),
      ),
    );
  }
}

class PaprikaCachedImage extends StatelessWidget {
  final String imageUrl;

  const PaprikaCachedImage({Key key, @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Center(
          child: Icon(
        Icons.error,
        color: Theme.of(context).primaryColor,
      )),
    );
  }
}

class HorizontalLineWithWidget extends StatelessWidget {
  final Widget child;

  const HorizontalLineWithWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Colors.black,
              height: 50,
            )),
      ),
      this.child != null ? this.child : EmptyWidget(),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: 50,
            )),
      ),
    ]);
  }
}
