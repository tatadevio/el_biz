import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/company/company_bloc.dart';
import '../../../../data/model/base/compnay_document_model.dart';

class ShowContractFiles extends StatelessWidget {
  const ShowContractFiles({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: size.height * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                            borderRadius: BorderRadius.circular(5),
                            color: ColorResources.lgColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'documents'.tr,
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Images.svgDownload,
                          color: ColorResources.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'download_all'.tr,
                          style: button16.copyWith(color: ColorResources.blue),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.companyDocuments.length,
                  itemBuilder: (context, index) {
                    return contractDocument(state.companyDocuments[index]);
                  },
                )),
                CustomButton(
                  width: Get.width,
                  height: 48,
                  onTap: () {
                    Get.back();
                  },
                  title: 'agreement_approval'.tr,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget contractDocument(ComapnyDocumentModel document) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            document.documentType == 'image'
                ? CustomImage(
                    image: document.urlLink, height: 40, width: 40, radius: 0)
                : SvgPicture.asset(
                    Images.svgFile,
                    height: 40,
                    width: 40,
                  ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.title,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        document.size,
                        style: body14.copyWith(color: ColorResources.gray),
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
            SvgPicture.asset(
              Images.svgDownload,
              color: ColorResources.blue,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
