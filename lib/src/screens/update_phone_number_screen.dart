import 'package:flutter/material.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';
import '../../error_handlers.dart';
import '../../utils.dart';

class UpdatePhoneNumberScreen extends StatefulWidget {
  @override
  _UpdatePhoneNumberScreenState createState() =>
      _UpdatePhoneNumberScreenState();
}

class _UpdatePhoneNumberScreenState extends State<UpdatePhoneNumberScreen> {
  TextEditingController _currentController;

  @override
  void initState() {
    super.initState();
    _currentController = TextEditingController();
    if (ApiTypesHelper().phoneNumber != null) {
      _currentController.text = ApiTypesHelper().phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).updatePhoneNumber)),
        backgroundColor: Color(0xFFF2F2F2),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).phoneNumber,
                  style: TextStyle(fontSize: 14, color: Color(0xFF747373)),
                ),
                SizedBox(height: 3),
                TextFormField(
                  controller: _currentController,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
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
                          title: S.of(context).update,
                          onPressed: () => _onUpdateNumberPressed(context),
                        ))),
              ],
            )));
  }

  void _onUpdateNumberPressed(BuildContext context) {
    if (_currentController.text.isNotEmpty) {
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      ApiClient client = PapricaApiClient();
      CustomerApi api = CustomerApi(client);

      dialog.show();

      UpdatePhoneNumberDto data = UpdatePhoneNumberDto.fromJson({
        'phoneNumber': _currentController.text,
      });

      api.apiServicesAppCustomerUpdatePhoneNumberPost(input: data).then((_) {
        dialog.hide();
        PapricaToast.showToast(S.of(context).phoneNumberUpdated);
        ApiTypesHelper().setPhoneNumber(_currentController.text);
        ApiTypesHelper().setIsPhoneNumberConfirmed(false);
        Navigator.of(context).pop(_currentController.text);
      }).catchError((err) {
        dialog.hide();
        DefaultErrorHandler.handle(context, err);
      });
    }
  }
}
