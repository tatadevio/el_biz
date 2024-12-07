import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/company_info_screen.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_button.dart';

class KeywordsTagsScreen extends StatefulWidget {
  const KeywordsTagsScreen({super.key});

  @override
  State<KeywordsTagsScreen> createState() => _KeywordsTagsScreenState();
}

class _KeywordsTagsScreenState extends State<KeywordsTagsScreen> {
  final TextEditingController keywordsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAddCompanyAppbar(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Ключевые слова для поиска/Теги',
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Введите через запятую ключевые слова и синонимы по которым будут искать вашу компанию. Например: Мебель для дома, диваны, стулья, кресло, комод, стол',
              style: body14.copyWith(color: ColorResources.gray),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: keywordsController,
              hintColor: 'Ключевые слова',
              inputType: TextInputType.none,
              leading: '',
              readOnly: false,
              maxLines: 4,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Необязательное поле',
              style: body12.copyWith(color: ColorResources.gray),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              Get.to(() => CompanyInfoScreen());
            },
            title: 'Продолжить'),
      ),
    );
  }
}
