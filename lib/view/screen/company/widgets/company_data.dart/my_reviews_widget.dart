import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/company_reviews_screen.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';

class MyReviewsWidget extends StatelessWidget {
  const MyReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
            builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.companyReviews!.isEmpty) {
            return const SizedBox.shrink();
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.companyReviews!.length > 2
                ? 2
                : state.companyReviews!.length,
            //  state.companyReviews!.length,
            itemBuilder: (context, index) {
              return ReviewItemWidget(
                review: state.companyReviews![index],
                reviewIndex: index,
              );
            },
          );
        }),
        const Divider(),
        BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
            builder: (context, state) {
          if (state.isLoading || state.companyDetailModel?.data?.id == null) {
            return const SizedBox.shrink();
          }
          return InkWell(
            onTap: () {
              Get.to(() => CompanyReviewsScreen(
                    companyId: state.companyDetailModel!.data!.id.toString(),
                  ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'all_reviews'.tr,
                  style: button16.copyWith(color: ColorResources.blue),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(Images.svgArrowForward),
              ],
            ),
          );
        }),
      ],
    );
  }
}
