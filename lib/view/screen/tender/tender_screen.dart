import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/bloc/tenders/tenders_state.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/category/select_category_screen.dart';
import 'package:el_biz/view/screen/filter/tender_filter/tender_filter_screen.dart';
import 'package:el_biz/view/screen/tender/new_tende2_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/filter_fields/filter_fields_bloc.dart';
import '../../base/tender_grid_item.dart';
import '../../base/tender_list_item.dart';
import '../search/search_tender/search_tender_screen.dart';

class TenderScreen extends StatefulWidget {
  const TenderScreen({super.key});

  @override
  State<TenderScreen> createState() => _TenderScreenState();
}

class _TenderScreenState extends State<TenderScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;
  String direction = 'asc';
  String orderBy = 'created_at';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show/hide scroll to top button
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }

      // Pagination logic
      final publicTenderBloc = context.read<PublicTenderBloc>();

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !publicTenderBloc.state.isLoading &&
          !publicTenderBloc.state.isMoreLoading) {
        if (publicTenderBloc.state.isFilterEnable) {
          // Handle filtered tenders pagination
          print(
              'going to call the filtered tenders pagination - Total Pages: ${publicTenderBloc.state.filterTenderPageSize}, Current Page: ${publicTenderBloc.state.filterTenderCurrentPage}');

          if (publicTenderBloc.state.filterTenderCurrentPage <
              publicTenderBloc.state.filterTenderPageSize) {
            int nextPage = publicTenderBloc.state.filterTenderCurrentPage + 1;

            publicTenderBloc.add(FilterPublicTenderProduct(
                productFilterValuesModel:
                    publicTenderBloc.state.tenderFilterValuesModel!,
                currentPage: nextPage));
          }
        } else {
          // Handle regular tenders pagination
          print(
              'going to call the tenders list pagination - Total Pages: ${publicTenderBloc.state.tenderPageSize}, Current Page: ${publicTenderBloc.state.tenderCurrentPage}');

          if (publicTenderBloc.state.tenderCurrentPage <
              publicTenderBloc.state.tenderPageSize) {
            int nextPage = publicTenderBloc.state.tenderCurrentPage + 1;

            publicTenderBloc.add(GetPublicTender(nextPage,
                direction: direction, orderBy: orderBy));
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

  // void _callScrolling(BuildContext context, ScrollController scrollController) {

  // }

  @override
  Widget build(BuildContext context) {
    // _callScrolling(context, _scrollController);
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
              GestureDetector(
                onTap: () {
                  Get.to(() => const SearchTenderScreen());
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorResources.lgColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(Images.svgSearch),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  // context.read<CategoryBloc>().add(GetCategory());
                  Get.to(() => SelectCategoryScreen(
                        onSelect: (selectedCategories) {
                          for (var category in selectedCategories) {
                            print(
                                'these are the selected categoris : ${category.toJson()}');
                          }
                          context
                              .read<TendersBloc>()
                              .state
                              .newTenderModel
                              .categories = selectedCategories;
                          Get.to(() => NewTende2Screen());
                        },
                      ));
                  // Get.to(() => const MainCategories(
                  //     type: true, fromHome: true, screenName: '/AddNewTender'));
                  // Get.to(() => const AddProductScreen());
                },
                child: Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
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
                        Images.svgPlus,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'new_tender'.tr,
                        style: button16,
                      ),
                    ],
                  ),
                ),
              ),
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
                        builder: (context, tenderState) {
                      return Stack(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              context
                                  .read<FilterFieldsBloc>()
                                  .add(GetFilterFields());
                              Get.to(() => TenderFilterScreen());
                              // Get.to(() =>
                              //     const ProductsFilterScreen(isTenderFilter: true));
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
                          if (tenderState.isFilterEnable)
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
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Sort by',
                                            style: h16.copyWith(
                                                color: ColorResources.darkGray,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: const Icon(Icons.close),
                                            color: ColorResources.gray,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            RadioListTile<String>(
                                              value: 'newest',
                                              groupValue: direction == 'desc' &&
                                                      orderBy == 'created_at'
                                                  ? 'newest'
                                                  : null,
                                              onChanged: (value) {
                                                setState(() {
                                                  direction = 'desc';
                                                  orderBy = 'created_at';
                                                });
                                                context
                                                    .read<PublicTenderBloc>()
                                                    .add(GetPublicTender(1,
                                                        direction: direction,
                                                        orderBy: orderBy));
                                                Navigator.pop(context);
                                              },
                                              title: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      Images.svgArrowUpDown),
                                                  const SizedBox(width: 12),
                                                  Text('Newest first',
                                                      style: body14),
                                                ],
                                              ),
                                              activeColor: ColorResources.green,
                                            ),
                                            RadioListTile<String>(
                                              value: 'oldest',
                                              groupValue: direction == 'asc' &&
                                                      orderBy == 'created_at'
                                                  ? 'oldest'
                                                  : null,
                                              onChanged: (value) {
                                                setState(() {
                                                  direction = 'asc';
                                                  orderBy = 'created_at';
                                                });
                                                context
                                                    .read<PublicTenderBloc>()
                                                    .add(GetPublicTender(1,
                                                        direction: direction,
                                                        orderBy: orderBy));
                                                Navigator.pop(context);
                                              },
                                              title: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      Images.svgArrowUpDown),
                                                  const SizedBox(width: 12),
                                                  Text('Oldest first',
                                                      style: body14),
                                                ],
                                              ),
                                              activeColor: ColorResources.green,
                                            ),
                                            RadioListTile<String>(
                                              value: 'az',
                                              groupValue: direction == 'asc' &&
                                                      orderBy == 'title'
                                                  ? 'az'
                                                  : null,
                                              onChanged: (value) {
                                                setState(() {
                                                  direction = 'asc';
                                                  orderBy = 'title';
                                                });
                                                context
                                                    .read<PublicTenderBloc>()
                                                    .add(GetPublicTender(1,
                                                        direction: direction,
                                                        orderBy: orderBy));
                                                Navigator.pop(context);
                                              },
                                              title: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      Images.svgArrowUpDown),
                                                  const SizedBox(width: 12),
                                                  Text('Title (A-Z)',
                                                      style: body14),
                                                ],
                                              ),
                                              activeColor: ColorResources.green,
                                            ),
                                            RadioListTile<String>(
                                              value: 'za',
                                              groupValue: direction == 'desc' &&
                                                      orderBy == 'title'
                                                  ? 'za'
                                                  : null,
                                              onChanged: (value) {
                                                setState(() {
                                                  direction = 'desc';
                                                  orderBy = 'title';
                                                });
                                                context
                                                    .read<PublicTenderBloc>()
                                                    .add(GetPublicTender(1,
                                                        direction: direction,
                                                        orderBy: orderBy));
                                                Navigator.pop(context);
                                              },
                                              title: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      Images.svgArrowUpDown),
                                                  const SizedBox(width: 12),
                                                  Text('Title (Z-A)',
                                                      style: body14),
                                                ],
                                              ),
                                              activeColor: ColorResources.green,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          );

                          // setState(() {
                          //   direction = direction == 'asc' ? 'desc' : 'asc';
                          // });
                          // context
                          //     .read<PublicTenderBloc>()
                          //     .add(GetPublicTender(1, direction: direction));
                        },
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
                if (publicTenderState.isLoading &&
                    publicTenderState.publicTenders.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (publicTenderState.publicTenders.isEmpty) {
                  return Center(
                    child: Text('no_tender_found'.tr),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      if (publicTenderState.isFilterEnable) {
                        context.read<PublicTenderBloc>().add(
                            FilterPublicTenderProduct(
                                productFilterValuesModel:
                                    publicTenderState.tenderFilterValuesModel!,
                                currentPage: 1));
                      } else {
                        context
                            .read<PublicTenderBloc>()
                            .add(GetPublicTender(1, direction: direction));
                      }
                    },
                    child: tendersController.isGridView
                        ? SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                          ? publicTenderState
                                              .filterTenders[index]
                                          : publicTenderState
                                              .publicTenders[index],
                                      isCompanyTender: false,
                                      isPublicTender: true,
                                    );
                                  },
                                ),
                                if (publicTenderState.isMoreLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ).paddingOnly(
                                      bottom: MediaQuery.of(context)
                                          .padding
                                          .bottom),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: publicTenderState.isFilterEnable
                                      ? publicTenderState.filterTenders.length
                                      : publicTenderState.publicTenders.length,
                                  itemBuilder: (context, index) {
                                    return TenderListItem(
                                      tender: publicTenderState.isFilterEnable
                                          ? publicTenderState
                                              .filterTenders[index]
                                          : publicTenderState
                                              .publicTenders[index],
                                      isCompanyTender: false,
                                      isPublicTender: true,
                                    );
                                  },
                                ),
                                if (publicTenderState.isMoreLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ).paddingOnly(
                                      bottom: MediaQuery.of(context)
                                          .padding
                                          .bottom),
                              ],
                            ),
                          ),
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
    );
  }
}
