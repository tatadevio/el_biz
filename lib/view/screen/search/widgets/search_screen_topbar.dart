import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/search/search_bloc.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class SearchScreenTopbar extends StatelessWidget {
  const SearchScreenTopbar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0))),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
              child: SizedBox(
                // height: height * 0.06,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context
                                .read<SearchBloc>()
                                .add(ChangeStatusSearch(false));
                            // productController.changeStatusSearch(0);
                          },
                          child: Container(
                            // height: height * 0.06,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: ColorResources.lightBlue,
                              boxShadow: searchState.isSearchProducts == false
                                  ? const [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 0,
                                        offset: Offset(0, 1),
                                        color: Color.fromRGBO(16, 24, 40, 0.06),
                                      ),
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 3,
                                        offset: Offset(0, 1),
                                        color: Color.fromRGBO(16, 24, 40, 0.1),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                                child: Text(
                              "Компании".tr,
                              style: mediumTextStyle.copyWith(
                                color: searchState.isSearchProducts == false
                                    ? ColorResources.primary
                                    : ColorResources.black,
                              ),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context
                                .read<SearchBloc>()
                                .add(ChangeStatusSearch(true));
                            // productController.changeStatusSearch(1);
                          },
                          child: Container(
                            // height: height * 0.06,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // color: productController.showFavSearch == 1 ? ColorResources.primary : ColorResources.background,
                              color: ColorResources.lightBlue,
                              boxShadow: searchState.isSearchProducts
                                  ? const [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 0,
                                        offset: Offset(0, 1),
                                        color: Color.fromRGBO(16, 24, 40, 0.06),
                                      ),
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 3,
                                        offset: Offset(0, 1),
                                        color: Color.fromRGBO(16, 24, 40, 0.1),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                                child: Text("goods".tr,
                                    style: mediumTextStyle.copyWith(
                                      color: searchState.isSearchProducts
                                          ? ColorResources.primary
                                          : ColorResources.black,
                                    ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (searchState.isSearchProducts)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // productController.updateGridView(true);

                        context
                            .read<SearchBloc>()
                            .add(const UpdateGridView(true));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: searchState.isGridView
                              ? ColorResources.primary
                              : null,
                          border: Border.all(
                            width: 1,
                            color: searchState.isGridView
                                ? ColorResources.primary
                                : ColorResources.lgColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgCategory,
                          color: searchState.isGridView
                              ? ColorResources.white
                              : ColorResources.gray,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // productController.updateGridView(false);
                        context
                            .read<SearchBloc>()
                            .add(const UpdateGridView(false));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: searchState.isGridView
                              ? null
                              : ColorResources.primary,
                          border: Border.all(
                            width: 1,
                            color: !searchState.isGridView
                                ? ColorResources.primary
                                : ColorResources.lgColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgList,
                          color: !searchState.isGridView
                              ? ColorResources.white
                              : ColorResources.gray,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            // else
            //   SizedBox(
            //     height: 35,
            //   ),
          ],
        ),
      );
    });
  }
}
