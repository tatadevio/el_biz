import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/company_info_screen.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/company/company_bloc.dart';
import '../../base/custom_button.dart';

class KeywordsTagsScreen extends StatefulWidget {
  const KeywordsTagsScreen({super.key});

  @override
  State<KeywordsTagsScreen> createState() => _KeywordsTagsScreenState();
}

class _KeywordsTagsScreenState extends State<KeywordsTagsScreen> {
  final TextEditingController keywordsController = TextEditingController();

  void _submitForm() {
    // if (_formKey.currentState!.validate()) {

    List<String> keywordsList = keywordsController.text
        .toString()
        .split(',')
        .map((e) => e.trim())
        .toList();
    context.read<CompanyBloc>().state.addCompanyModel.keywords = keywordsList;

    Get.to(() => CompanyInfoScreen());
    // } else {
    // validation issue...
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'search_keywords'.tr,
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'enter_the_keywords_and_synonyms_for_which_your_company_will_be_searched'
                  .tr,
              style: body14.copyWith(color: ColorResources.gray),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: keywordsController,
              hintColor: 'keywords'.tr,
              inputType: TextInputType.none,
              leading: '',
              readOnly: false,
              maxLines: 4,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'optional_field'.tr,
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
              _submitForm();
            },
            title: 'continue'.tr),
      ),
    );
  }
}
