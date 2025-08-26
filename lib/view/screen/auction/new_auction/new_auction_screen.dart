import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/similar_products/similar_products_bloc.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../data/model/response/company/company_product_model.dart';
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
  String? paymentMethod;
  String? selectedLocation;
  String? startingDate;
  String? completionDate;
  String? selectedCurrency;
  TextEditingController cancelTimeController = TextEditingController();

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
                    context.read<ProductDetailBloc>().add(
                        GetProductDetail(widget.selectedProduct.id.toString()));
                    context.read<SimilarProductsBloc>().add(GetSimilarProducts(
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
                                style:
                                    body14.copyWith(color: ColorResources.gray),
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
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,

                          hint: Text(
                            'payment_method'.tr,
                            style: TextStyle(
                              color: ColorResources.darkGray,
                              fontSize: 14,
                            ),
                          ),
                          value:
                              paymentMethod, // Set this to your selected value
                          onChanged: (String? newValue) {
                            // Handle value change
                            setState(() {
                              paymentMethod = newValue;
                            });
                          },
                          items: <String>['cash', 'online']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
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
                ),
                const SizedBox(
                  height: 10,
                ),

                // location
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
                        child: DropdownButton<String>(
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
                          onChanged: (String? newValue) {
                            // Handle value change
                            setState(() {
                              selectedLocation = newValue;
                            });
                          },
                          items: <String>['Бишкек', 'Бишкек1']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
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
                ),
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
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (picked != null) {
                            setState(() {
                              startingDate = formatDate(picked);
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
                                    ? startingDate ?? ''
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
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (picked != null) {
                            setState(() {
                              completionDate = formatDate(picked);
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
                                    ? completionDate ?? ''
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
                            customTextField(
                                editingController: cancelTimeController,
                                hintText: '24',
                                keyboardType: TextInputType.number),
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
                            customTextField(
                                editingController: TextEditingController(),
                                hintText: '1',
                                suffixIcon: null),
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
                      if (selectedCurrency != null) ...[
                        Text(
                          'currency'.tr,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ],
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,

                          hint: Text(
                            'currency'.tr,
                            style: TextStyle(
                              color: ColorResources.darkGray,
                              fontSize: 14,
                            ),
                          ),
                          value:
                              selectedCurrency, // Set this to your selected value
                          onChanged: (String? newValue) {
                            // Handle value change
                            setState(() {
                              selectedCurrency = newValue;
                            });
                          },
                          items: <String>['Сом', 'Сом1']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
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
                      // Text('10 сом'),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: customTextField(
                            editingController: TextEditingController(),
                            hintText: '10',
                            suffixIcon: Text(selectedCurrency ?? ''),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: CustomButton(
              width: Get.width,
              height: Get.height,
              onTap: () {
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
              },
              title: 'publish'.tr),
        ));
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
