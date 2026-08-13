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
import '../search/widgets/search_screen_topbar.dart';

class SearchPublicCompaniesScreen extends StatefulWidget {
  const SearchPublicCompaniesScreen({super.key});

  @override
  State<SearchPublicCompaniesScreen> createState() =>
      _SearchPublicCompaniesScreenState();
}

class _SearchPublicCompaniesScreenState
    extends State<SearchPublicCompaniesScreen> {
  // final TextEditingController searchProductController = TextEditingController();
  final TextEditingController searchCompanyController = TextEditingController();
  // final ScrollController _scrollProductController = ScrollController();
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
    // _scrollProductController.dispose();
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
      ),
      body:
          BlocBuilder<SearchBloc, SearchState>(builder: (context, searchState) {
        return SearchCompanyWidget(
          searchController: searchCompanyController,
          scrollController: _scrollCompanyController,
        );

        // Column(
        //   children: [
        //     // SizedBox(
        //     //     height: searchState.isSearchProducts ? 122 : 80,
        //     //     child: SearchScreenTopbar()),

        //     // if (searchState.isSearchProducts)
        //     //   Expanded(
        //     //     child: SearchProductWidget(
        //     //       searchController: searchProductController,
        //     //       scrollController: _scrollProductController,
        //     //     ),
        //     //   )
        //     // else
        //     // Expanded(
        //     //   child: SearchCompanyWidget(
        //     //     searchController: searchCompanyController,
        //     //     scrollController: _scrollCompanyController,
        //     //   ),
        //     // ),

        //     // Expanded(
        //     //   child: Column(
        //     //     children: [

        //     //     ],
        //     //   ),
        //     // ),
        //   ],
        // );
      }),
    );
  }
}
