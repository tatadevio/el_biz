import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  SignatureScreenState createState() => SignatureScreenState();
}

class SignatureScreenState extends State<SignatureScreen> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: SfSignaturePad(
                          key: signatureGlobalKey,
                          backgroundColor: Colors.white,
                          strokeColor: Colors.black,
                          minimumStrokeWidth: 1.0,
                          maximumStrokeWidth: 4.0))),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: _handleSaveButtonPressed,
                      child: Text('to_image'.tr),
                    ),
                    TextButton(
                      onPressed: _handleClearButtonPressed,
                      child: Text('clear'.tr),
                    )
                  ])
            ]));
  }
}
