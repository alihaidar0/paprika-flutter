import 'package:flutter/material.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../screens.dart';
import '../../utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool currentNeeded;

  const ChangePasswordScreen({this.currentNeeded = true});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentController;
  TextEditingController _newController;
  TextEditingController _confirmNewController;

  ValidationMessage _currentValidationResult;
  ValidationMessage _newValidationResult;

  @override
  void initState() {
    super.initState();
    _currentController = TextEditingController();
    _newController = TextEditingController();
    _confirmNewController = TextEditingController();
    _currentValidationResult = ValidationMessage(isValid: true);
    _newValidationResult = ValidationMessage(isValid: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).changePassword)),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(42.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                S.of(context).currentPassword,
                style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
              ),
              SizedBox(height: 3),
              widget.currentNeeded
                  ? TextFormField(
                      controller: _currentController,
                      obscureText: true,
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
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(3.0)),
                          ),
                          errorText: _currentValidationResult.isValid
                              ? null
                              : _currentValidationResult.message),
                    )
                  : EmptyWidget(),
              SizedBox(height: 10),
              Text(
                S.of(context).newPassword,
                style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
              ),
              SizedBox(height: 3),
              TextFormField(
                controller: _newController,
                obscureText: true,
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
                    ),
                    errorText: _newValidationResult.isValid
                        ? null
                        : _newValidationResult.message),
              ),
              SizedBox(height: 10),
              Text(
                S.of(context).confirm,
                style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
              ),
              SizedBox(height: 3),
              TextFormField(
                controller: _confirmNewController,
                obscureText: true,
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
                    ),
                    errorText: (_newValidationResult.isValid == false)
                        ? _newValidationResult.message
                        : null),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CustomizedActiveButton(
                    title: S.of(context).change,
                    onPressed: () => _onResetPressed(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onResetPressed(BuildContext context) {
    _currentValidationResult = ValidationMessage(
        isValid: _currentController.text.isNotEmpty,
        message: S.of(context).errorEmptyField);
    _newValidationResult = _validateNewPassword(context);
    if (widget.currentNeeded &&
        _currentValidationResult.isValid &&
        _newValidationResult.isValid) {
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      ApiClient client = PapricaApiClient();
      CustomerApi api = CustomerApi(client);

      ChangePasswordDto data = ChangePasswordDto.fromJson({
        'currentPassword': _currentController.text,
        'newPassword': _newController.text,
      });
      dialog.show();
      api.apiServicesAppCustomerChangePasswordPost(input: data).then((_) {
        dialog.hide();
        PapricaToast.showToast(S.of(context).successPasswordChanged);
      }).catchError((err) {
        dialog.hide();
        DefaultErrorHandler.handle(context, err);
      });
    }
    setState(() {});
  }

  ValidationMessage _validateNewPassword(BuildContext context) {
    if (_newController.text.isEmpty)
      return ValidationMessage(
          isValid: false,
          message: S.of(context).errorEmptyField,
          reason: ValidationReason.empty);
    if (_newController.text != _confirmNewController.text)
      return ValidationMessage(
          isValid: false,
          message: S.of(context).errorPasswordMatch,
          reason: ValidationReason.mismatch);
    return ValidationMessage(isValid: true);
  }
}
