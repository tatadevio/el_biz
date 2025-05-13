import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/company_account_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../bloc/company/company_bloc.dart';
import '../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../data/model/base/add_company_model.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_button.dart';
import 'widgets/custom_add_company_appbar.dart';

class CompanyContactInfoScreen extends StatefulWidget {
  final bool isEdit;
  const CompanyContactInfoScreen({super.key, required this.isEdit});

  @override
  State<CompanyContactInfoScreen> createState() =>
      _CompanyContactInfoScreenState();
}

class _CompanyContactInfoScreenState extends State<CompanyContactInfoScreen> {
  List<TextEditingController> phoneControllers = [TextEditingController()];
  final TextEditingController emailController = TextEditingController();
  List<TextEditingController> accountNameControllers = [
    TextEditingController()
  ];
  List<TextEditingController> accountControllers = [TextEditingController()];

  void addNewPhoneNumber() {
    setState(() {
      phoneControllers.add(TextEditingController());
    });
  }

  void removePhoneNumber(int index) {
    setState(() {
      phoneControllers[index].dispose();
      phoneControllers.removeAt(index);
    });
  }

  void addNewAccount() {
    accountNameControllers.add(TextEditingController());
    accountControllers.add(TextEditingController());
    setState(() {});
  }

  void removeAccount(int index) {
    accountNameControllers.removeAt(index);
    accountControllers.removeAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    for (var controller in phoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() {
    List<String> phoneNumbers = phoneControllers
        .map((controller) => '${AppConstants.countryCode}${controller.text}')
        .toList();

    List<String> accountNames =
        accountNameControllers.map((c) => c.text).toList();
    List<String> accounts = accountControllers.map((c) => c.text).toList();

    List<OtherContacts> otherContacts = [];

    for (int i = 0; i < accountNames.length; i++) {
      otherContacts.add(
        OtherContacts(
          id: DateTime.now().millisecondsSinceEpoch.toString() + i.toString(),
          contactName: accountNames[i],
          contactNumber: accounts[i],
        ),
      );
    }

    final companyModel = context.read<CompanyBloc>().state.addCompanyModel;

    companyModel.phoneNumbers = phoneNumbers;
    companyModel.email = emailController.text;
    companyModel.otherContacts = otherContacts;

    Get.to(() => CompanyAccountInfoScreen(isEdit: widget.isEdit));
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      loadData();
    }
  }

  void loadData() {
    final companyData =
        context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;

    emailController.text = companyData.email ?? '';
    if (companyData.phoneNumbers != null &&
        companyData.phoneNumbers!.isNotEmpty) {
      for (int i = 0; i < companyData.phoneNumbers!.length; i++) {
        phoneControllers[i].text =
            companyData.phoneNumbers![i].startsWith('+996')
                ? companyData.phoneNumbers![i].replaceFirst('+996', '')
                : companyData.phoneNumbers![i];
        // phoneControllers[i].text = companyData.phoneNumbers![i];
        int valid = i;
        if (++valid < companyData.phoneNumbers!.length) {
          addNewPhoneNumber();
        }
      }
    }

    if (companyData.contacts != null && companyData.contacts!.isNotEmpty) {
      for (int i = 0; i < companyData.contacts!.length; i++) {
        accountNameControllers[i].text = companyData.contacts![i].name ?? '';
        accountControllers[i].text = companyData.contacts![i].contact ?? '';
        int valid = i;
        if (++valid < companyData.contacts!.length) {
          addNewAccount();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "phone_number".tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'public_phone_numbers_One_per_field'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: phoneControllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // height: 64,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        const Color.fromRGBO(208, 213, 221, 1),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 26,
                                      height: 16,
                                      color: ColorResources.primaryRed,
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        Images.svgPhoneFieldLogo,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      Images.arrowForward,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center, // Aligns both text and input in the center
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: Text(
                                              AppConstants.countryCode,
                                              style: body16,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: TextFormField(
                                              maxLength: 10,
                                              controller:
                                                  phoneControllers[index],
                                              keyboardType: TextInputType.phone,
                                              decoration: const InputDecoration(
                                                counterText: "",
                                                isDense: true,
                                                isCollapsed: true,

                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            5), // Adjust vertical padding as needed
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide:
                                                            BorderSide(
                                                                color: Colors
                                                                    .white)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide:
                                                            BorderSide(
                                                                color: Colors
                                                                    .white)),
                                              ),
                                              style: body16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (index != 0)
                              IconButton(
                                onPressed: () {
                                  removePhoneNumber(index);
                                },
                                icon: Icon(Icons.remove_circle,
                                    color: Colors.red),
                              ),
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWithIcon(
                onTap: () {
                  addNewPhoneNumber();
                },
                title: 'add_a_number'.tr,
                svgIcon: Images.svgPlus,
                isMaxSize: false,
                textColor: ColorResources.gray,
                svgIconColor: ColorResources.gray,
                buttonColor: ColorResources.lgColor,
                borderColor: ColorResources.lgColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'email_address'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'official_public_e_mail_of_the_company'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: emailController,
                  hintColor: '@gmail.com',
                  inputType: TextInputType.emailAddress,
                  leading: Images.svgMail,
                  readOnly: false),
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
              Text(
                'other_contacts'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //         child: CustomTextField1(
              //             controller: accountNameController,
              //             hintColor: 'Telegram',
              //             inputType: TextInputType.text,
              //             lableText: 'contact_name'.tr,
              //             leading: '',
              //             readOnly: false)),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //         child: CustomTextField1(
              //             controller: accountController,
              //             hintColor: '@Telegram',
              //             inputType: TextInputType.text,
              //             lableText: 'contacts'.tr,
              //             leading: '',
              //             readOnly: false)),
              //   ],
              // ),
              Column(
                children: [
                  ...List.generate(accountNameControllers.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField1(
                              controller: accountNameControllers[index],
                              hintColor: 'Telegram',
                              inputType: TextInputType.text,
                              lableText: 'contact_name'.tr,
                              leading: '',
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField1(
                              controller: accountControllers[index],
                              hintColor: '@Telegram',
                              inputType: TextInputType.text,
                              lableText: 'contacts'.tr,
                              leading: '',
                              readOnly: false,
                            ),
                          ),
                          if (index != 0)
                            IconButton(
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red),
                              onPressed: () => removeAccount(index),
                            ),
                        ],
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWithIcon(
                onTap: addNewAccount,
                title: 'add_contacts'.tr,
                svgIcon: Images.svgPlus,
                isMaxSize: false,
                textColor: ColorResources.gray,
                svgIconColor: ColorResources.gray,
                buttonColor: ColorResources.lgColor,
                borderColor: ColorResources.lgColor,
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
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CustomButton(
            width: size.width * .9,
            height: 50,
            title: "continue".tr,
            onTap: () {
              _submitForm();
            },
          ),
        ),
      ),
    );
  }
}
