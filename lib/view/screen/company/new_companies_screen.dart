import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:el_biz/view/base/company_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';

class NewCompaniesScreen extends StatefulWidget {
  const NewCompaniesScreen({super.key});

  @override
  State<NewCompaniesScreen> createState() => _NewCompaniesScreenState();
}

class _NewCompaniesScreenState extends State<NewCompaniesScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show the button if the user scrolls down 300 pixels or more
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<PublicCompanyBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.isMoreLoading) {
        int pageSize = accountController.state.newCompanyPageSize;
        if (accountController.state.newCompanyCurrentPage < pageSize) {
          int nextPage = accountController.state.newCompanyCurrentPage;

          accountController.add(GetNewPublicCompany(nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _callScrolling(context, _scrollController);
    return Scaffold(
      appBar: AppBar(
        title: Text('new_companies'.tr),
      ),
      body: Stack(
        children: [
          BlocBuilder<PublicCompanyBloc, PublicCompanyState>(
              builder: (context, companyState) {
            if (companyState.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (companyState.newCompanies.isEmpty) {
              return Center(
                child: Text('no_company_found'.tr),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: companyState.publicCompanies.length,
                itemBuilder: (context, index) {
                  // print(
                  //     'there i have call the company bloc in compnay list : ${companyState.publicCompanies.length}');
                  return CompanyItemWidget(
                      company: companyState.publicCompanies[index]);
                  // myCompanyWidget(companyState.publicCompanies[index]);
                },
              ),
            );
          }),
          if (_showScrollToTopButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.primary,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget myCompanyWidget(CompanyItem company) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: InkWell(
  //       onTap: () {
  //         // context
  //         //     .read<CompanyBloc>()
  //         //     .add(CompanyDetailById(company.id.toString()));
  //         context
  //             .read<CompanyDetailBloc>()
  //             .add(GetCompanyDetail(company.id.toString()));
  //         Get.to(() => const CompanyPageScreen(
  //               isCompany: true,
  //             ));
  //       },
  //       child: Stack(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  //             decoration: BoxDecoration(
  //               color: ColorResources.lightBlue,
  //               borderRadius: BorderRadius.circular(24),
  //               border: Border.all(width: 1, color: ColorResources.lgColor),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     CustomImage(
  //                         image: company.logo ?? '',
  //                         height: 40,
  //                         width: 40,
  //                         radius: 40),
  //                     const SizedBox(
  //                       width: 5,
  //                     ),
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             company.name ?? '',
  //                             style: h16.copyWith(
  //                               color: ColorResources.darkGray,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             height: 5,
  //                           ),
  //                           Text(
  //                             company.email ?? '',
  //                             style: body14.copyWith(
  //                                 color: ColorResources.darkGray),
  //                           ),
  //                           const SizedBox(
  //                             height: 5,
  //                           ),
  //                           Row(
  //                             children: [
  //                               SvgPicture.asset(Images.svgMap),
  //                               const SizedBox(
  //                                 width: 5,
  //                               ),
  //                               Expanded(
  //                                 child: Text(
  //                                   company.address ?? '',
  //                                   maxLines: 1,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: body14.copyWith(
  //                                       color: ColorResources.gray),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           const SizedBox(
  //                             height: 5,
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Expanded(
  //                                 child: Row(
  //                                   children: [
  //                                     Text(
  //                                       '(4.8)',
  //                                       style: body14.copyWith(
  //                                           color: ColorResources.gray),
  //                                     ),
  //                                     RatingBar.builder(
  //                                       initialRating: 4.8,
  //                                       minRating: 0,
  //                                       direction: Axis.horizontal,
  //                                       allowHalfRating: true,
  //                                       itemCount: 5,
  //                                       itemSize: 14,
  //                                       ignoreGestures: true,
  //                                       itemPadding: const EdgeInsets.symmetric(
  //                                           horizontal: 0),
  //                                       itemBuilder: (context, _) => const Icon(
  //                                         Icons.star,
  //                                         color: ColorResources.yellow,
  //                                       ),
  //                                       onRatingUpdate: (rating) {
  //                                         print(rating);
  //                                       },
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               Row(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: [
  //                                   Text(
  //                                     'more_details'.tr,
  //                                     style: button16.copyWith(
  //                                         color: ColorResources.blue),
  //                                   ),
  //                                   const SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   SvgPicture.asset(Images.svgArrowForward),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             right: 10,
  //             top: 10,
  //             child: Container(
  //               height: 32,
  //               width: 32,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(10),
  //                 backgroundBlendMode: BlendMode.colorDodge,
  //                 boxShadow: const [
  //                   BoxShadow(
  //                     blurRadius: 1.6,
  //                     spreadRadius: 0,
  //                     offset: Offset(0, 0.8),
  //                     color: Color.fromRGBO(16, 24, 40, 0.05),
  //                   ),
  //                 ],
  //               ),
  //               alignment: Alignment.center,
  //               child: SvgPicture.asset(Images.svgHeartBorder),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
