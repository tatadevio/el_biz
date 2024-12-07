import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String btnLabel;
  final String btnLabelCancel;
  final Function onCancel;
  final Function onConfirm;

  const CustomAlertDialog({Key? key, required this.title, required this.message, required this.btnLabel, required this.btnLabelCancel, required this.onCancel, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isIOS
        ? CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0)
          ),
          onPressed: ()
          {
            onConfirm();
          },
          child: Text(btnLabel,style: TextStyle(letterSpacing: 0.5,fontSize: 16,color: Colors.red),),
        ),
        MaterialButton(
          elevation: 0,
          onPressed: () async
          {
            onCancel();
          },
          child: Text(btnLabelCancel,
            style: TextStyle(letterSpacing: 0.5,fontSize: 16),),

        ),
      ],
    )
        : AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0)
          ),
          onPressed: ()
          {
            onConfirm();
          },
          child: Text(btnLabel,style: TextStyle(letterSpacing: 0.5,fontSize: 16),),
          color: Colors.grey[300],
        ),
        MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0)
          ),
          onPressed: () async
          {
            onCancel();
          },
          child: Text(btnLabelCancel,
            style: TextStyle(letterSpacing: 0.5,fontSize: 16,color: Colors.black),),
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
