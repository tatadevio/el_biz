import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/keywords_tags_screen.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../base/custom_button.dart';

class CompanyDescriptionScreen extends StatefulWidget {
  const CompanyDescriptionScreen({super.key});

  @override
  State<CompanyDescriptionScreen> createState() =>
      _CompanyDescriptionScreenState();
}

class _CompanyDescriptionScreenState extends State<CompanyDescriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<CompanyBloc>().state.addCompanyModel.description =
          descriptionController.text;

      Get.to(() => KeywordsTagsScreen());
    } else {
      // validation issue...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'description'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'describe_your_companys_activities_products_and_services'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: descriptionController,
                hintColor: 'description'.tr,
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              // Get.to(() => MainCategories(type: false, fromHome: false));
              _submitForm();
            },
            title: 'continue'.tr),
      ),
    );
  }
}
