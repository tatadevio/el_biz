import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../bloc/similar_tenders/similar_tenders_bloc.dart';
import '../../../../bloc/tender_detail/tender_detail_bloc.dart';
import '../../../../helper/date_helper.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_favorite_button.dart';
import '../../../base/custom_image.dart';
import '../../../base/custom_toast.dart';
import '../tender_detail_screen.dart';

class SimilarTenderWidget extends StatelessWidget {
  final String tenderId;
  const SimilarTenderWidget({super.key, required this.tenderId});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final similarTenderBloc = context.read<SimilarTendersBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !similarTenderBloc.state.isLoading &&
          !similarTenderBloc.state.isMoreLoading) {
        int pageSize = similarTenderBloc.state.totalPages;
        if (similarTenderBloc.state.currentPage < pageSize) {
          int nextPage = similarTenderBloc.state.currentPage;

          similarTenderBloc.add(
              GetSimilarTenders(tenderId: tenderId, currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _callScrolling(context, _scrollController);
    return BlocBuilder<SimilarTendersBloc, SimilarTendersState>(
      builder: (context, similarTendersState) {
        print(
            'this is the similar tender state ${similarTendersState.similarTenders.length}');
        return similarTendersState.similarTenders.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Похожие закупки',
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: Get.width * 0.4,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  similarTendersState.similarTenders.length,
                              itemBuilder: (context, index) {
                                return companiesItem(context,
                                    similarTendersState.similarTenders[index]);
                              },
                            ),
                            if (similarTendersState.isMoreLoading)
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

  Widget companiesItem(BuildContext context, TenderItem tender,
      {bool isVerifiedSupplier = false}) {
    double width = Get.width;
    return SizedBox(
      width: width * 0.83,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: InkWell(
          onTap: () {
            if (context.read<AuthBloc>().state.isLoggedIn) {
              context
                  .read<TenderDetailBloc>()
                  .add(GetTenderDetail(tenderId: tender.id.toString()));
              context.read<SimilarTendersBloc>().add(GetSimilarTenders(
                  tenderId: tender.id.toString(), currentPage: 1));
              Get.to(() => TenderDetailScreen(
                    // isProduct: false,
                    tenderName: tender.title ?? '',
                  ));
            } else {
              showShortToast('login_to_view_tender'.tr);
            }
          },
          child: SizedBox(
            height: 120,
            child: Row(
              children: [
                Stack(
                  children: [
                    CustomImage(
                        image: tender.image ?? '',
                        height: 120,
                        width: 100,
                        radius: 16),
                    // if (isSelect && !isAlreadySelect) ...[
                    //   Positioned(
                    //     right: 0,
                    //     top: 0,
                    //     child: CheckBoxTenderButton(
                    //       product: tender,
                    //     ),
                    //   ),
                    // ],
                    // if (isSelect && isAlreadySelect)
                    //   Positioned(
                    //     right: 0,
                    //     top: 0,
                    //     child: Checkbox(
                    //         value: true,
                    //         // checkBoxValue(state.selectedProduct.id ?? [], widget.productId!),
                    //         onChanged: (val) {
                    //           showShortToast("${tender.title} уже добавлен");
                    //         }),
                    //   ),
                    // if (!isSelect)
                    Positioned(
                        right: 5,
                        top: 5,
                        child: CustomFavoriteButton(
                          isFavorite: tender.isFavorite ?? false,
                          onTap: () {
                            context.read<SimilarTendersBloc>().add(
                                ToggleFavoriteSimilarTender(
                                    tenderId: tender.id.toString(),
                                    context: context));
                            // if (isCompanyTender) {
                            //   context.read<CompanyDetailBloc>().add(
                            //       ToggleTenderFavorite(tender.id!, context));
                            // } else if (isSearchTender) {
                            //   context.read<SearchTenderBloc>().add(
                            //       ToggleSearchTenderFavorite(
                            //           tender.id!, context));
                            // } else
                            // if (isPublicTender)
                            // {
                            //   context.read<PublicTenderBloc>().add(
                            //       TogglePublicTenderFavorite(
                            //           tender.id!, context));
                            // }
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
                                'Количество: ',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(71, 84, 103, 1)),
                              ),
                              Text(
                                '${tender.quantity} шт',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body14.copyWith(
                                    color: Color.fromRGBO(71, 84, 103, 1)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Бюджет: ',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(71, 84, 103, 1)),
                              ),
                              Text(
                                '${tender.budgetFrom} - ${tender.budgetTo} сом',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body14.copyWith(
                                    color: Color.fromRGBO(71, 84, 103, 1)),
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
                            'Юр.лицо',
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
