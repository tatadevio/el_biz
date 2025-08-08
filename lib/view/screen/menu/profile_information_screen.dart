import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController familyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initializeUserData();
    });
  }

  initializeUserData() {
    final userData = context.read<UserBloc>().state.userInfo?.data;
    // print('this is phone number = ${userData?.phone}');
    // print('this is company number  = ${context.read<UserBloc>().state.selectedAccountModel?.userPhone}');
    nameController.text = userData?.firstName ?? '';
    familyNameController.text = userData?.lastName ?? '';
    emailController.text = userData?.email ?? '';
    String rawPhone = userData?.phone ?? '';
    String cleanedPhone = rawPhone.startsWith('+996')
        ? rawPhone.replaceFirst('+996', '')
        : rawPhone;

    phoneController.text = cleanedPhone;
    print('account id = ${userData?.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccess) {
            Get.back();
          }
          if (state is UpdateUserDataError) {
            showShortToast(state.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'personal_information'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'fill_in_your_personal_information'.tr,
                  style: body14.copyWith(color: ColorResources.gray),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField1(
                  controller: nameController,
                  hintColor: 'name'.tr,
                  inputType: TextInputType.name,
                  lableText: 'name'.tr,
                  leading: '',
                  readOnly: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField1(
                  controller: familyNameController,
                  hintColor: 'fullName'.tr,
                  inputType: TextInputType.name,
                  lableText: 'fullName'.tr,
                  leading: '',
                  readOnly: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField1(
                  controller: emailController,
                  hintColor: 'email_address'.tr,
                  inputType: TextInputType.emailAddress,
                  lableText: 'email_address'.tr,
                  leading: Images.svgMail,
                  readOnly: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                // CustomTextField1(
                //   controller: nameController,
                //   hintColor: 'Фамилия',
                //   inputType: TextInputType.number,
                //   lableText: 'Фамилия',
                //   leading: Images.svgFlag,
                //   readOnly: false,
                // ),
                Text(
                  'phone_number'.tr,
                  style: body14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 64,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: const Color.fromRGBO(208, 213, 221, 1),
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
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                AppConstants.countryCode,
                                style: body16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                maxLength: 10,
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  counterText: "",
                                  isDense: true,
                                  isCollapsed: true,

                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          5), // Adjust vertical padding as needed
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                                readOnly: true, // for now its true
                                //context.read<UserBloc>().state.userInfo?.data.re,
                                style: body16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        color: Colors.white,
        child: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
          if (userState.isLoading) {
            return CustomButtonLoader(width: Get.width, height: 44);
          }

          return CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              print('data is here ');
              // firstname, lastname, email, phone
              context.read<UserBloc>().add(UpdateUserData(
                  firstName: nameController.text,
                  lastName: familyNameController.text,
                  email: emailController.text,
                  phoneNumber: userState.userInfo?.data?.phone ?? '',
                  context: context));
            },
            title: 'save_changes'.tr,
          );
        }),

        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //   decoration: BoxDecoration(color: Colors.white),
        // ),
      ),
    );
  }
}
