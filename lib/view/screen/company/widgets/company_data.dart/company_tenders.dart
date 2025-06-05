import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_tenders/company_active_tenders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../base/custom_gridview_widget.dart';
import '../../../../base/custom_listview_widget.dart';
import 'company_tenders/company_inactive_tenders_widget.dart';

class CompanyTenders extends StatelessWidget {
  final ScrollController scrollController;
  const CompanyTenders({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    // context.read<CompanyBloc>().add(const UpdateShowTenders(false));
    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, companyDetailState) {
      return BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, companyState) {
        // if (companyDetailState.companyTenders!.isEmpty) {
        //   return Center(
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(vertical: 10),
        //       child: Text('no_tender_found'.tr),
        //     ),
        //   );
        // }
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowTenders(true));
                      // companyState.updateShowTenders(true);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: companyState.isShowActiveTenders ? 2 : 1,
                              color: companyState.isShowActiveTenders
                                  ? ColorResources.blue
                                  : ColorResources.lgColor),
                        ),
                      ),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'actively'.tr,
                        style: textSm.copyWith(
                            color: companyState.isShowActiveTenders
                                ? ColorResources.blue
                                : ColorResources.lgColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowTenders(false));
                      // companyState.updateShowTenders(false);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: !companyState.isShowActiveTenders ? 2 : 1,
                              color: !companyState.isShowActiveTenders
                                  ? ColorResources.blue
                                  : ColorResources.lgColor),
                        ),
                      ),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'inactive'.tr,
                        style: textSm.copyWith(
                            color: !companyState.isShowActiveTenders
                                ? ColorResources.blue
                                : ColorResources.lgColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomGridviewWidget(
                    isSelected: companyState.isShowTendersGridView,
                    onTap: () {
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowTendersGridView(true));
                      // companyState.updateShowTendersGridView(true);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomListviewWidget(
                    isSelected: !companyState.isShowTendersGridView,
                    onTap: () {
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowTendersGridView(false));

                      // companyState.updateShowTendersGridView(false);
                    },
                  ),
                ],
              ),
            ),
            if (companyState.isShowActiveTenders)
              CompanyActiveTendersWidget(
                scrollController: scrollController,
              ),
            if (!companyState.isShowActiveTenders)
              CompanyInActiveTendersWidget(
                scrollController: scrollController,
              ),
          ],
        );
      });
    });
  }
}
