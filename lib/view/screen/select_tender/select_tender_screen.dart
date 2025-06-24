import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/bloc/tenders/tenders_state.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/filter/tender_filter/tender_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/filter_fields/filter_fields_bloc.dart';
import '../../base/custom_button.dart';
import '../../base/tender_grid_item.dart';
import '../../base/tender_list_item.dart';

class SelectTenderScreen extends StatefulWidget {
  final ValueChanged<TenderItem?> onSelect;
  final List<int> alreadySelectedItems;
  const SelectTenderScreen(
      {super.key, required this.onSelect, required this.alreadySelectedItems});

  @override
  State<SelectTenderScreen> createState() => _SelectTenderScreenState();
}

class _SelectTenderScreenState extends State<SelectTenderScreen> {
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

      final tenderBloc = context.read<PublicTenderBloc>();
      if (tenderBloc.state.isFilterEnable) {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 300 &&
            !tenderBloc.state.isLoading &&
            !tenderBloc.state.isMoreLoading) {
          int pageSize = tenderBloc.state.filterTenderPageSize;
          if (tenderBloc.state.filterTenderCurrentPage < pageSize) {
            int nextPage = tenderBloc.state.filterTenderCurrentPage;

            context.read<PublicTenderBloc>().add(FilterPublicTenderProduct(
                  productFilterValuesModel:
                      tenderBloc.state.tenderFilterValuesModel!,
                  currentPage: nextPage + 1,
                ));
          }
        }
      } else {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 300 &&
            !tenderBloc.state.isLoading &&
            !tenderBloc.state.isMoreLoading) {
          int pageSize = tenderBloc.state.tenderPageSize;
          if (tenderBloc.state.tenderCurrentPage < pageSize) {
            int nextPage = tenderBloc.state.tenderCurrentPage;

            context
                .read<PublicTenderBloc>()
                .add(GetPublicTender(nextPage + 1, direction: 'asc'));
          }
        }
      }
    });
  }

  late PublicTenderBloc publicTenderBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    publicTenderBloc = context.read<PublicTenderBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    publicTenderBloc.add(UpdateTenderFilterEnable(false));
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'tender'.tr,
                  style: h16.copyWith(color: ColorResources.blackText),
                ),
              ),
              // Container(
              //   height: 40,
              //   width: 40,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       width: 1,
              //       color: ColorResources.lgColor,
              //     ),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   alignment: Alignment.center,
              //   child: SvgPicture.asset(Images.svgSearch),
              // ),
              const SizedBox(
                width: 10,
              ),
              // InkWell(
              //   onTap: () {
              //     // context.read<CategoryBloc>().add(GetCategory());
              //     Get.to(() => SelectCategoryScreen(
              //           onSelect: (selectedCategories) {
              //             for (var category in selectedCategories) {
              //               print(
              //                   'these are the selected categoris : ${category.toJson()}');
              //             }
              //             context
              //                 .read<TendersBloc>()
              //                 .state
              //                 .newTenderModel
              //                 .categories = selectedCategories;
              //             Get.to(() => NewTende2Screen());
              //           },
              //         ));
              //     // Get.to(() => const MainCategories(
              //     //     type: true, fromHome: true, screenName: '/AddNewTender'));
              //     // Get.to(() => const AddProductScreen());
              //   },
              //   child: Container(
              //     height: 40,
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(
              //         12,
              //       ),
              //       color: ColorResources.green,
              //       boxShadow: const [
              //         BoxShadow(
              //           blurRadius: 2,
              //           spreadRadius: 0,
              //           offset: Offset(0, 1),
              //           color: Color.fromRGBO(16, 24, 40, 0.05),
              //         ),
              //       ],
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         SvgPicture.asset(
              //           Images.svgPlus,
              //         ),
              //         const SizedBox(
              //           width: 5,
              //         ),
              //         Text(
              //           'new_tender'.tr,
              //           style: button16,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: BlocBuilder<TendersBloc, TendersState>(
                builder: (context, tendersController) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    BlocBuilder<PublicTenderBloc, PublicTenderState>(
                        builder: (context, publicTenderState) {
                      return Stack(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              context
                                  .read<FilterFieldsBloc>()
                                  .add(GetFilterFields());
                              // Get.to(() =>
                              //     const ProductsFilterScreen(isTenderFilter: true));
                              Get.to(() => TenderFilterScreen());
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                color: ColorResources.green,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    offset: Offset(0, 1),
                                    color: Color.fromRGBO(16, 24, 40, 0.05),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    Images.filter,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'filter'.tr,
                                    style: button16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (publicTenderState.isFilterEnable)
                            Positioned(
                              top: 5,
                              right: 6,
                              child: CircleAvatar(
                                radius: 3,
                                backgroundColor: ColorResources.red,
                              ),
                            ),
                        ],
                      );
                    }),
                    //
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          border: Border.all(
                              width: 1, color: ColorResources.lgColor),
                          color: ColorResources.lightBlue,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1),
                              color: Color.fromRGBO(16, 24, 40, 0.05),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Images.svgArrowUpDown,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'new'.tr,
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        context
                            .read<TendersBloc>()
                            .add(const UpdateGridView(true));
                        // tendersController.updateGridView(true);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: tendersController.isGridView
                              ? ColorResources.primary
                              : null,
                          border: Border.all(
                            width: 1,
                            color: tendersController.isGridView
                                ? ColorResources.primary
                                : ColorResources.lgColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgCategory,
                          color: tendersController.isGridView
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
                        context
                            .read<TendersBloc>()
                            .add(const UpdateGridView(false));
                        // tendersController.updateGridView(false);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: tendersController.isGridView
                              ? null
                              : ColorResources.primary,
                          border: Border.all(
                            width: 1,
                            color: !tendersController.isGridView
                                ? ColorResources.primary
                                : ColorResources.lgColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgList,
                          color: !tendersController.isGridView
                              ? ColorResources.white
                              : ColorResources.gray,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
      body: Stack(
        children: [
          BlocBuilder<TendersBloc, TendersState>(
            builder: (context, tendersController) {
              return BlocBuilder<PublicTenderBloc, PublicTenderState>(
                  builder: (context, publicTenderState) {
                if (publicTenderState.isLoading) {
                  return Center(
                    child: Text('no_tender_found'.tr),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:
                      // SizedBox(),
                      // there tender list and tender grid have to update
                      tendersController.isGridView
                          ? GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.65),
                              itemCount: publicTenderState.isFilterEnable
                                  ? publicTenderState.filterTenders.length
                                  : publicTenderState.publicTenders.length,
                              itemBuilder: (context, index) {
                                return TenderGridItem(
                                  tender: publicTenderState.isFilterEnable
                                      ? publicTenderState.filterTenders[index]
                                      : publicTenderState.publicTenders[index],
                                  isCompanyTender: false,
                                  isPublicTender: false,
                                  isSelect: true,
                                  isAlreadySelect: widget.alreadySelectedItems
                                      .contains(publicTenderState
                                          .publicTenders[index].id),
                                );
                              },
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: publicTenderState.isFilterEnable
                                  ? publicTenderState.filterTenders.length
                                  : publicTenderState.publicTenders.length,
                              itemBuilder: (context, index) {
                                return TenderListItem(
                                  tender: publicTenderState.isFilterEnable
                                      ? publicTenderState.filterTenders[index]
                                      : publicTenderState.publicTenders[index],
                                  isCompanyTender: false,
                                  isPublicTender: true,
                                  isSelect: true,
                                  isAlreadySelect: widget.alreadySelectedItems
                                      .contains(publicTenderState
                                          .publicTenders[index].id),
                                );
                              },
                            ),
                );
              });
            },
          ),
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
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: CustomButton(
              width: Get.width,
              height: Get.height,
              onTap: () {
                widget.onSelect(
                  context.read<TendersBloc>().state.selectedTender,
                );
              },
              title: 'send'.tr)),
    );
  }
}
