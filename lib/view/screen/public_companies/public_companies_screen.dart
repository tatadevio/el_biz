import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/base/company_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PublicCompaniesScreen extends StatelessWidget {
  const PublicCompaniesScreen({super.key});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final publicCompanyBloc = context.read<PublicCompanyBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !publicCompanyBloc.state.isLoading &&
          !publicCompanyBloc.state.isMoreLoading) {
        int pageSize = publicCompanyBloc.state.companyPageSize;
        if (publicCompanyBloc.state.companyCurrentPage < pageSize) {
          int nextPage = publicCompanyBloc.state.companyCurrentPage;

          publicCompanyBloc.add(GetPublicCompany(nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.sizeOf(context).width;
    final _scrollController = ScrollController();

    _callScrolling(context, _scrollController);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'companies'.tr,
          style: h16.copyWith(
            color: ColorResources.blackText,
          ),
        ),
        actions: const [
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            context.read<PublicCompanyBloc>().add(GetPublicCompany(1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocBuilder<PublicCompanyBloc, PublicCompanyState>(
              builder: (context, companyState) {
            if (companyState.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (companyState.publicCompanies.isEmpty) {
              return Center(
                child: Text('no_company_found'.tr),
              );
              // return NoCompanyWidget();
            }

            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: companyState.publicCompanies.length,
                    itemBuilder: (context, index) {
                      return CompanyItemWidget(
                          company: companyState.publicCompanies[index]);

                      // myCompanyWidget(
                      //     context, companyState.myCompanies[index]);
                    },
                  ),
                  if (companyState.isMoreLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ).paddingOnly(
                        bottom: MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          }),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   child: CustomButtonWithIcon(
      //     title: 'add_a_company'.tr,
      //     svgIcon: Images.svgPlus,
      //     borderColor: ColorResources.green,
      //     onTap: () {
      //       Get.back();

      //       Get.dialog(
      //         const CustomDialog(
      //           widget: AlertDialog(
      //             backgroundColor: Colors.white,
      //             titlePadding: EdgeInsets.all(0),
      //             contentPadding: EdgeInsets.all(5),
      //             content: Padding(
      //               padding: EdgeInsets.all(0),
      //               child: FillCompanyDataBox(),
      //             ),
      //           ),
      //         ),
      //       );
      //       // Get.to(() => AddCompanyScreen());
      //     },
      //   ),
      // ),
    );
  }
}
