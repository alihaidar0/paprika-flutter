import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paprika/translations.dart';
import 'package:swagger/api.dart';

import '../../widgets.dart';
import 'api_error.dart';

class DefaultErrorHandler {
  static void handle(BuildContext context, err, [Function retryCallback]) {
    String message = S.of(context).errorUnknown;
    if (err is ApiException) {
      if (err.code == 500)
        message = ApiError.fromJson(json.decode(err.message)).error.message;
      showDialog(
          context: context,
          builder: (context) {
            return PaprikaErrorDialog(
                title: S.of(context).attention,
                content: message,
                extraButton: err.code < 500 &&
                        retryCallback != null &&
                        retryCallback is Function
                    ? FlatButton(
                        onPressed: () => retryCallback(),
                        child: Text(S.of(context).retry),
                      )
                    : null);
          });
    }
  }
}
