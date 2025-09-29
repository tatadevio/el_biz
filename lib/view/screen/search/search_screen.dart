import 'package:el_biz/bloc/search/search_bloc.dart';
import 'package:el_biz/bloc/search_company/search_company_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/screen/search/search_company/search_company_widget.dart';
import 'package:el_biz/view/screen/search/search_product/search_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import 'widgets/search_screen_topbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchProductController = TextEditingController();
  final TextEditingController searchCompanyController = TextEditingController();
  final ScrollController _scrollProductController = ScrollController();
  final ScrollController _scrollCompanyController = ScrollController();

  late SearchBloc searchBloc;
  late SearchCompanyBloc searchCompanyBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchBloc = context.read<SearchBloc>();
    searchCompanyBloc = context.read<SearchCompanyBloc>();
  }

  @override
  void dispose() {
    _scrollProductController.dispose();
    searchBloc.add(ClearSearchList());
    _scrollCompanyController.dispose();
    searchCompanyBloc.add(ClearSearchCompanyList());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {
          if (searchState.isSearchProducts) {
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: searchProductController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 0),
                        border: OutlineInputBorder(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SvgPicture.asset(Images.svgSearch),
                        ),
                      ),
                      onChanged: (val) {
                        context
                            .read<SearchBloc>()
                            .add(SearchProduct(search: val, currentPage: 1));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    searchProductController.clear();
                    context.read<SearchBloc>().add(ClearSearchList());
                  },
                  child: Text(
                    'Отмена',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                ),
              ],
            );
          }
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: searchCompanyController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset(Images.svgSearch),
                      ),
                    ),
                    onChanged: (val) {
                      context
                          .read<SearchCompanyBloc>()
                          .add(SearchCompany(search: val, currentPage: 1));
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  searchCompanyController.clear();
                  context
                      .read<SearchCompanyBloc>()
                      .add(ClearSearchCompanyList());
                },
                child: Text(
                  'Отмена',
                  style: body14.copyWith(color: ColorResources.gray),
                ),
              ),
            ],
          );
        }),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(95),
        //   // child: BlocBuilder<SearchBloc, SearchState>(
        //   //     builder: (context, searchState) {
        //   //   return Container(
        //   //     decoration: const BoxDecoration(
        //   //         color: Colors.white,
        //   //         borderRadius: BorderRadius.only(
        //   //             bottomLeft: Radius.circular(24.0),
        //   //             bottomRight: Radius.circular(24.0))),
        //   //     child: Column(
        //   //       children: [
        //   //         const SizedBox(
        //   //           height: 5,
        //   //         ),
        //   //         const Divider(
        //   //           height: 0,
        //   //         ),
        //   //         Padding(
        //   //           padding: const EdgeInsets.symmetric(
        //   //               horizontal: 12.0, vertical: 5),
        //   //           child: SizedBox(
        //   //             height: height * 0.06,
        //   //             child: Padding(
        //   //               padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
        //   //               child: Row(
        //   //                 children: [
        //   //                   Expanded(
        //   //                     child: InkWell(
        //   //                       onTap: () {
        //   //                         context
        //   //                             .read<SearchBloc>()
        //   //                             .add(ChangeStatusSearch(false));
        //   //                         // productController.changeStatusSearch(0);
        //   //                       },
        //   //                       child: Container(
        //   //                         height: height * 0.06,
        //   //                         decoration: BoxDecoration(
        //   //                           borderRadius: BorderRadius.circular(6),
        //   //                           color: ColorResources.lightBlue,
        //   //                           boxShadow:
        //   //                               searchState.isSearchProducts == false
        //   //                                   ? const [
        //   //                                       BoxShadow(
        //   //                                         blurRadius: 2,
        //   //                                         spreadRadius: 0,
        //   //                                         offset: Offset(0, 1),
        //   //                                         color: Color.fromRGBO(
        //   //                                             16, 24, 40, 0.06),
        //   //                                       ),
        //   //                                       BoxShadow(
        //   //                                         blurRadius: 3,
        //   //                                         spreadRadius: 3,
        //   //                                         offset: Offset(0, 1),
        //   //                                         color: Color.fromRGBO(
        //   //                                             16, 24, 40, 0.1),
        //   //                                       ),
        //   //                                     ]
        //   //                                   : [],
        //   //                         ),
        //   //                         child: Center(
        //   //                             child: Text(
        //   //                           "Компании".tr,
        //   //                           style: mediumTextStyle.copyWith(
        //   //                             color:
        //   //                                 searchState.isSearchProducts == false
        //   //                                     ? ColorResources.primary
        //   //                                     : ColorResources.black,
        //   //                           ),
        //   //                         )),
        //   //                       ),
        //   //                     ),
        //   //                   ),
        //   //                   const SizedBox(
        //   //                     width: 10,
        //   //                   ),
        //   //                   Expanded(
        //   //                     child: InkWell(
        //   //                       onTap: () {
        //   //                         context
        //   //                             .read<SearchBloc>()
        //   //                             .add(ChangeStatusSearch(true));
        //   //                         // productController.changeStatusSearch(1);
        //   //                       },
        //   //                       child: Container(
        //   //                         height: height * 0.06,
        //   //                         decoration: BoxDecoration(
        //   //                           borderRadius: BorderRadius.circular(10.0),
        //   //                           // color: productController.showFavSearch == 1 ? ColorResources.primary : ColorResources.background,
        //   //                           color: ColorResources.lightBlue,
        //   //                           boxShadow: searchState.isSearchProducts
        //   //                               ? const [
        //   //                                   BoxShadow(
        //   //                                     blurRadius: 2,
        //   //                                     spreadRadius: 0,
        //   //                                     offset: Offset(0, 1),
        //   //                                     color: Color.fromRGBO(
        //   //                                         16, 24, 40, 0.06),
        //   //                                   ),
        //   //                                   BoxShadow(
        //   //                                     blurRadius: 3,
        //   //                                     spreadRadius: 3,
        //   //                                     offset: Offset(0, 1),
        //   //                                     color: Color.fromRGBO(
        //   //                                         16, 24, 40, 0.1),
        //   //                                   ),
        //   //                                 ]
        //   //                               : [],
        //   //                         ),
        //   //                         child: Center(
        //   //                             child: Text("goods".tr,
        //   //                                 style: mediumTextStyle.copyWith(
        //   //                                   color: searchState.isSearchProducts
        //   //                                       ? ColorResources.primary
        //   //                                       : ColorResources.black,
        //   //                                 ))),
        //   //                       ),
        //   //                     ),
        //   //                   ),
        //   //                 ],
        //   //               ),
        //   //             ),
        //   //           ),
        //   //         ),
        //   //         if (searchState.isSearchProducts)
        //   //           Padding(
        //   //             padding: const EdgeInsets.symmetric(horizontal: 16),
        //   //             child: Row(
        //   //               mainAxisAlignment: MainAxisAlignment.end,
        //   //               children: [
        //   //                 InkWell(
        //   //                   borderRadius: BorderRadius.circular(12),
        //   //                   onTap: () {
        //   //                     // productController.updateGridView(true);

        //   //                     context
        //   //                         .read<SearchBloc>()
        //   //                         .add(const UpdateGridView(true));
        //   //                   },
        //   //                   child: Container(
        //   //                     height: 40,
        //   //                     width: 40,
        //   //                     decoration: BoxDecoration(
        //   //                       color: searchState.isGridView
        //   //                           ? ColorResources.primary
        //   //                           : null,
        //   //                       border: Border.all(
        //   //                         width: 1,
        //   //                         color: searchState.isGridView
        //   //                             ? ColorResources.primary
        //   //                             : ColorResources.lgColor,
        //   //                       ),
        //   //                       borderRadius: BorderRadius.circular(12),
        //   //                     ),
        //   //                     alignment: Alignment.center,
        //   //                     child: SvgPicture.asset(
        //   //                       Images.svgCategory,
        //   //                       color: searchState.isGridView
        //   //                           ? ColorResources.white
        //   //                           : ColorResources.gray,
        //   //                     ),
        //   //                   ),
        //   //                 ),
        //   //                 const SizedBox(
        //   //                   width: 5,
        //   //                 ),
        //   //                 InkWell(
        //   //                   borderRadius: BorderRadius.circular(12),
        //   //                   onTap: () {
        //   //                     // productController.updateGridView(false);
        //   //                     context
        //   //                         .read<SearchBloc>()
        //   //                         .add(const UpdateGridView(false));
        //   //                   },
        //   //                   child: Container(
        //   //                     height: 40,
        //   //                     width: 40,
        //   //                     decoration: BoxDecoration(
        //   //                       color: searchState.isGridView
        //   //                           ? null
        //   //                           : ColorResources.primary,
        //   //                       border: Border.all(
        //   //                         width: 1,
        //   //                         color: !searchState.isGridView
        //   //                             ? ColorResources.primary
        //   //                             : ColorResources.lgColor,
        //   //                       ),
        //   //                       borderRadius: BorderRadius.circular(12),
        //   //                     ),
        //   //                     alignment: Alignment.center,
        //   //                     child: SvgPicture.asset(
        //   //                       Images.svgList,
        //   //                       color: !searchState.isGridView
        //   //                           ? ColorResources.white
        //   //                           : ColorResources.gray,
        //   //                     ),
        //   //                   ),
        //   //                 ),
        //   //               ],
        //   //             ),
        //   //           )
        //   //         else
        //   //           SizedBox(
        //   //             height: 35,
        //   //           ),
        //   //       ],
        //   //     ),
        //   //   );
        //   // }),
        // ),
      ),
      body:
          BlocBuilder<SearchBloc, SearchState>(builder: (context, searchState) {
        return Column(
          children: [
            SizedBox(
                height: searchState.isSearchProducts ? 122 : 80,
                child: SearchScreenTopbar()),

            if (searchState.isSearchProducts)
              Expanded(
                child: SearchProductWidget(
                  searchController: searchProductController,
                  scrollController: _scrollProductController,
                ),
              )
            else
              Expanded(
                child: SearchCompanyWidget(
                  searchController: searchCompanyController,
                  scrollController: _scrollCompanyController,
                ),
              ),

            // Expanded(
            //   child: Column(
            //     children: [

            //     ],
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
