import 'package:el_biz/bloc/search/search_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/product_grid_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  controller: searchController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
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
            Text(
              'Отмена',
              style: body14.copyWith(color: ColorResources.gray),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: BlocBuilder<SearchBloc, SearchState>(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5),
                    child: SizedBox(
                      height: height * 0.06,
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
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: ColorResources.lightBlue,
                                    boxShadow:
                                        searchState.isSearchProducts == false
                                            ? const [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 1),
                                                  color: Color.fromRGBO(
                                                      16, 24, 40, 0.06),
                                                ),
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  spreadRadius: 3,
                                                  offset: Offset(0, 1),
                                                  color: Color.fromRGBO(
                                                      16, 24, 40, 0.1),
                                                ),
                                              ]
                                            : [],
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Компании".tr,
                                    style: mediumTextStyle.copyWith(
                                      color:
                                          searchState.isSearchProducts == false
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
                                  height: height * 0.06,
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
                                              color: Color.fromRGBO(
                                                  16, 24, 40, 0.06),
                                            ),
                                            BoxShadow(
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              offset: Offset(0, 1),
                                              color: Color.fromRGBO(
                                                  16, 24, 40, 0.1),
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
                ],
              ),
            );
          }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {
          return GridView.builder(
            // controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7),
            itemCount: searchState.searchProducts.length,
            itemBuilder: (context, index) {
              // return SizedBox();
              return ProductGridItem(
                product: searchState.searchProducts[index],
              
                // product: companyController.,
                // product: index,
              );
            },
          );
        }),
      ),
    );
  }
}
