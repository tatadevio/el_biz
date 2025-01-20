import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/screen/contracts/contract_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../account/widgets/edit_account_info_bottom_sheet.dart';

class NewContractPaymentScreen extends StatefulWidget {
  const NewContractPaymentScreen({super.key});

  @override
  State<NewContractPaymentScreen> createState() =>
      _NewContractPaymentScreenState();
}

class _NewContractPaymentScreenState extends State<NewContractPaymentScreen> {
  String _selectedOption = 'cashless_payment';
  final List<Map<String, dynamic>> bankAccounts = [
    {'name': "Optima KGS", "number": "0202020202002"},
    {'name': "Optima USD", "number": "0202020202002"},
  ];
  int _selectedBankIndex = 0;

  void updateBankIndex(int index) {
    setState(() {
      _selectedBankIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'select_payment_method'.tr,
                style: h24.copyWith(color: ColorResources.darkGray),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'payment_methods'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                accoutItem('cashless_payment',
                    'cashless_payment_based_on_the_details_linked_to_your_account'),
                accoutItem(
                    'cash', 'payment_is_made_in_cash_between_the_parties'),
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            if (_selectedOption != 'cash') ...[
              Text(
                'your_current_account'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'Optima USD',
                      bankAccounts[_selectedBankIndex]['name'],
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      bankAccounts[_selectedBankIndex]['number'],
                      style: body16.copyWith(color: ColorResources.gray),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      ColorResources.lgColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Text(
                                          'select_main_account'.tr,
                                          style: h16.copyWith(
                                              color: ColorResources.darkGray),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: bankAccounts.length,
                                        itemBuilder: (context, index) {
                                          final bank = bankAccounts[index];
                                          return RadioListTile<String>(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bank['name'],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          33, 32, 32, 1)),
                                                ),
                                                Text(
                                                  bank['number'],
                                                  style: body16.copyWith(
                                                      color:
                                                          ColorResources.gray),
                                                ),
                                              ],
                                            ),
                                            value: bank['name'],
                                            groupValue:
                                                bankAccounts[_selectedBankIndex]
                                                    ['name'],
                                            onChanged: (value) {
                                              setState(() {
                                                // _selectedOption = value!;
                                                _selectedBankIndex = index;
                                              });
                                              updateBankIndex(index);
                                            },
                                          );
                                        },
                                      ),
                                      Row(
                                        children: [
                                          CustomButtonWithIcon(
                                            title: 'add_props'.tr,
                                            svgIcon: Images.svgPlus,
                                            buttonColor: ColorResources.lgColor,
                                            borderColor: ColorResources.lgColor,
                                            textColor: ColorResources.gray,
                                            svgIconColor: ColorResources.gray,
                                            isMaxSize: false,
                                            onTap: () {
                                              Get.back();
                                              Get.bottomSheet(
                                                  const EditAccountInfoBottomSheet(
                                                    isAddNew: true,
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  isScrollControlled: true);
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomButton(
                                        width: Get.width,
                                        height: 48,
                                        onTap: () {
                                          Get.back();
                                        },
                                        title: 'confirm'.tr,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                            );
                          },
                          child: Text(
                            'edit_account'.tr,
                            style:
                                button16.copyWith(color: ColorResources.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: CustomButton(
          width: Get.width,
          height: Get.height,
          onTap: () {
            Get.dialog(
              CustomDialog(
                widget: AlertDialog(
                  backgroundColor: Colors.white,
                  content: Column(
                    spacing: 15,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        Images.done,
                      ),
                      Text(
                        'the_contract_was_successfully_drawn_up'.tr,
                        style: h16.copyWith(
                          color: ColorResources.titleColor,
                        ),
                      ),
                      Text(
                        'sign_the_contract_and_send_it_to_the_customer'.tr,
                        style: body14.copyWith(color: ColorResources.gray),
                      ),
                      Row(
                        spacing: 15,
                        children: [
                          Expanded(
                            child: CustomBorderButton(
                              height: 44,
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              border: Border.all(
                                  width: 1, color: ColorResources.blue),
                              borderRadius: BorderRadius.circular(8),
                              boxShaow: const [ColorResources.shadow1],
                              child: Text(
                                'back'.tr,
                                style:
                                    textMd.copyWith(color: ColorResources.blue),
                              ),
                              onTap: () {
                                Get.back();
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              width: Get.width,
                              height: 44,
                              onTap: () {
                                Get.back();
                                Get.to(() => ContractConditionsScreen());
                              },
                              title: 'look'.tr,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          title: 'confirm'.tr,
        ),
      ),
    );
  }

  Widget accoutItem(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            RadioListTile<String>(
              contentPadding: const EdgeInsets.all(0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(33, 32, 32, 1)),
                  ),
                  Text(
                    subTitle.tr,
                    style: body16.copyWith(color: ColorResources.gray),
                  ),
                ],
              ),
              value: title,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                print(
                    'this is the value of the selected options == ${_selectedOption}');
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Get.bottomSheet(const EditAccountInfoBottomSheet(),
            //             backgroundColor: Colors.white,
            //             isScrollControlled: true);
            //       },
            //       child: Text(
            //         'edit'.tr,
            //         style: button16.copyWith(color: ColorResources.blue),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Optima USD',
        //       style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w400),
        //     ),
        //     Text(
        //       '0202020202002',
        //       style: body16.copyWith(color: ColorResources.gray),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
