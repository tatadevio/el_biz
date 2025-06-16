import 'dart:io';
import 'dart:ui' as ui;
import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'dart:typed_data';

class SignatureScreen extends StatefulWidget {
  final String contractId;
  final String directorName;

  const SignatureScreen(
      {super.key, required this.contractId, required this.directorName});

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
            bottomNavigationBar: BlocBuilder<ContractsBloc, ContractsState>(
                builder: (contex, contractState) {
              if (contractState.isLoading) {
                return BottomAppBar(
                  child: Center(
                      child: CustomButtonLoader(
                    width: Get.width,
                    height: Get.height,
                  )),
                );
              }
              return BottomAppBar(
                child: CustomButton(
                  width: Get.width,
                  height: Get.height,
                  onTap: () async {
                    contex.read<ContractsBloc>().add(SignContract(
                          contractId: widget.contractId,
                          directorName: widget.directorName,
                          signatureFile: await convertByteDataToXFile(bytes),
                        ));
                  },
                  title: 'subscribe'.tr,
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Future<XFile> convertByteDataToXFile(ByteData byteData) async {
    final pngBytes = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = await File(filePath).writeAsBytes(pngBytes);
    return XFile(file.path);
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
        ],
      ),
    );
  }
}
