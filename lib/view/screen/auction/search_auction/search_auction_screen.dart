import 'package:el_biz/bloc/auction/search_auction/search_auction_bloc.dart';
import 'package:el_biz/bloc/search/search_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/screen/auction/search_auction/widgets/search_auctions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class SearchAuctionScreen extends StatefulWidget {
  const SearchAuctionScreen({super.key});

  @override
  State<SearchAuctionScreen> createState() => _SearchAuctionScreenState();
}

class _SearchAuctionScreenState extends State<SearchAuctionScreen> {
  final TextEditingController searchProductController = TextEditingController();
  final ScrollController _scrollProductController = ScrollController();

  late SearchAuctionBloc searchBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchBloc = context.read<SearchAuctionBloc>();
  }

  @override
  void dispose() {
    _scrollProductController.dispose();
    searchBloc.add(ClearSearchAuctionList());
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
                            .read<SearchAuctionBloc>()
                            .add(SearchAuction(search: val, currentPage: 1));
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
                    context
                        .read<SearchAuctionBloc>()
                        .add(ClearSearchAuctionList());
                  },
                  child: Text(
                    'cancel'.tr,
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                ),
              ],
            );
          }),
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
                    const Divider(
                      height: 0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        body: SearchAuctionsWidget(
          searchController: searchProductController,
          scrollController: _scrollProductController,
        ));
  }
}
