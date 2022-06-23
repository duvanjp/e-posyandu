import 'package:flutter/material.dart';

class AppAlertDialog {
  final String? title, description, positiveButtonText, negativeButtonText;
  final VoidCallback? positiveButtonOnTap, negativeButtonOnTap;

  AppAlertDialog(
      {@required this.title,
      @required this.description,
      this.positiveButtonText,
      this.positiveButtonOnTap,
      this.negativeButtonText,
      this.negativeButtonOnTap});

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              title!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            content: Text(
              description!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
            actions: <Widget>[
              if (negativeButtonText != null && negativeButtonOnTap != null)
                FlatButton(
                  onPressed: negativeButtonOnTap,
                  child: Text(negativeButtonText!),
                )
              else
                Container(),
              if (positiveButtonText != null && positiveButtonOnTap != null)
                FlatButton(
                  onPressed: positiveButtonOnTap,
                  child: Text(positiveButtonText!),
                )
              else
                Container(),
            ],
          );
        });
  }
}
