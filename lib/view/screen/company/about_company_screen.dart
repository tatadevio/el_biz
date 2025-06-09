import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/company_detail/company_detail_bloc.dart';
import '../../base/custom_button.dart';
import '../category/select_category_screen.dart';
import 'keywords_tags_screen.dart';

class AboutCompanyScreen extends StatefulWidget {
  final bool isEdit;
  const AboutCompanyScreen({super.key, this.isEdit = false});

  @override
  State<AboutCompanyScreen> createState() => _AboutCompanyScreenState();
}

class _AboutCompanyScreenState extends State<AboutCompanyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      loadCompanyData();
    }
  }

  void loadCompanyData() {
    final companyData =
        context.read<CompanyDetailBloc>().state.companyDetailModel!.data;
    aboutController.text = companyData?.aboutCompany ?? '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<CompanyBloc>().state.addCompanyModel.aboutCompany =
          aboutController.text;

      // context.read<CompanyDetailBloc>().state.companyDetailModel!.data!.

      // Get.to(() => SelectCategoryScreen());

      List<CategoryItem> categories = [];
      if (widget.isEdit) {
        categories = context
            .read<CompanyDetailBloc>()
            .state
            .companyDetailModel!
            .data!
            .categories!;
      }
      Get.to(() => SelectCategoryScreen(
            isCompanyCategory: true,
            alreadySelected: categories,
            onSelect: (selectedCategories) {
              context.read<CompanyBloc>().state.addCompanyModel.categories =
                  selectedCategories;
              Get.to(() => KeywordsTagsScreen(isEdit: widget.isEdit));
            },
          ));
    } else {
      // validation issue...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
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
                  'about_company'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   'describe_your_companys_activities_products_and_services'.tr,
                //   style: body14.copyWith(color: ColorResources.gray),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                CustomTextField(
                  controller: aboutController,
                  hintColor: 'about_company'.tr,
                  inputType: TextInputType.text,
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
