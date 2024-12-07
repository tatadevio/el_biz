import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                'Основной счёт на оплату',
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
                  Text(
                    'Optima USD',
                    style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w400),
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
              'Все счета',
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                accoutItem(),
                accoutItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget accoutItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: RadioListTile(
          value: false,
          groupValue: 'account',
          onChanged: (val) {},
          title: Text(
            'Optima USD',
            style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            '0202020202002',
            style: body16.copyWith(color: ColorResources.gray),
          ),
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
