import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../bloc/account/account_bloc.dart';
import '../../../../data/model/response/account/my_accounts_model.dart';

class EditAccountInfoBottomSheet extends StatefulWidget {
  final bool isAddNew;
  final AccountItem? account;
  const EditAccountInfoBottomSheet(
      {super.key, this.isAddNew = false, this.account});

  @override
  State<EditAccountInfoBottomSheet> createState() =>
      _EditAccountInfoBottomSheetState();
}

class _EditAccountInfoBottomSheetState
    extends State<EditAccountInfoBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountBIKController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      accountNameController.text = widget.account!.accountName ?? '';
      accountBIKController.text = widget.account!.bic ?? '';
      accountNumberController.text = widget.account!.accountNumber ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.8, // Maximum 80% of screen height
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Make column size to content
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        decoration: const BoxDecoration(
                          color: ColorResources.lgColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'props'.tr,
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField1(
                            controller: accountNameController,
                            hintColor: 'Optima USD',
                            inputType: TextInputType.text,
                            lableText: 'give_a_name_for_your_account'.tr,
                            leading: '',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required'.tr;
                              }
                              return null;
                            },
                            readOnly: false),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField1(
                            controller: accountBIKController,
                            hintColor: '0202020202002',
                            inputType: TextInputType.text,
                            lableText: 'bic'.tr,
                            leading: '',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required'.tr;
                              }
                              return null;
                            },
                            readOnly: false),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField1(
                            controller: accountNumberController,
                            hintColor: '0202020202002',
                            inputType: TextInputType.text,
                            lableText: 'account_number'.tr,
                            leading: '',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required'.tr;
                              }
                              return null;
                            },
                            readOnly: false),
                        const SizedBox(
                          height: 30,
                        ),
                        // CustomButton(width: Get.width * 0.7, height: 45, onTap: onTap, title: title)
                        if (!widget.isAddNew)
                          CustomButtonWithIcon(
                            title: 'delete_props'.tr,
                            svgIcon: Images.svgTrash,
                            buttonColor: ColorResources.red,
                            borderColor: ColorResources.red,
                            isMaxSize: false,
                            onTap: () async {
                              // delete account
                              print("account id = ${widget.account?.id} ");
                              context.read<AccountBloc>().add(DeleteAccount(
                                    id: widget.account?.id.toString() ?? '',
                                  ));
                            },
                          ),
                        const SizedBox(
                          height: 30,
                        ),
                        if (!state.isLoading)
                          CustomButton(
                              width: Get.width,
                              height: 48,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  if (widget.isAddNew) {
                                    context.read<AccountBloc>().add(AddAccount(
                                          accountName:
                                              accountNameController.text,
                                          accountNumber:
                                              accountNumberController.text,
                                          bic: accountBIKController.text,
                                        ));
                                  } else {
                                    context
                                        .read<AccountBloc>()
                                        .add(UpdateAccount(
                                          id: widget.account?.id.toString() ??
                                              '',
                                          accountName:
                                              accountNameController.text,
                                          accountNumber:
                                              accountNumberController.text,
                                          bic: accountBIKController.text,
                                        ));
                                  }
                                }
                              },
                              title: 'save'.tr)
                        else
                          CustomButtonLoader(width: Get.width, height: 48),
                        // Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
