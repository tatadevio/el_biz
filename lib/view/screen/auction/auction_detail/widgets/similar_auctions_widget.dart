import 'package:el_biz/bloc/auction/similar_auctions/similar_auctions_bloc.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../helper/date_helper.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import '../../../../base/custom_favorite_button.dart';
import '../../../../base/custom_image.dart';

class SimilarAuctionWidget extends StatelessWidget {
  final String tenderId;
  const SimilarAuctionWidget({super.key, required this.tenderId});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final similarTenderBloc = context.read<SimilarAuctionsBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !similarTenderBloc.state.isLoading &&
          !similarTenderBloc.state.isMoreLoading) {
        int pageSize = similarTenderBloc.state.totalPages;
        if (similarTenderBloc.state.currentPage < pageSize) {
          int nextPage = similarTenderBloc.state.currentPage;

          similarTenderBloc.add(GetSimilarAuctions(
              auctionId: tenderId, currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _callScrolling(context, _scrollController);
    return BlocBuilder<SimilarAuctionsBloc, SimilarAuctionsState>(
      builder: (context, similarAuctionsState) {
        print(
            'this is the similar tender state ${similarAuctionsState.similarAuctions.length}');
        return similarAuctionsState.similarAuctions.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'similar_purchases'.tr,
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      height: Get.width * 0.4,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  similarAuctionsState.similarAuctions.length,
                              itemBuilder: (context, index) {
                                return similarTenderItem(
                                    context,
                                    similarAuctionsState
                                        .similarAuctions[index]);
                              },
                            ),
                            if (similarAuctionsState.isMoreLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ).paddingOnly(bottom: 80),
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }

  Widget similarTenderItem(BuildContext context, TenderItem tender,
      {bool isVerifiedSupplier = false}) {
    double width = Get.width;
    return SizedBox(
      width: width * 0.83,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: InkWell(
          onTap: () {
            // if (context.read<AuthBloc>().state.isLoggedIn) {
            //   context
            //       .read<TenderDetailBloc>()
            //       .add(GetTenderDetail(tenderId: tender.id.toString()));
            //   context.read<SimilarTendersBloc>().add(GetSimilarTenders(
            //       tenderId: tender.id.toString(), currentPage: 1));
            //   Get.to(() => TenderDetailScreen(
            //         // isProduct: false,
            //         tenderName: tender.title ?? '',
            //       ));
            // } else {
            //   showShortToast('login_to_view_tender'.tr);
            // }
          },
          child: SizedBox(
            height: 120,
            child: Row(
              children: [
                Stack(
                  children: [
                    CustomImage(image: '', height: 120, width: 100, radius: 16),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: CustomFavoriteButton(
                          isFavorite: tender.isFavorite ?? false,
                          onTap: () {
                            // context.read<SimilarTendersBloc>().add(
                            //     ToggleFavoriteSimilarTender(
                            //         tenderId: tender.id.toString(),
                            //         context: context));
                          },
                        )),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tender.title ?? '',
                            // 'Садовая мебель, раскладные стулья',
                            style: h16.copyWith(color: ColorResources.darkGray),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            tender.description ?? '',
                            style: body14.copyWith(color: ColorResources.gray),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'quantity'.tr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(71, 84, 103, 1)),
                              ),
                              Expanded(
                                child: Text(
                                  '${tender.quantity} шт',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: body14.copyWith(
                                      color: Color.fromRGBO(71, 84, 103, 1)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'budget'.tr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(71, 84, 103, 1)),
                              ),
                              Expanded(
                                child: Text(
                                  '${tender.budgetFrom} - ${tender.budgetTo} ${'som'.tr}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: body14.copyWith(
                                      color: Color.fromRGBO(71, 84, 103, 1)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'legal_entity'.tr,
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                          Text(
                            formatDateInRu(tender.createdAt.toString()),
                            style: body14.copyWith(color: ColorResources.gray),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
