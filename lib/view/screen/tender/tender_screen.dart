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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
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
                          setState(() {
                            direction = direction == 'asc' ? 'desc' : 'asc';
                          });
                          context
                              .read<PublicTenderBloc>()
                              .add(GetPublicTender(1, direction: direction));
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
                                isPublicTender: true,
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
                              );
                            },
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
