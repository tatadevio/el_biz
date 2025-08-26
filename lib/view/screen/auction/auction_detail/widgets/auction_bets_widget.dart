import 'package:el_biz/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/Images.dart';
import '../../../../../utils/custom_text_style.dart';

class AuctionBetsWidget extends StatelessWidget {
  const AuctionBetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: ColorResources.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'until_completion'.tr,
                  style: textStyle13Inter,
                ),
                Text(
                  '6${'days'.tr} : 20${'hours'.tr} : 45${'minutes'.tr}',
                  style: body16.copyWith(
                      color: ColorResources.darkGray, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'bets'.tr,
                style: h16.copyWith(
                    color: ColorResources.darkGray, fontFamily: 'Inter'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Images.svgCurrency,
                    color: ColorResources.gray,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '6 ${'bets'.tr.toLowerCase()}',
                    style:
                        textStyle14Inter.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    Images.svgPersons,
                    color: ColorResources.gray,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '2 ${'participants'.tr}',
                    style:
                        textStyle14Inter.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              color: ColorResources.dividerColor,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? ColorResources.white
                    : ColorResources.backgroundColor,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  index.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.darkGray,
                  ),
                ),
                title: Text(
                  'Нур И.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.darkGray,
                  ),
                ),
                subtitle: Text(
                  '18.07.2025 / 20:00',
                  style: body12.copyWith(
                      color: ColorResources.gray,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter'),
                ),
                trailing:
                    // if my own bet then i can cancel it
                    index == 0
                        ? SizedBox(
                            width: Get.width * 0.4,
                            child: Row(
                              children: [
                                // my last bet then show this buttion
                                // Container(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 8, vertical: 4),
                                //   decoration: BoxDecoration(
                                //     color: ColorResources.blue,
                                //     borderRadius: BorderRadius.circular(20),
                                //   ),
                                //   child: Text(
                                //     'Выиграл',
                                //     style: body14.copyWith(
                                //         color: ColorResources.white),
                                //   ),
                                // ),
                                // if i win this auction then show this button on my bet
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: ColorResources.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'winner'.tr,
                                    style: body14.copyWith(
                                        color: ColorResources.white),
                                  ),
                                ),

                                const Spacer(),
                                Text(
                                  '100\$',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.darkGray,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            '100\$',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.darkGray,
                            ),
                          ),
              ),
            );
          },
        ),
      ],
    );
  }
}
