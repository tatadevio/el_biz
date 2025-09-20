import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/Images.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_textfield.dart';

class AddBetBottomSheet extends StatelessWidget {
  final TextEditingController suggestedBidController;
  final ValueChanged<String> onChanged;
  const AddBetBottomSheet({
    super.key,
    required this.suggestedBidController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment:
            //     CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
              ),
              Container(
                height: 5,
                width: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.5),
                    color: Color.fromRGBO(60, 60, 67, 0.3)),
              ),
              // IconButton(
              //     onPressed: () {
              //       Get.back();
              //     },
              //     icon: Icon(Icons.close))
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(217, 217, 217, 1)),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
                color: ColorResources.backgroundColor,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'last_bet'.tr,
                  style: body12.copyWith(color: ColorResources.gray),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Нур И.',
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                          Text(
                            '18.07.2025 / 20:00',
                            style: body12.copyWith(color: ColorResources.gray),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '500\$',
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // TextField(
          //   controller: suggestedBidController,
          // ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'your_bet'.tr,
            style: body12.copyWith(color: ColorResources.gray),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            controller: suggestedBidController,
            // controller: suggestedBidController,
            hintColor: '',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
            ],
            inputType: TextInputType.number,
            leading: '',
            onChanged: (val) {
              // setState(() {});
              onChanged(val);
            },
            readOnly: false,

            suffix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              child: Text('\$'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Text(
          //   'Добавьте ещё 60\$ и купите не ожидая окончания аукциона',
          //   style: body14,
          // ),
          RichText(
            text: TextSpan(
              style: body14, // Your default text style
              children: [
                TextSpan(text: 'add_more'.tr),
                TextSpan(
                  text: '60\$',
                  style: body14.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'buy_without_waiting'.tr, style: body14),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              Get.defaultDialog(
                title: 'you_placed_bet'.tr,
                content: Text('wait_until_auction_end'.tr,
                    style: textStyle13Inter.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.black,
                        fontFamily: 'SFPRO')),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                titlePadding: EdgeInsets.only(top: 16),
                radius: 16,
                titleStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'SFPRO'),
                backgroundColor: Colors.white.withOpacity(0.8),
                barrierDismissible: true,
                onWillPop: () async {
                  return true;
                },
              );
              // Get.dialog(Container(
              //   height: 200,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(24)),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         'Вы сделали ставку',
              //   style: TextStyle(
              //       fontSize: 17,
              //       fontWeight: FontWeight.w500,
              //       color: Colors.black),
              // ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Text(
              //           'Ожидайте до окончания аукциона. Если в течение этого времени никто не сделает ставку, вы станете победителем!',
              //           style: textStyle13Inter.copyWith(
              //               color: ColorResources.black)),
              //     ],
              //   ),
              // ));
            },
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: ColorResources.primary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: ColorResources.blue),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Images.svgCurrency),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'place_bet'.tr,
                    style: body16.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            onTap: () {},
            width: Get.width,
            height: 46,
            title: '${'buy_at_your_price'.tr} 560\$',
            color: ColorResources.blue.withOpacity(0.2),
            textColor: ColorResources.blue,
            radius: 16,
          ),
        ],
      ).paddingOnly(
          bottom: (MediaQuery.of(context).padding.bottom - 12)
              .clamp(0.0, double.infinity)),
    );
  }
}
