import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextInputType inputType;

  final TextEditingController controller;
  final TextDirection textDirection;
  final TextInputAction mTextInputAction;
  final FocusNode currentNodeFocus;
  final FocusNode nextNodeFocus;
  final bool lastTextField;

  final String errorMessage;

  CustomInputText(this.label,
      {this.lastTextField,
      this.inputType = TextInputType.text,
      this.obscure,
      this.controller,
      this.mTextInputAction,
      this.currentNodeFocus,
      this.textDirection,
      this.nextNodeFocus,
      this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(this.label, style: TextStyle(color: Colors.black45)),
        SizedBox(height: 3.0),
        TextFormField(
          controller: controller,
          textDirection: textDirection,
          textInputAction: this.mTextInputAction,
          textAlign: Localizations.localeOf(context).languageCode == 'en'
              ? TextAlign.left
              : TextAlign.right,
          focusNode:
              this.currentNodeFocus != null ? this.currentNodeFocus : null,
          onFieldSubmitted: (term) {
            this.currentNodeFocus.unfocus();
            if (this.lastTextField == false) {
              FocusScope.of(context).requestFocus(this.nextNodeFocus);
//              controller.clear();
            } else {
//              controller.clear();
            }
          },
          obscureText: this.obscure != null ? this.obscure : false,
          keyboardType: this.inputType,
          style: TextStyle(fontSize: 16, color: Colors.black45),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorText: errorMessage,
            contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFaa757f)),
              borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordInputText extends StatefulWidget {
  final TextEditingController mController;
  final FocusNode currentNodeFocus;

  PasswordInputText({
    this.mController,
    this.currentNodeFocus,
  });

  @override
  _PasswordInputTextState createState() => _PasswordInputTextState();
}

class _PasswordInputTextState extends State<PasswordInputText> {
  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Localizations.localeOf(context).languageCode == "en"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      children: <Widget>[
        TextFormField(
          controller: widget.mController,
          textInputAction: TextInputAction.done,
          textAlign: Localizations.localeOf(context).languageCode == 'en'
              ? TextAlign.left
              : TextAlign.right,
          focusNode: widget.currentNodeFocus,
          onFieldSubmitted: (term) {
            widget.currentNodeFocus.unfocus();
          },
          keyboardType: TextInputType.text,
          obscureText: _obscureText,
          style: TextStyle(fontSize: 16, color: Colors.black45),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFaa757f)),
              borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                Icons.remove_red_eye,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        )
      ],
    );

    ;
  }
}
