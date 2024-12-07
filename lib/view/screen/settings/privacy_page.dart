import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../../controller/config_controller.dart';
import '../../../utils/color_resources.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: GetBuilder<ConfigController>(builder: (configController) {
          return !configController.isLoading && configController.privacy != null ? Text(configController.privacy!.data.title) : const Text("");
        }),
      ),
      body: GetBuilder<ConfigController>(builder: (configController) {
        return !configController.isLoading && configController.privacy != null
            ? Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [HtmlWidget(configController.privacy!.data.description)],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              );
      }),
    );
  }
}
