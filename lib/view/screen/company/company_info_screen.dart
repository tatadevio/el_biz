import 'package:el_biz/bloc/cities/cities_bloc.dart';
import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/data/model/response/cities_model.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/company/company_contact_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../data/model/base/timing_date_model.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_button.dart';
import 'widgets/custom_add_company_appbar.dart';

class CompanyInfoScreen extends StatefulWidget {
  final bool isEdit;
  const CompanyInfoScreen({super.key, required this.isEdit});

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController officeController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController lunchStartController = TextEditingController();
  final TextEditingController lunchEndController = TextEditingController();

  final List<DaySchedule> schedule = [
    DaySchedule(
        day: "Monday",
        openingTime: "09:00",
        closingTime: "18:00",
        isOpen: true),
    DaySchedule(
        day: "Tuesday",
        openingTime: "09:00",
        closingTime: "18:00",
        isOpen: true),
    DaySchedule(
        day: "Wednesday",
        openingTime: "09:00",
        closingTime: "18:00",
        isOpen: true),
    DaySchedule(
        day: "Thursday",
        openingTime: "09:00",
        closingTime: "18:00",
        isOpen: true),
    DaySchedule(
        day: "Friday",
        openingTime: "09:00",
        closingTime: "18:00",
        isOpen: true),
    DaySchedule(
        day: "Saturday",
        openingTime: "00:00",
        closingTime: "00:00",
        isOpen: false),
    DaySchedule(
        day: "Sunday",
        openingTime: "00:00",
        closingTime: "00:00",
        isOpen: false),
  ];

  DaySchedule lunchBreak = DaySchedule(
      day: 'lunch_break',
      openingTime: "13:00",
      closingTime: "14:00",
      isOpen: true);

  @override
  void initState() {
    super.initState();
    // lunchStartController.text = "13:00";
    // lunchEndController.text = "14:00";

    if (widget.isEdit) {
      loadData();
    } else {
      lunchStartController.text = "13:00";
      lunchEndController.text = "14:00";
    }
  }

  CityItem? selectedCity;

  void loadData() {
    final companyData =
        context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;
    streetController.text = companyData.street ?? '';
    houseController.text = companyData.house ?? '';
    officeController.text = companyData.office ?? '';
    postalCodeController.text = companyData.postalCode ?? '';
    lunchStartController.text = companyData.lunchBreak?.open ?? '';
    lunchEndController.text = companyData.lunchBreak?.close ?? '';

    schedule[0].isOpen = companyData.workingHours?.monday?.open != null;
    schedule[0].openingTime = companyData.workingHours?.monday?.open ?? '00:00';
    schedule[0].closingTime =
        companyData.workingHours?.monday?.close ?? '00:00';
    schedule[1].isOpen = companyData.workingHours?.tuesday?.open != null;
    schedule[1].openingTime =
        companyData.workingHours?.tuesday?.open ?? '00:00';
    schedule[1].closingTime =
        companyData.workingHours?.tuesday?.close ?? '00:00';
    schedule[2].isOpen = companyData.workingHours?.wednesday?.open != null;
    schedule[2].openingTime =
        companyData.workingHours?.wednesday?.open ?? '00:00';
    schedule[2].closingTime =
        companyData.workingHours?.wednesday?.close ?? '00:00';
    schedule[3].isOpen = companyData.workingHours?.thursday?.open != null;
    schedule[3].openingTime =
        companyData.workingHours?.thursday?.open ?? '00:00';
    schedule[3].closingTime =
        companyData.workingHours?.thursday?.close ?? '00:00';
    schedule[4].isOpen = companyData.workingHours?.friday?.open != null;
    schedule[4].openingTime = companyData.workingHours?.friday?.open ?? '00:00';
    schedule[4].closingTime =
        companyData.workingHours?.friday?.close ?? '00:00';
    schedule[5].isOpen = companyData.workingHours?.saturday?.open != null;
    schedule[5].openingTime =
        companyData.workingHours?.saturday?.open ?? '00:00';
    schedule[5].closingTime =
        companyData.workingHours?.saturday?.close ?? '00:00';
    schedule[6].isOpen = companyData.workingHours?.sunday?.open != null;
    schedule[6].openingTime = companyData.workingHours?.sunday?.open ?? '00:00';
    schedule[6].closingTime =
        companyData.workingHours?.sunday?.close ?? '00:00';
    loadSelectedCity();
    for (var sch in schedule) {
      print('this is sch = ${sch.toJson()}');
    }
  }

  loadSelectedCity() {
    final companyData =
        context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;

    final cityState = context.read<CitiesBloc>().state.cityItem;
    selectedCity =
        cityState.firstWhereOrNull((city) => city.id == companyData.city?.id);

    setState(() {});
  }

  void _submitForm() {
    if (selectedCity == null) {
      showShortToast('select_city'.tr);
      return;
    }

    lunchBreak = DaySchedule(
        day: lunchBreak.day,
        openingTime: lunchStartController.text,
        closingTime: lunchEndController.text,
        isOpen: true);

    final companyModel = context.read<CompanyBloc>().state.addCompanyModel;
    companyModel.street = streetController.text;
    companyModel.house = houseController.text;
    companyModel.office = officeController.text;
    companyModel.postalCode = postalCodeController.text;
    companyModel.city = selectedCity;
    companyModel.schedule =
        schedule; // schedule model is not completed to send value...
    companyModel.lunchBreak = lunchBreak;

    companyModel.schedule = [];

    for (var sch in schedule) {
      companyModel.schedule!.add(sch);
      print('this is schedule of the compnay : ${sch.day}');
    }

    Get.to(() => CompanyContactInfoScreen(
          isEdit: widget.isEdit,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorResources.backgroundColor,
      appBar: customAddCompanyAppbar(title: ''),
      body: BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, sellerState) {
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

                BlocBuilder<CitiesBloc, CitiesState>(
                    builder: (context, citiesState) {
                  print('this is list of cities : ${citiesState.cityItem}');
                  return Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: ColorResources.lgColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<CityItem>(
                      value: selectedCity,
                      isExpanded: true,
                      hint: Text(
                        selectedCity?.name ?? 'select_city'.tr,
                        style: body16.copyWith(color: ColorResources.gray),
                      ),
                      underline: const SizedBox(), // Remove default underline
                      onChanged: (CityItem? newValue) {
                        setState(() {
                          selectedCity = newValue;
                        });
                      },
                      items: citiesState.cityItem.map((CityItem city) {
                        return DropdownMenuItem<CityItem>(
                          value: city,
                          child: Text(city.name ?? '', style: body16),
                        );
                      }).toList(),
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
                    Expanded(
                        flex: 2,
                        child: CustomTextField1(
                            controller: streetController,
                            hintColor: '',
                            inputType: TextInputType.name,
                            lableText: 'street'.tr,
                            leading: '',
                            readOnly: false)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomTextField1(
                            controller: houseController,
                            hintColor: '',
                            inputType: TextInputType.name,
                            lableText: 'house'.tr,
                            leading: '',
                            readOnly: false)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomTextField1(
                            controller: officeController,
                            hintColor: '',
                            inputType: TextInputType.name,
                            lableText: 'office'.tr,
                            leading: '',
                            readOnly: false)),
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
                CustomTextField(
                    controller: postalCodeController,
                    hintColor: '',
                    inputType: TextInputType.name,
                    leading: '',
                    readOnly: false),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'required_field'.tr,
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

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: schedule.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Checkbox for Open/Closed
                          // Checkbox(
                          //   value: schedule[index].isOpen,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       schedule[index].isOpen = value!;
                          //       if (!schedule[index].isOpen) {
                          //         schedule[index].openingTime = "00:00";
                          //         schedule[index].closingTime = "00:00";
                          //       } else {
                          //         schedule[index].openingTime = "09:00";
                          //         schedule[index].closingTime = "18:00";
                          //       }
                          //     });
                          //   },
                          //   checkColor:
                          //       ColorResources.primary, // Tick mark color
                          //   fillColor: MaterialStateProperty.resolveWith<Color>(
                          //       (states) {
                          //     // Always white background
                          //     return Colors.white;
                          //   }),
                          //   side: const BorderSide(
                          //     color:
                          //         ColorResources.primary, // Always blue border
                          //     width: 2,
                          //   ),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(4),
                          //   ),

                          // ),
                          Checkbox(
                            value: schedule[index].isOpen,
                            onChanged: (value) {
                              setState(() {
                                schedule[index].isOpen = value!;
                                if (!schedule[index].isOpen) {
                                  schedule[index].openingTime = "00:00";
                                  schedule[index].closingTime = "00:00";
                                } else {
                                  schedule[index].openingTime = "09:00";
                                  schedule[index].closingTime = "18:00";
                                }
                              });
                            },

                            checkColor:
                                ColorResources.primary, // Tick mark color
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                                (states) {
                              // Keep background white at all times
                              return Colors.white;
                            }),
                            side: WidgetStateBorderSide.resolveWith((states) {
                              return BorderSide(
                                color: ColorResources
                                    .primary, // Always blue border
                                width: 2,
                              );
                            }),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          // Day Name
                          Expanded(
                            flex: 4,
                            child: Text(
                              schedule[index].day,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      enabled: schedule[index].isOpen,

                                      controller: TextEditingController(
                                          text: schedule[index].openingTime),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          filled: false),

                                      // decoration:
                                      //     const InputDecoration(labelText: "Open Time"),
                                      onChanged: (value) {
                                        setState(() {
                                          schedule[index].openingTime = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // const SizedBox(width: 8),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '-',
                                        textAlign: TextAlign.center,
                                      )),

                                  // Closing Time TextField
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      enabled: schedule[index].isOpen,
                                      controller: TextEditingController(
                                          text: schedule[index].closingTime),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          filled: false),
                                      // decoration: const InputDecoration(
                                      //     labelText: "Close Time"),
                                      onChanged: (value) {
                                        setState(() {
                                          schedule[index].closingTime = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // Opening Time TextField
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
                Text(
                  "lunch_break".tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // LunchBreakRow(),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "lunch_break".tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: lunchStartController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorResources.dividerColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: lunchEndController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorResources.dividerColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Get.bottomSheet(
                //           BottomSheetContentTiming(
                //               schedule: sellerState.scheduleTiming),
                //           backgroundColor: Colors.white,
                //           shape: const RoundedRectangleBorder(
                //             borderRadius: BorderRadius.vertical(
                //                 top: Radius.circular(25.0)),
                //           ),
                //           isScrollControlled: true,
                //         );
                //       },
                //       child: Container(
                //         height: 47,
                //         width: size.width * .76,
                //         decoration: BoxDecoration(
                //             color: ColorResources.primary,
                //             borderRadius: BorderRadius.circular(12.0)),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             const Icon(
                //               Icons.add,
                //               color: Colors.white,
                //               size: 28,
                //             ),
                //             const SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               "add_work_schedule".tr,
                //               style:
                //                   boldTextStyle.copyWith(color: Colors.white),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
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
              _submitForm();
            },
          ),
        ),
      ),
    );
  }
}
