import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatefulWidget {
  final Widget widget;
  const CustomDialog({Key? key, required this.widget}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 850));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: widget.widget,
        ),
      ),
    );
  }
}

popUpAlert(BuildContext context, String message, Color color, {bool firebaseError = false, required String code}) {
  if (firebaseError) {
    String errorMessage = 'something-want-wrong'.tr;
    if (code == "invalid-verification-code") {
      errorMessage = 'invalid-verification-code'.tr;
    } else if (code == "invalid-credential") {
      errorMessage = 'invalid-credential'.tr;
    } else if (code == "user-disabled") {
      errorMessage = 'user-disabled'.tr;
    } else if (code == "invalid-verification-id") {
      errorMessage = 'invalid-verification-id'.tr;
    } else {
      errorMessage = 'something-want-wrong'.tr;
    }
    message = errorMessage;
  }

  return showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    context: context,
    backgroundColor: color,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.only(
    //     topLeft: Radius.circular(10),
    //     topRight: Radius.circular(10),
    //   ),
    // ),
    builder: (context) {
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 40,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white)),
              child: Center(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}
