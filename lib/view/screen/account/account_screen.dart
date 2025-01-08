import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/edit_account_info_bottom_sheet.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _selectedOption = 'Optima USD';
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
                'main_invoice_for_payment'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
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
                  const Text(
                    'Optima USD',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '0202020202002',
                    style: body16.copyWith(color: ColorResources.gray),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'all_accounts'.tr,
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                accoutItem('Optima USD', '0202020202002'),
                accoutItem('Optima KGS', '0202020202002'),
              ],
            ),
          ],
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
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(33, 32, 32, 1)),
                  ),
                  Text(
                    subTitle,
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
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(const EditAccountInfoBottomSheet(),
                        backgroundColor: Colors.white,
                        isScrollControlled: true);
                  },
                  child: Text(
                    'edit'.tr,
                    style: button16.copyWith(color: ColorResources.blue),
                  ),
                ),
              ],
            ),
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
