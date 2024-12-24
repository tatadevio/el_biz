import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/cities/cities_page.dart';
import 'package:el_biz/view/screen/company/company_contact_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../data/model/base/timing_date_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_button.dart';
import './widgets/add_open_close_time.dart';
import 'widgets/custom_add_company_appbar.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController officeController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  final List<DaySchedule> schedule = [
    DaySchedule(day: "Monday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Tuesday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Wednesday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Thursday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Friday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Saturday", openingTime: "00:00", closingTime: "00:00", isOpen: false),
    DaySchedule(day: "Sunday", openingTime: "00:00", closingTime: "00:00", isOpen: false),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ''),
      body: BlocBuilder<CompanyBloc, CompanyState>(builder: (context, sellerController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'city'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'to_select_a_city,_start_typing_the_name_in_the_field_below_or_select_from_the_list',
                  style: body14.copyWith(color: ColorResources.gray),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ProductBloc, ProductState>(builder: (context, productController) {
                  return InkWell(
                    onTap: () {
                      Get.bottomSheet(const CitiesScreen(), isScrollControlled: true);
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: ColorResources.lgColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productController.selectedCityName == '' ? 'select_city'.tr : productController.selectedCityName,
                            style: body16.copyWith(color: ColorResources.gray),
                          ),
                          SvgPicture.asset(Images.svgArrowRight),
                        ],
                      ),
                    ),
                  );
                }),
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
                Text(
                  'address'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(flex: 2, child: CustomTextField1(controller: streetController, hintColor: '', inputType: TextInputType.name, lableText: 'street'.tr, leading: '', readOnly: false)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: CustomTextField1(controller: streetController, hintColor: '', inputType: TextInputType.name, lableText: 'house'.tr, leading: '', readOnly: false)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: CustomTextField1(controller: streetController, hintColor: '', inputType: TextInputType.name, lableText: 'office'.tr, leading: '', readOnly: false)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'postal_code'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(controller: postalCodeController, hintColor: '', inputType: TextInputType.name, leading: '', readOnly: false),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'required_field',
                  style: body12.copyWith(color: ColorResources.gray),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "working_hours".tr,
                    style: normalTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (int i = 0; i < sellerController.scheduleTiming.length; i++)
                  if (sellerController.scheduleTiming[i].isOpen)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            sellerController.scheduleTiming[i].day,
                            style: const TextStyle(fontSize: 15),
                          )),
                          Text(
                            "${sellerController.scheduleTiming[i].openingTime} -- ",
                            style: const TextStyle(color: ColorResources.grey11),
                          ),
                          Text(
                            sellerController.scheduleTiming[i].closingTime,
                            style: const TextStyle(color: ColorResources.grey11),
                          ),
                        ],
                      ),
                    ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          BottomSheetContentTiming(schedule: sellerController.scheduleTiming),
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                          ),
                          isScrollControlled: true,
                        );
                      },
                      child: Container(
                        height: 47,
                        width: size.width * .76,
                        decoration: BoxDecoration(color: ColorResources.primary, borderRadius: BorderRadius.circular(12.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "add_work_schedule".tr,
                              style: boldTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
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
              Get.to(() => const CompanyContactInfoScreen());
            },
          ),
        ),
      ),
    );
  }
}
