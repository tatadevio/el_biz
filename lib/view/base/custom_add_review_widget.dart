import 'dart:io';

import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/reviews/my_reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bloc/review/review_bloc.dart';

class CustomAddReviewWidget extends StatefulWidget {
  const CustomAddReviewWidget({super.key});

  @override
  State<CustomAddReviewWidget> createState() => _CustomAddReviewWidgetState();
}

class _CustomAddReviewWidgetState extends State<CustomAddReviewWidget> {
  final TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, reviewController) {
      return Container(
        height: height * 0.7,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: ColorResources.lgColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'leave_feedback'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'your_rating'.tr,
                      style: body16.copyWith(color: ColorResources.gray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: width * 0.15,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: ColorResources.yellow,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: detailController,
                      hintColor: 'your_review'.tr,
                      inputType: TextInputType.text,
                      leading: '',
                      readOnly: false,
                      maxLines: 5,
                      maxLength: null,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'photo'.tr,
                      style: body14.copyWith(color: ColorResources.gray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (reviewController.pickedLogo.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: reviewController.pickedLogo
                            .map(
                              (image) => Stack(
                                children: [
                                  ClipRRect(
                                    // height: 80,
                                    // width: 80,
                                    borderRadius: BorderRadius.circular(12),

                                    child: Image.file(
                                      File(image.path),
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // reviewController.removeGallery(image);
                                      context
                                          .read<ReviewBloc>()
                                          .add(RemoveGallery(image));
                                    },
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Center(
                                        child:
                                            SvgPicture.asset(Images.svgTrash),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Get.dialog(CustomDialog(
                                widget: SimpleDialog(
                              backgroundColor: Colors.white,
                              title: Row(
                                children: [
                                  Expanded(child: Text('select_image'.tr)),
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              children: [
                                ListTile(
                                  onTap: () {
                                    Get.back();
                                    // reviewController.pickImageDocsCamera();
                                    context
                                        .read<ReviewBloc>()
                                        .add(PickImageDocsCamera());
                                  },
                                  leading: const Icon(Icons.camera),
                                  title: Text('camera'.tr),
                                ),
                                ListTile(
                                  onTap: () {
                                    Get.back();
                                    // reviewController.pickImageDocs();
                                    context
                                        .read<ReviewBloc>()
                                        .add(PickImageDocs());
                                  },
                                  leading: const Icon(Icons.image),
                                  title: Text('gallery'.tr),
                                ),
                              ],
                            )));
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ColorResources.lgColor),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              Images.svgPlus,
                              height: 32,
                              width: 32,
                              color: ColorResources.gray,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomButton(
                          width: Get.width,
                          height: 48,
                          onTap: () {
                            //send review
                            Get.back();
                            Get.dialog(CustomDialog(
                                widget: AlertDialog(
                              backgroundColor: Colors.white,
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Container(
                                  //   height: 48,
                                  //   width: 48,
                                  //   decoration: BoxDecoration(
                                  //       color: Color.fromRGBO(209, 250, 223, 1),
                                  //       border: Border.all(
                                  //         width: 8,
                                  //         color: Color.fromRGBO(236, 253, 243, 1),
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(50)),
                                  //   alignment: Alignment.center,
                                  //   child: SvgPicture.asset(
                                  //     Images.done,
                                  //     height: 48,
                                  //     width: 48,
                                  //   ),
                                  // ),
                                  SvgPicture.asset(
                                    Images.done,
                                    height: 48,
                                    width: 48,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'your_review_has_been_published'.tr,
                                    style: h16.copyWith(
                                        color: ColorResources.darkGray),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'thank_you_for_your_feedback_you_help_us_become_better'
                                        .tr,
                                    style: body14.copyWith(
                                        color: ColorResources.gray),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                    width: Get.width,
                                    height: 48,
                                    onTap: () {
                                      Get.back();
                                      Get.to(() => const MyReviewsScreen());
                                    },
                                    title: 'ready'.tr,
                                  ),
                                ],
                              ),
                            )));
                          },
                          title: 'send'.tr),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
