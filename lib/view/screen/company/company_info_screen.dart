import 'package:el_biz/controller/product_controller.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/cities/cities_page.dart';
import 'package:el_biz/view/screen/company/company_contact_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../data/model/base/timing_date_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../controller/seller_controller.dart';
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
      appBar: CustomAddCompanyAppbar(title: ''),
      body: GetBuilder<SellerController>(builder: (sellerController) {
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
                  'Город',
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Для выбора города начните вводить название в поле ниже, или выберите из списка.',
                  style: body14.copyWith(color: ColorResources.gray),
                ),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<ProductController>(builder: (productController) {
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
                            productController.selectedCityName == '' ? 'Select City' : productController.selectedCityName,
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
                  'Обязательное поле',
                  style: body12.copyWith(color: ColorResources.green),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Адрес',
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(flex: 2, child: CustomTextField1(controller: streetController, hintColor: '', inputType: TextInputType.name, lableText: 'Улица', leading: '', readOnly: false)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: CustomTextField1(controller: streetController, hintColor: '', inputType: TextInputType.name, lableText: 'Дом', leading: '', readOnly: false)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: CustomTextField1(controller: streetController, hintColor: '', inputType: TextInputType.name, lableText: 'Офис', leading: '', readOnly: false)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Почтовый индекс',
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
                  'Обязательное поле',
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
          child: GetBuilder<SellerController>(builder: (sellerController) {
            return !sellerController.isRegister
                ? CustomButton(
                    width: size.width * .9,
                    height: 50,
                    title: "continue".tr,
                    onTap: () {
                      Get.to(() => const CompanyContactInfoScreen());
                    },
                  )
                : CustomButtonLoader(width: size.width * .9, height: 50);
          }),
        ),
      ),
    );
  }
}
