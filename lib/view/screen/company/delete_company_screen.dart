import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/company/company_bloc.dart';
import '../../../utils/Images.dart';

class DeleteCompanyScreen extends StatefulWidget {
  final String id;
  const DeleteCompanyScreen({super.key, required this.id});

  @override
  State<DeleteCompanyScreen> createState() => _DeleteCompanyScreenState();
}

class _DeleteCompanyScreenState extends State<DeleteCompanyScreen> {
  final TextEditingController otherTextController = TextEditingController();
  List deleteReason = [
    'registered_by_mistake'.tr,
    'the_company_ceased_operations'.tr,
    'you_no_longer_want_to_use_our_service'.tr,
    'other'.tr,
  ];
  String selectedReason = 'registered_by_mistake'.tr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'removing_the_profile_garden_furniture_Loft'.tr,
                style: h24.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'we_are_very_sorry_that_you_are_deleting_your_profile_from_the_application'
                    .tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'cause'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: deleteReason.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      deleteReason[index],
                      style: body16.copyWith(color: ColorResources.gray),
                    ),
                    value: deleteReason[index],
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value!;
                      });
                    },
                  );
                },
              ),
              if (selectedReason == 'other'.tr) ...[
                CustomTextField(
                  controller: otherTextController,
                  hintColor: 'write_your_comment'.tr,
                  inputType: TextInputType.text,
                  leading: '',
                  readOnly: false,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'required_field'.tr,
                  style: body12.copyWith(color: ColorResources.green),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButtonWithIcon(
          onTap: () {
            context.read<CompanyBloc>().add(DeleteCompany(widget.id));
            Get.back();
          },
          title: 'continue'.tr,
          svgIcon: Images.svgTrash,
          textColor: Colors.white,
          svgIconColor: Colors.white,
          buttonColor: ColorResources.red,
          borderColor: ColorResources.red,
          isMaxSize: false,
        ),
      ),
    );
  }
}
