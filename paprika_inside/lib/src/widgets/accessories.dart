import 'package:flutter/material.dart';

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
                    child: Text('Retry'),
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