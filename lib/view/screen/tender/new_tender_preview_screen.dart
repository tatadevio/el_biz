import 'dart:developer';

import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/bloc/tender_detail/tender_detail_bloc.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../bloc/add_tender/add_tender_bloc.dart';
import '../../../bloc/tenders/tenders_bloc.dart';
import '../../../bloc/tenders/tenders_event.dart';
import '../../../bloc/tenders/tenders_state.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_button.dart';
import 'widgets/add_tenders_image_preview.dart';

class NewTenderPreviewScreen extends StatefulWidget {
  final bool isEdit;
  const NewTenderPreviewScreen({super.key, this.isEdit = false});

  @override
  State<NewTenderPreviewScreen> createState() => _NewTenderPreviewScreenState();
}

class _NewTenderPreviewScreenState extends State<NewTenderPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AddTenderBloc, AddTenderState>(
        listener: (context, stateListner) async {
          if (stateListner is AddTenderSuccess) {
            // showShortToast('new tended added');
            context
                .read<PublicTenderBloc>()
                .add(GetPublicTender(1, direction: 'asc'));
            await Get.dialog(CustomDialog(
                widget: AlertDialog(
              title:
                  Text(widget.isEdit ? "tender_updated".tr : 'tender_added'.tr),
              content: Text(widget.isEdit
                  ? 'tender_updated_successfully'.tr
                  : 'tender_added_successfully'.tr),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Ok')),
              ],
            )));
            Get.offAll(() => DashboardScreen());
            context.read<TendersBloc>().add(ResetNewTenderModel());
          }
          if (stateListner is AddTenderError) {
            showShortToast('new tender error');
          }
        },
        child: BlocBuilder<TendersBloc, TendersState>(
          builder: (context, state) {
            final tenderData = state.newTenderModel;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.newTenderModel.images != null &&
                      state.newTenderModel.images!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: AddTenderImagesPreview(),
                    ),
                  if (state.newTenderModel.uploadedImages != null &&
                      state.newTenderModel.uploadedImages!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: state.newTenderModel.uploadedImages!
                            .map(
                              (image) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomImage(
                                    image: image.url ?? '',
                                    height: 80,
                                    width: 70,
                                    radius: 10),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: -2,
                          offset: Offset(0, 2),
                          color: Color.fromRGBO(16, 24, 40, 0.06),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                tenderData.whatToBuy ?? '',
                                // 'Стул раскладной',
                                style: h24.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                            ),
                            // Container(
                            //   height: 40,
                            //   width: 40,
                            //   padding: const EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     border: Border.all(
                            //         width: 1, color: ColorResources.lgColor),
                            //     borderRadius: BorderRadius.circular(12),
                            //     boxShadow: const [
                            //       BoxShadow(
                            //         blurRadius: 2,
                            //         spreadRadius: 0,
                            //         offset: Offset(0, 1),
                            //         color: Color.fromRGBO(16, 24, 40, 0.05),
                            //       ),
                            //     ],
                            //   ),
                            //   alignment: Alignment.center,
                            //   child: SvgPicture.asset(Images.svgHeartBorder),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          tenderData.shortDescription ?? '',
                          style: body16.copyWith(color: ColorResources.gray),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${tenderData.budgetStart} - ${tenderData.budgetEnd} ${AppConstants.currencyCode}",
                          // '2 500 сом',
                          style: h24.copyWith(color: ColorResources.blue),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (tenderData.product != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Товар: ',
                                    style: body14.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorResources.darkGray),
                                  ),
                                ),
                                Text(
                                  'Количество',
                                  style: body14.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorResources.darkGray),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: tenderData.product!.length,
                            itemBuilder: (context, index) {
                              final product = tenderData.product![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.productName ?? '',
                                        style: body14,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      product.quantity.toString(),
                                      style: body14,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'uploaded'.tr,
                                  style: body14.copyWith(
                                      color: ColorResources.gray,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '12 окт. 2024',
                                  style: body14.copyWith(
                                      color: ColorResources.gray),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // if (!_isShowDescription) ...[
                        //   ProductReviewsWidget(),
                        // ] else ...[
                        //   AboutProductWidget(),
                        // ],
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: BlocBuilder<AddTenderBloc, AddTenderState>(
            builder: (context, addTenderState) {
          if (addTenderState.isLoading == true) {
            return CustomButtonLoader(width: Get.width, height: Get.height);
          }
          return CustomButton(
              width: Get.width,
              height: Get.height,
              onTap: () {
                if (widget.isEdit) {
                  // showCustomSnackBar('Product Updated....');
                  // Get.offAll(() => const DashboardScreen());
                  final tenderdata =
                      context.read<TendersBloc>().state.newTenderModel;
                  log('this is tender data = ${tenderdata.toJson()}');
                  context.read<AddTenderBloc>().add(UpdateTender(
                      context.read<TendersBloc>().state.newTenderModel,
                      // context.read<AddTenderBloc>().state.addTenderModel!,
                      context
                          .read<TenderDetailBloc>()
                          .state
                          .tenderDetailModel!
                          .data!
                          .id!));
                  // context
                  //     .read<AddTenderBloc>()
                  //     .add(AddNewTender(addTenderModel: tenderdata));
                } else {
                  // showCustomSnackBar('Tender Added');
                  final tenderdata =
                      context.read<TendersBloc>().state.newTenderModel;
                  log('this is tender data = ${tenderdata.toJson()}');
                  context
                      .read<AddTenderBloc>()
                      .add(AddNewTender(addTenderModel: tenderdata));
                  // print('tender data = ${}')
                  // Get.offAll(() => const DashboardScreen());
                  // context.read<TendersBloc>().add(ResetNewTenderModel());
                }
              },
              title: 'save'.tr);
        }),
      ),
    );
  }
}
