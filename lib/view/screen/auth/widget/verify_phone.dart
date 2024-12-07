import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../utils/color_resources.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_toast.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String phone;
  const VerifyPhoneScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.phone;
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
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "verify".tr,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
              Text(
                "you_need_to_verify".tr,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 12,
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {},
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                    prefixIcon: CountryCodePicker(
                      enabled: false,
                      onChanged: (value) {
                        authController.updateCountryCode(value.dialCode!);
                        print(value.dialCode);
                      },

                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: authController.countryCode,
                      favorite: ['+996', 'KG'],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
                    hintText: "   --- --- ---",
                    counterText: "",
                    hintStyle: const TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              !authController.isLoading
                  ? CustomButton(
                      onTap: () {
                        if (!authController.isLoading) {
                          authController.phoneAuthentication(authController.countryCode + _controller.text, "2");
                        } else {
                          showShortToast("invalid_phone_number".tr);
                        }
                      },
                      width: Get.width * 0.9,
                      height: Get.height * 0.05,
                      title: "get_otp".tr,
                    )
                  : CircularProgressIndicator()
            ],
          ),
        );
      }),
    );
  }
}
