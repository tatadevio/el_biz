import 'package:el_biz/bloc/auction/auctions/auctions_bloc.dart';
import 'package:el_biz/bloc/cities/cities_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/similar_products/similar_products_bloc.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/auction/add_auction/add_auction_bloc.dart';
import '../../../../data/model/response/cities_model.dart';
import '../../../../data/model/response/company/company_product_model.dart';
import '../../../../utils/appConstant.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_image.dart';
import '../../../../utils/Images.dart';
import '../../product_detail/product_detail_screen.dart';

class NewAuctionScreen extends StatefulWidget {
  final ProductListItem selectedProduct;
  const NewAuctionScreen({super.key, required this.selectedProduct});

  @override
  State<NewAuctionScreen> createState() => _NewAuctionScreenState();
}

class _NewAuctionScreenState extends State<NewAuctionScreen> {
  String? paymentMethod = 'cash';
  CityItem? selectedLocation;
  DateTime? startingDate;
  DateTime? completionDate;
  String? selectedCurrency = AppConstants.currencyCode;
  TextEditingController cancelTimeController = TextEditingController();
  TextEditingController minimumThresholdController = TextEditingController();
  TextEditingController targetPriceController = TextEditingController();

  // Function to format date in dd/MM/yyyy format
  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        title: Text('new_auction'.tr),
      ),
      bottomNavigationBar: BlocListener<AddAuctionBloc, AddAuctionState>(
        listener: (context, state) {
          if (state is AddAuctionLoader) {
            CustomButtonLoader(width: Get.width, height: 48);
          }
        },
        child: BottomAppBar(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: CustomButton(
              width: Get.width,
              height: Get.height,
              onTap: () {
                print('this is the add new auction button pressed......');
                print(
                    'selected payment method = $paymentMethod , location = $selectedLocation , start date = $startingDate , end date = $completionDate , cancel time = ${cancelTimeController.text} , min threshold = ${minimumThresholdController.text} , currency = $selectedCurrency , target price = ${targetPriceController.text}');

                print(
                    'this is selected product = ${widget.selectedProduct.id} ${widget.selectedProduct.name}, ');

                Map<String, String> newAuctionData = {
                  "title": widget.selectedProduct.name ?? '',
                  "description": widget.selectedProduct.description ?? '',
                  "product_id": widget.selectedProduct.id.toString(),
                  "product_price": widget.selectedProduct.price.toString(),
                  "payment_method": paymentMethod ?? '',
                  "location": selectedLocation?.name ?? '',
                  "start_date": startingDate != null
                      ? startingDate!.toIso8601String()
                      : '',
                  "end_date": completionDate != null
                      ? completionDate!.toIso8601String()
                      : '',
                  "bid_cancellation_hours": cancelTimeController.text,
                  "minimum_increment": minimumThresholdController.text,
                  "currency": selectedCurrency ?? '',
                  "target_price": targetPriceController.text,
                };
                context
                    .read<AddAuctionBloc>()
                    .add(AddNewAuction(newAuctionData));
              },
              title: 'publish'.tr),
        ),
      ),
      body: BlocListener<AddAuctionBloc, AddAuctionState>(
          listener: (context, state) {
            if (state is AddAuctionLoader) {
              Get.dialog(
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  barrierDismissible: false);
            }
            if (state is AddAuctionError) {
              if (Get.isDialogOpen!) {
                Get.back();
              }
              Get.snackbar('error'.tr, state.error,
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
            if (state is AddAuctionSuccess) {
              context.read<AuctionsBloc>().add(GetAuctions(page: 1));
              Get.back();
              Get.back();
              Get.dialog(CupertinoAlertDialog(
                title: Text('your_auction_published'.tr),
                content: Text('buyers_can_place_bets'.tr),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        'got_it'.tr,
                        style: TextStyle(
                            color: ColorResources.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.back();
                      }),
                ],
              ));
              Get.snackbar('success'.tr, 'your_auction_published'.tr,
                  backgroundColor: Colors.green, colorText: Colors.white);

              // Get.back(); // go back to previous screen
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
                    'product_detail'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<ProductDetailBloc>().add(GetProductDetail(
                          widget.selectedProduct.id.toString()));
                      context.read<SimilarProductsBloc>().add(
                          GetSimilarProducts(
                              productId: widget.selectedProduct.id.toString(),
                              currentPage: 1));
                      Get.to(() => ProductDetailScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CustomImage(
                              image: widget.selectedProduct.image ?? '',
                              height: 70,
                              width: 70,
                              radius: 12),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.selectedProduct.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: h16.copyWith(
                                      color: ColorResources.darkGray),
                                ),
                                Text(
                                  widget.selectedProduct.description ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: body14.copyWith(
                                      color: ColorResources.gray),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: ColorResources.darkGray,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // auction detail
                  Text(
                    'auction_detail'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // payment method
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (paymentMethod != null) ...[
                          Text(
                            'payment_method'.tr,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                                color: Colors.black.withOpacity(0.6)),
                          ),
                        ],

                        // DropdownButtonHideUnderline(
                        //   child: DropdownButton<String>(
                        //     isExpanded: true,

                        //     hint: Text(
                        //       'payment_method'.tr,
                        //       style: TextStyle(
                        //         color: ColorResources.darkGray,
                        //         fontSize: 14,
                        //       ),
                        //     ),
                        //     value:
                        //         paymentMethod, // Set this to your selected value
                        //     onChanged: (String? newValue) {
                        //       // Handle value change
                        //       setState(() {
                        //         paymentMethod = newValue;
                        //       });
                        //     },
                        //     items: <String>['cash', 'online']
                        //         .map<DropdownMenuItem<String>>((String value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Text(
                        //           value,
                        //           style: TextStyle(
                        //             color: ColorResources.darkGray,
                        //             fontSize: 14,
                        //           ),
                        //         ),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),

                        Row(
                          children: [
                            Text(
                              'cash'.tr,
                              style: TextStyle(
                                color: ColorResources.black.withOpacity(0.3),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // location
                  BlocBuilder<CitiesBloc, CitiesState>(
                      builder: (context, citiesState) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (selectedLocation != null) ...[
                            Text(
                              'location'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter',
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ],
                          DropdownButtonHideUnderline(
                            child: DropdownButton<CityItem>(
                              isExpanded: true,

                              hint: Text(
                                'location'.tr,
                                style: TextStyle(
                                  color: ColorResources.darkGray,
                                  fontSize: 14,
                                ),
                              ),
                              value:
                                  selectedLocation, // Set this to your selected value
                              onChanged: (CityItem? newValue) {
                                // Handle value change
                                setState(() {
                                  selectedLocation = newValue;
                                });
                              },
                              items: citiesState.cityItem.map((CityItem city) {
                                // <String>['Бишкек', 'Бишкек1']
                                // .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<CityItem>(
                                  value: city,
                                  child: Text(
                                    city.name ?? '',
                                    style: TextStyle(
                                      color: ColorResources.darkGray,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  // auction date
                  Text(
                    'auction_date'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      // start date
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      // starting date
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final DateTime? pickedStart = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                              selectableDayPredicate: (day) {
                                if (completionDate != null) {
                                  return day.isBefore(completionDate!) ||
                                      day.isAtSameMomentAs(completionDate!);
                                }
                                return true;
                              },
                            );

                            if (pickedStart != null) {
                              setState(() {
                                startingDate = pickedStart;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'start_date'.tr,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Inter',
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Text(
                                  startingDate != null
                                      ? formatDate(startingDate!)
                                      : '00/00/0000',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Inter',
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),
                      // completion date
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final DateTime? pickedEnd = await showDatePicker(
                              context: context,
                              initialDate: completionDate ??
                                  (startingDate ?? DateTime.now()),
                              firstDate: startingDate ?? DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                              selectableDayPredicate: (day) {
                                if (startingDate != null) {
                                  return day.isAfter(startingDate!) ||
                                      day.isAtSameMomentAs(startingDate!);
                                }
                                return true; // allow all if no startingDate yet
                              },
                            );

                            if (pickedEnd != null) {
                              setState(() {
                                completionDate = pickedEnd;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'end_date'.tr,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Inter',
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Text(
                                  completionDate != null
                                      ? formatDate(completionDate!)
                                      : '00/00/0000',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Inter',
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'bet_cancellation_time_limit'.tr,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              SizedBox(
                                height: 38,
                                child: customTextField(
                                    editingController: cancelTimeController,
                                    hintText: '24',
                                    keyboardType: TextInputType.number),
                              ),
                              // Text(
                              //   '24',
                              //   style: TextStyle(
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.w400,
                              //       fontFamily: 'Inter',
                              //       color: Colors.black.withOpacity(0.6)),
                              // ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'hour'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter',
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(Images.svgQuestion),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // price
                  Text(
                    'price'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: ColorResources.dark),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'minimum_threshold'.tr,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              // Text(
                              //   '1',
                              //   style: TextStyle(
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.w400,
                              //       fontFamily: 'Inter',
                              //       color: Colors.black.withOpacity(0.6)),
                              // ),
                              SizedBox(
                                height: 38,
                                child: customTextField(
                                    editingController:
                                        minimumThresholdController,
                                    hintText: '1',
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d{0,2}')),
                                    ],
                                    suffixIcon: null),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'percent_of_last_bet'.tr,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   decoration: BoxDecoration(
                  //     color: ColorResources.white,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       if (selectedCurrency != null) ...[
                  //         Text(
                  //           'currency'.tr,
                  //           style: TextStyle(
                  //               fontSize: 13,
                  //               fontWeight: FontWeight.w400,
                  //               fontFamily: 'Inter',
                  //               color: Colors.black.withOpacity(0.6)),
                  //         ),
                  //       ],
                  //       DropdownButtonHideUnderline(
                  //         child: DropdownButton<String>(
                  //           isExpanded: true,

                  //           hint: Text(
                  //             'currency'.tr,
                  //             style: TextStyle(
                  //               color: ColorResources.darkGray,
                  //               fontSize: 14,
                  //             ),
                  //           ),
                  //           value:
                  //               selectedCurrency, // Set this to your selected value
                  //           onChanged: (String? newValue) {
                  //             // Handle value change
                  //             setState(() {
                  //               selectedCurrency = newValue;
                  //             });
                  //           },
                  //           items: <String>['Сом', 'Сом1']
                  //               .map<DropdownMenuItem<String>>((String value) {
                  //             return DropdownMenuItem<String>(
                  //               value: value,
                  //               child: Text(
                  //                 value,
                  //                 style: TextStyle(
                  //                   color: ColorResources.darkGray,
                  //                   fontSize: 14,
                  //                 ),
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (paymentMethod != null) ...[
                          Text(
                            'currency'.tr,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                                color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                        Row(
                          children: [
                            Text(
                              // '$selectedCurrency'.tr,
                              selectedCurrency ?? '',
                              style: TextStyle(
                                color: ColorResources.black.withOpacity(0.3),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // target price
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if (selectedCurrency != null) ...[
                        //   Text(
                        //     'Целевая цена',
                        //     style: TextStyle(
                        //         fontSize: 13,
                        //         fontWeight: FontWeight.w400,
                        //         fontFamily: 'Inter',
                        //         color: Colors.black.withOpacity(0.6)),
                        //   ),
                        // ],
                        Text(
                          'target_price'.tr,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: 35,
                            child: customTextField(
                                editingController: targetPriceController,
                                hintText: '10',
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                suffixIcon: Text(selectedCurrency ?? ''),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget customTextField({
    TextEditingController? editingController,
    String? hintText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: editingController,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: Colors.black.withOpacity(0.6)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            color: Colors.black.withOpacity(0.6)),
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
