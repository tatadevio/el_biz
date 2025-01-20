import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/signature/signature_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignContractScreen extends StatefulWidget {
  const SignContractScreen({super.key});

  @override
  State<SignContractScreen> createState() => _SignContractScreenState();
}

class _SignContractScreenState extends State<SignContractScreen> {
  final TextEditingController directorNameController = TextEditingController();
  bool termsAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'agreement_between'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'supplier'.tr,
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'legal_name'.tr,
                                style: body16.copyWith(
                                    color: ColorResources.titleColor),
                              ),
                              Text(
                                'ФИО директора',
                                style: body16.copyWith(
                                    color: ColorResources.titleColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'customer'.tr,
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'legal_name'.tr,
                                style: body16.copyWith(
                                    color: ColorResources.titleColor),
                              ),
                              Text(
                                'ФИО директора',
                                style: body16.copyWith(
                                    color: ColorResources.titleColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'signing_the_contract'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'in_order_to_sign_the_contract'.tr,
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'full_name_of_the_director'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                      controller: directorNameController,
                      hintColor: 'full_name'.tr,
                      inputType: TextInputType.name,
                      leading: '',
                      readOnly: false),
                  CheckboxListTile(
                    value: termsAgreed,
                    onChanged: (val) {
                      termsAgreed = val!;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0),
                    activeColor: ColorResources.primary,
                    dense: true,
                    title: Text(
                      'i_agree_to_the_terms_of_the_agreement'.tr,
                      style: body14.copyWith(color: ColorResources.blackText),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container()
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'buyer'.tr,
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                      Text(
                        'OcOO “Loft”',
                        style: body16.copyWith(color: ColorResources.gray),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'you_have_received_an_electronic_contract_to_sign'.tr,
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBorderButton(
                    height: 44,
                    width: Get.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    border: Border.all(color: ColorResources.red, width: 1),
                    borderRadius: BorderRadius.circular(12),
                    boxShaow: const [ColorResources.shadow1],
                    child: Text(
                      'reject'.tr,
                      style: textMd.copyWith(color: ColorResources.red),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              Get.to(() => SignatureScreen());
            },
            title: 'subscribe'.tr),
      ),
    );
  }
}
