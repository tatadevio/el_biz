import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/tender_grid_item.dart';
import 'package:el_biz/view/base/tender_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../base/custom_gridview_widget.dart';
import '../../../../base/custom_listview_widget.dart';

class CompanyTenders extends StatelessWidget {
  const CompanyTenders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, companyDetailState) {
      return BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, companyState) {
        if (companyDetailState.companyTenders!.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('no_tender_found'.tr),
            ),
          );
        }
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
            if (companyState.isShowTendersGridView) ...[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65),
                itemCount: companyDetailState.companyTenders?.length ?? 0,
                itemBuilder: (context, index) {
                  return TenderGridItem(
                    tender: companyDetailState.companyTenders![index],
                  );
                },
              ),
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companyDetailState.companyTenders?.length ?? 0,
                itemBuilder: (context, index) {
                  return TenderListItem(
                    tender: companyDetailState.companyTenders![index],
                  );
                },
              ),
            ],
          ],
        );
      });
    });
  }
}
