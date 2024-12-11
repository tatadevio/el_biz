import 'package:country_code_picker/country_code_picker.dart';
import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../utils/color_resources.dart';

class GetStartScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String name;
  final String type;
  const GetStartScreen({Key? key, required this.phoneNumber, required this.email, required this.name, required this.type}) : super(key: key);

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  final TextEditingController _fNamecontroller = TextEditingController();
  final TextEditingController _lNamecontroller = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.phoneNumber;
    _emailController.text = widget.email;
    _fNamecontroller.text = widget.name;
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      defaultDoneWidget: Text("next".tr),
      actions: [
        if (GetPlatform.isIOS) KeyboardActionsItem(displayArrows: false, displayDoneButton: true, focusNode: _nodeText1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        leadingWidth: 120,
        title: Text(
          "registration".tr,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTitle("name".tr),
                  // CustomTextField(
                  //   readOnly: false,
                  //   leading: Images.profile,
                  //   controller: _fNamecontroller,
                  //   hintColor: 'name'.tr,
                  //   inputType: TextInputType.text,
                  //   color: ColorResources.greyHard.withOpacity(0.09),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTitle("your_phone_number".tr),
                  Container(
                    width: Get.width * 0.9,
                    height: Get.height * 0.066,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: KeyboardActions(
                      config: _buildConfig(context),
                      child: TextFormField(
                        onTapOutside: (v) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        focusNode: _nodeText1,
                        maxLength: 12,
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Only numbers can be entered
                        onChanged: (value) {},
                        onEditingComplete: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                            fillColor: Theme.of(context).cardColor,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(borderSide: const BorderSide(color: ColorResources.greyHard, width: 0.5), borderRadius: BorderRadius.circular(10.0)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: ColorResources.greyHard, width: 0.5), borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: ColorResources.greyHard, width: 0.5), borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: CountryCodePicker(
                              enabled: widget.phoneNumber.isEmpty ? true : false,
                              onChanged: (value) {
                                context.read<AuthBloc>().add(UpdateCountryCode(value.dialCode!));
                                // authState.updateCountryCode(value.dialCode!);
                                print(value.dialCode);
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: authState.countryCode,
                              favorite: ['+996', 'KG'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                            hintText: "phone_number".tr,
                            hintStyle: const TextStyle(color: ColorResources.lightGrey),
                            counterText: ""),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTitle("email".tr),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: _emailController.text.isNotEmpty || widget.type == "3" ? true : false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (va) {
                      if (!emailRegex.hasMatch(_emailController.text)) {
                        return "Email not valid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: ColorResources.darkGray,
                      ),
                      hintText: "email".tr,
                      //hintStyle: TextStyle(fontSize: 17,color: Colors.black)
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  !authState.isLoading
                      ? InkWell(
                          onTap: () async {
                            // if (_fNamecontroller.text.isEmpty || _phoneController.text.isEmpty) {
                            //   showShortToast("fill_all_fields".tr);
                            //   return;
                            // }

                            // if (widget.type != "3" && _emailController.text.isEmpty) {
                            //   showShortToast("fill_all_fields".tr);
                            //   return;
                            // }

                            // if (_emailController.text.isNotEmpty && !emailRegex.hasMatch(_emailController.text)) {
                            //   showShortToast("enter_a_valid_email_address".tr);
                            // } else {
                            //   if (widget.type == "1") {
                            //     authState
                            //         .registration(
                            //       _fNamecontroller.text,
                            //       _emailController.text,
                            //     )
                            //         .then((value) {
                            //       if (value.isSuccess) {
                            //         Get.offAll(() => const DashboardScreen());
                            //       }
                            //     });
                            //   } else if (widget.type == "2") {
                            //     authState.verifyPhoneGoogle(_fNamecontroller.text, "${authState.countryCode}${_phoneController.text}", _emailController.text).then((value) {});
                            //   } else if (widget.type == "3") {
                            //     print("phone number is ${"${authState.countryCode}${_phoneController.text}"}");
                            //     authState.verifyPhoneApple(_fNamecontroller.text, "${authState.countryCode}${_phoneController.text}", _emailController.text).then((value) {});
                            //   }
                            // }
                          },
                          child: Container(
                            width: width * 0.9,
                            height: 50,
                            child: Center(
                              child: Text(
                                "confirm".tr,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                              ),
                            ),
                            decoration: BoxDecoration(color: ColorResources.primary, borderRadius: BorderRadius.circular(12.0), boxShadow: [
                              BoxShadow(
                                  color: ColorResources.primary.withOpacity(0.3),
                                  blurRadius: 24,
                                  //spreadRadius: 20,
                                  offset: const Offset(0, 8))
                            ]),
                          ),
                        )
                      : const Align(alignment: Alignment.center, child: CircularProgressIndicator()),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget customTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      textAlign: TextAlign.left,
    ).paddingOnly(bottom: 15);
  }
}
