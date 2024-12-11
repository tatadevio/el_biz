import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CompanyDocumentsWidget extends StatelessWidget {
  const CompanyDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(builder: (context, companyState) {
      if (companyState.isLoading) {
        return const SizedBox(
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (companyState.companyDocuments.isEmpty) {
        return const SizedBox(
          height: 100,
          child: Center(
            child: Text('No Document found'),
          ),
        );
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: companyState.companyDocuments.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final document = companyState.companyDocuments[index];
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  document.documentType == 'file' ? SvgPicture.asset(Images.svgFile) : CustomImage(image: '', height: 32, width: 32, radius: 0),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.title,
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        Row(
                          children: [
                            Text(
                              document.size,
                              style: body14.copyWith(color: ColorResources.gray),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              document.date,
                              style: body14.copyWith(color: ColorResources.gray),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(child: SvgPicture.asset(Images.svgDownload)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.dialog(CustomDialog(widget: AlertDialog(content: deleteDocument())));
                      },
                      child: Text(
                        'Удалить документ',
                        style: button16.copyWith(color: ColorResources.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget deleteDocument() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Images.svgBoxIcon2,
            height: 48,
            width: 48,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Удалить документ?',
            style: h16.copyWith(color: ColorResources.titleColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  width: Get.width,
                  height: 44,
                  onTap: () {
                    Get.back();
                  },
                  title: 'Отменить',
                  color: ColorResources.lgColor,
                  textColor: ColorResources.gray,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: CustomButton(
                  width: Get.width,
                  height: 44,
                  onTap: () {
                    Get.back();
                  },
                  title: 'Удалить',
                  color: ColorResources.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
