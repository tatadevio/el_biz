import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../bloc/auction/auctions/auctions_bloc.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../base/auction_grid_item.dart';
import '../../../../base/auction_list_item.dart';

class ActiveAuctionsWidget extends StatefulWidget {
  final String sortOrder;
  final String orderBy;
  const ActiveAuctionsWidget(
      {super.key, this.sortOrder = 'asc', this.orderBy = 'created_at'});

  @override
  State<ActiveAuctionsWidget> createState() => _ActiveAuctionsWidgetState();
}

class _ActiveAuctionsWidgetState extends State<ActiveAuctionsWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;
  // String sortOrder = 'asc';
  // String orderBy = 'created_at';

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
      final publicAuctionsBloc = context.read<AuctionsBloc>();

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !publicAuctionsBloc.state.isLoading &&
          !publicAuctionsBloc.state.isLoadingMore) {
        if (publicAuctionsBloc.state.isFilterEnable) {
          // Handle filtered tenders pagination
          print(
              'going to call the filtered tenders pagination - Total Pages: ${publicAuctionsBloc.state.filteredTotalPages}, Current Page: ${publicAuctionsBloc.state.filteredCurrentpage}');

          if (publicAuctionsBloc.state.filteredCurrentpage <
              publicAuctionsBloc.state.filteredTotalPages) {
            // int nextPage = publicAuctionsBloc.state.filteredCurrentpage + 1;

            // publicAuctionsBloc.add(FilterPublicAuctionsProduct(
            //     productFilterValuesModel:
            //         publicTenderBloc.state.tenderFilterValuesModel!,
            //     currentPage: nextPage));
          }
        } else {
          // Handle regular tenders pagination
          print(
              'going to call the tenders list pagination - Total Pages: ${publicAuctionBloc.state.totalPages}, Current Page: ${publicAuctionBloc.state.currentPage}');

          if (publicAuctionBloc.state.currentPage <
              publicAuctionBloc.state.totalPages) {
            int nextPage = publicAuctionBloc.state.currentPage + 1;

            publicAuctionBloc.add(GetAuctions(
              page: nextPage,
              isRefresh: false,
              direction: widget.sortOrder,
              orderBy: widget.orderBy,
            ));
          }
        }
      }
    });
  }

  late AuctionsBloc publicAuctionBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    publicAuctionBloc = context.read<AuctionsBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    publicAuctionBloc.add(UpdateAuctionsFilterEnable(false));
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
    return Stack(
      children: [
        BlocBuilder<AuctionsBloc, AuctionsState>(
          builder: (context, auctionsController) {
            return BlocBuilder<AuctionsBloc, AuctionsState>(
                builder: (context, pTenderState) {
              if (auctionsController.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (auctionsController.auctions.isEmpty &&
                  !auctionsController.isFilterEnable) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<AuctionsBloc>().add(GetAuctions(
                          page: 1,
                          isRefresh: true,
                          direction: widget.sortOrder,
                          orderBy: widget.orderBy,
                        ));
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: Get.height * 0.7,
                      child: Center(
                        child: Text('no_auction_found'.tr),
                      ),
                    ),
                  ),
                );
              }
              if (auctionsController.filteredAuctions.isEmpty &&
                  auctionsController.isFilterEnable) {
                return RefreshIndicator(
                  onRefresh: () async {
                    // context.read<PublicTenderBloc>().add(
                    //     FilterPublicTenderProduct(
                    //         productFilterValuesModel:
                    //             publicTenderState.tenderFilterValuesModel!,
                    //         currentPage: 1));
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: Get.height * 0.7,
                      child: Center(
                        child: Text('no_auction_found'.tr),
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RefreshIndicator(
                  onRefresh: () async {
                    if (auctionsController.isFilterEnable) {
                      // context.read<PublicTenderBloc>().add(
                      //     FilterPublicTenderProduct(
                      //         productFilterValuesModel:
                      //             publicTenderState.tenderFilterValuesModel!,
                      //         currentPage: 1));
                    } else {
                      context.read<AuctionsBloc>().add(GetAuctions(
                            page: 1,
                            isRefresh: true,
                            direction: widget.sortOrder,
                            orderBy: widget.orderBy,
                          ));
                    }
                  },
                  child: auctionsController.isGridView
                      ? SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
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
                                        childAspectRatio: 0.52),
                                itemCount: auctionsController.isFilterEnable
                                    ? auctionsController.filteredAuctions.length
                                    : auctionsController.auctions.length,
                                itemBuilder: (context, index) {
                                  return AuctionGridItem(
                                    auction: auctionsController.isFilterEnable
                                        ? auctionsController
                                            .filteredAuctions[index]
                                        : auctionsController.auctions[index],
                                    isPublicAuction: true,
                                    isCompanyAuction: false,
                                    isSearchAuction: false,
                                  );
                                },
                              ),
                              if (auctionsController.isLoadingMore)
                                const Center(
                                  child: CircularProgressIndicator(),
                                ).paddingOnly(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom),
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
                                itemCount: auctionsController.isFilterEnable
                                    ? auctionsController.filteredAuctions.length
                                    : auctionsController.auctions.length,
                                itemBuilder: (context, index) {
                                  return AuctionListItemWidget(
                                    auction: auctionsController.isFilterEnable
                                        ? auctionsController
                                            .filteredAuctions[index]
                                        : auctionsController.auctions[index],
                                    isPublicAuction: true,
                                    isCompanyAuction: false,
                                    isSearchAuction: false,
                                  );
                                },
                              ),
                              if (auctionsController.isLoadingMore)
                                const Center(
                                  child: CircularProgressIndicator(),
                                ).paddingOnly(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom),
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
    );
  }
}
