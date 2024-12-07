import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/keywords_tags_screen.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_button.dart';

class CompanyDescriptionScreen extends StatefulWidget {
  const CompanyDescriptionScreen({super.key});

  @override
  State<CompanyDescriptionScreen> createState() => _CompanyDescriptionScreenState();
}

class _CompanyDescriptionScreenState extends State<CompanyDescriptionScreen> {
  final TextEditingController descriptionController = TextEditingController();
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
              'Описание',
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Опишите деятельность вашей компании, товары и услуги.\nВНИМАНИЕ! Описание должно быть уникальным и подробным (иначе компания не попадет в поисковые системы Яндекс и Google). Не копируйте описание с других сайтов. Потратьте 5 минут на составление хорошего описания, это позволит увеличить посещаемость вашей страницы. Контактные данные и ссылки запрещены в этом поле.',
              style: body14.copyWith(color: ColorResources.gray),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: descriptionController,
              hintColor: 'Описание',
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
              // Get.to(() => MainCategories(type: false, fromHome: false));
              Get.to(() => KeywordsTagsScreen());
            },
            title: 'Продолжить'),
      ),
    );
  }
}
