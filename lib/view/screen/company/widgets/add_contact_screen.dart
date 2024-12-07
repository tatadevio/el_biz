import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/post_ad_controller.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_button.dart';

class AddContactScreen extends StatefulWidget {
  final bool isSellerRegister;
  const AddContactScreen({super.key, this.isSellerRegister = false});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  List<String> titleList = [
    "Whatsapp",
    "Telegram",
    "Instagram",
    "ВКонтакте",
    "Электронная почта",
    "Веб-сайт",
  ];

  List<String> contactList = [
    Images.whatsappFillSvg,
    Images.telegramSvg,
    Images.instagramSvg,
    Images.vkSvg,
    Images.gmailSvg,
    Images.globeSvg,
  ];

  List<String> subContactList = [
    Images.whatsappSvg,
    Images.telegramSvg,
    Images.instagramSvg,
    Images.vkSvg,
    Images.gmailSvg,
    Images.globeSvg,
  ];

  // Map to store list of TextEditingControllers for each contact type
  Map<String, List<TextEditingController>> controllersMap = {};
  Map<String, List<String>> controllerValue = {};

  @override
  void initState() {
    super.initState();
    // Initialize the map with empty lists for each contact type
    for (var title in titleList) {
      controllersMap[title] = [];
    }
  }

  @override
  void dispose() {
    // Dispose all controllers when the screen is disposed
    controllersMap.forEach((key, controllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    });
    super.dispose();
  }

  void addContactField(String title) {
    setState(() {
      // Initialize controllerValue[title] if it's null
      controllerValue[title] ??= [];

      if (controllersMap[title]!.isEmpty && controllerValue[title]!.isNotEmpty) {
        // Populate controllers with existing values
        for (var value in controllerValue[title]!) {
          var controller = TextEditingController(text: value);
          controllersMap[title]!.add(controller);
        }
      } else {
        // Add a new empty controller
        controllersMap[title]!.add(TextEditingController());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 88.0),
      child: GetBuilder<PostAdController>(builder: (postAdController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 70,
                    decoration: BoxDecoration(
                      color: ColorResources.dividerColor,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Добавьте способы связи",
                        style: boldTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  for (int i = 0; i < titleList.length; i++)
                    Column(
                      children: [
                        ListTile(
                          leading: SvgPicture.asset(
                            contactList[i],
                            height: 40,
                          ),
                          title: Text(
                            titleList[i],
                            style: normalTextStyle,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              addContactField(titleList[i]);
                            },
                            child: Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                color: ColorResources.lightBlue,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        ///'Введите ${titleList[i]}',
                        ...controllersMap[titleList[i]]!
                            .map((controller) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                                  child: CustomTextFieldWithCountryCode(
                                    controller: controller,
                                    hintText: 'Введите ${titleList[i]}',
                                    title: '',
                                    showCountryCode: titleList[i] == "Whatsapp" ? true : false,
                                    line: 1,
                                    prefix: subContactList[i],
                                    textInputType: titleList[i] == "Whatsapp" ? TextInputType.number : TextInputType.text,
                                  ),
                                ))
                            .toList(),
                        const Divider(
                          thickness: 1,
                          color: ColorResources.background,
                        ),
                      ],
                    ),
                  SizedBox(height: 25),
                  CustomButton(
                    width: Get.width * .9,
                    height: 45,
                    onTap: () {
                      // List<List<String>>  allValues = [[], [], [], [], [], []];

                      // controllersMap.forEach((title, controllers) {
                      //   List<String> values = controllers.map((controller) => controller.text).toList();

                      //   allValues[titleList.indexOf(title)] = values;
                      //   print("index is ${titleList.indexOf(title)}");
                      //   print("value is ${values.length}");
                      // });

                      // if(widget.isSellerRegister){
                      //   Get.find<SellerController>().addContact(allValues);
                      // }else{
                      //   postAdController.addContact(allValues);

                      // }
                      // Get.back();
                    },
                    title: "next".tr,
                    color: ColorResources.primary,
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
