import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_favorite_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_images.dart';
import 'package:el_biz/view/screen/tender/new_tende2_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../bloc/tender_detail/tender_detail_bloc.dart';
import '../../../data/model/response/chat/chat_list_model.dart';
import '../../../data/model/response/company/company_product_model.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_button.dart';
import '../chat/chat_conversation.dart';
import '../company/company_page_screen.dart';

class TenderDetailScreen extends StatelessWidget {
  // final bool isProduct;
  final String tenderName;

  const TenderDetailScreen({super.key, required this.tenderName});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text(tenderName),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorResources.primary,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                  color: Color.fromRGBO(16, 24, 40, 0.05),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(Images.svgAlert),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: BlocBuilder<TenderDetailBloc, TenderDetailState>(
          builder: (context, productDetialController) {
        if (productDetialController is TenderDetailLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productDetialController is TenderDetailError) {
          return Center(
            child: Text('error'),
          );
        }
        if (productDetialController.tenderDetailModel?.data == null) {
          return SizedBox.shrink();
        }
        var tenderDetail = productDetialController.tenderDetailModel!;
        // if (productDetialController is TenderDetailSuccess) {
        //   tenderDetail = productDetialController.tenderDetailModel;
        // }
        // tenderDetail = productDetialController.tenderDetailModel;
        print(
            'this is the favorite option in tender detail = ${tenderDetail.data?.isFavorite ?? false}');
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ProductImages(
                  image: tenderDetail.data?.media ?? [],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(16, 24, 40, 0.06),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tenderDetail.data?.title ?? '',
                            // 'Стул раскладной hrer update',
                            style: h24.copyWith(color: ColorResources.darkGray),
                          ),
                        ),
                        CustomFavoriteButton(
                          isFavorite: tenderDetail.data?.isFavorite ?? false,
                          onTap: () {
                            context.read<TenderDetailBloc>().add(
                                ToggleTenderDetailFavorite(
                                    tenderId: tenderDetail.data!.id!,
                                    context: context));
                          },
                        ),
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   padding: const EdgeInsets.all(10),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     border: Border.all(
                        //         width: 1, color: ColorResources.lgColor),
                        //     borderRadius: BorderRadius.circular(12),
                        //     boxShadow: const [
                        //       BoxShadow(
                        //         blurRadius: 2,
                        //         spreadRadius: 0,
                        //         offset: Offset(0, 1),
                        //         color: Color.fromRGBO(16, 24, 40, 0.05),
                        //       ),
                        //     ],
                        //   ),
                        //   alignment: Alignment.center,
                        //   child: SvgPicture.asset(Images.svgHeartBorder),
                        // ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Описание',
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      tenderDetail.data?.description ?? '',
                      // 'Ищу поставщиков садовой мебели, конкретно раскладных стульев хорошего качества, из натуральных материалов, с интересным дизайном, 20 штук желательно похожих или в двух расцветках.',
                      style: body14.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    productInfoWidget(
                        title: 'Товар: ',
                        value: 'Количество',
                        titleBold: true,
                        valueBold: true),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tenderDetail.data?.tenderProducts?.length ?? 0,
                      itemBuilder: (context, index) {
                        final tenderProduct =
                            tenderDetail.data!.tenderProducts![index];
                        return productInfoWidget(
                            title: tenderProduct.productName,
                            value:
                                "${tenderProduct.quantity} ${tenderProduct.unit}"
                            // '20шт',
                            );
                      },
                    ),
                    // productInfoWidget(title: 'Диваны', value: '20шт'),
                    // productInfoWidget(title: 'Шкафы', value: '20шт'),
                    // productInfoWidget(
                    //     title: 'Бюджет: ',
                    //     value: '50 000 сом',
                    //     valueBold: true),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Опубликовано: ',
                          style: body14.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          formatDateInRu(
                              tenderDetail.data!.createdAt.toString()),
                          // '24.10.2024, 18:10',
                          style: body14.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    // ],
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (tenderDetail.data?.company != null) {
                    context.read<CompanyDetailBloc>().add(GetCompanyDetail(
                        tenderDetail.data!.company!.id.toString()));
                    Get.to(() => CompanyPageScreen());
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: -2,
                        offset: Offset(0, 2),
                        color: Color.fromRGBO(16, 24, 40, 0.06),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorResources.lightBlue,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 1, color: ColorResources.lgColor),
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          leading: CustomImage(
                              image: tenderDetail.data!.company?.logo ?? '',
                              height: 40,
                              width: 40,
                              radius: 40),
                          title: Text(
                            tenderDetail.data!.company?.name ?? '',
                            // 'Садовая мебель Loft',
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                          subtitle: Text(
                            tenderDetail.data!.company?.owner?.name ?? '',
                            // 'ОсОО...',
                            style:
                                body14.copyWith(color: ColorResources.darkGray),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (tenderDetail.data!.company?.verificationStatus ==
                          'verified')
                        Row(
                          children: [
                            SvgPicture.asset(Images.svgVerified),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'verified_supplier'.tr,
                                style:
                                    body14.copyWith(color: ColorResources.gray),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // const SimilarProductsWidget(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BlocBuilder<TenderDetailBloc, TenderDetailState>(
        builder: (context, state) {
          if (state is TenderDetailLoading ||
              state is TenderDetailError ||
              state.tenderDetailModel?.data == null) {
            return SizedBox.shrink();
          }

          var tenderDetail = state.tenderDetailModel!;
          // if (state is TenderDetailSuccess) {
          //   tenderDetail = state.tenderDetailModel;
          // }
          return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
            if ((userState.selectedAccountModel!.isUser == true &&
                    tenderDetail.data!.company!.owner!.id ==
                        userState.selectedAccountModel!.userId) ||
                (userState.selectedAccountModel!.isUser == false &&
                    userState.selectedAccountModel!.companyId ==
                        tenderDetail.data!.company!.id)) {
              return BottomAppBar(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomBorderButton(
                        height: Get.height,
                        width: Get.width,
                        padding: const EdgeInsets.all(0),
                        border:
                            Border.all(width: 1, color: ColorResources.blue),
                        borderRadius: BorderRadius.circular(12),
                        boxShaow: const [ColorResources.shadow1],
                        child: Text(
                          "edit".tr,
                          style: button16.copyWith(color: ColorResources.blue),
                        ),
                        onTap: () {
                          Get.to(() => NewTende2Screen(isEdit: true));
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Expanded(
                    //   child: CustomBorderButton(
                    //     height: Get.height,
                    //     width: Get.width,
                    //     padding: const EdgeInsets.all(0),
                    //     border: Border.all(width: 1, color: ColorResources.red),
                    //     borderRadius: BorderRadius.circular(12),
                    //     boxShaow: const [ColorResources.shadow1],
                    //     child: Text(
                    //       "not_active".tr,
                    //       style: button16.copyWith(color: ColorResources.red),
                    //     ),
                    //     onTap: () {},
                    //   ),
                    // ),
                    Expanded(
                      child: CustomBorderButton(
                        height: Get.height,
                        width: Get.width,
                        padding: const EdgeInsets.all(0),
                        border: Border.all(width: 1, color: ColorResources.red),
                        borderRadius: BorderRadius.circular(12),
                        boxShaow: const [ColorResources.shadow1],
                        onTap: state.statusUpdating
                            ? () {}
                            : () {
                                context
                                    .read<TenderDetailBloc>()
                                    .add(ChangeTenderStatus(
                                      tenderDetail.data!.id.toString(),
                                      tenderDetail.data!.activeStatus ==
                                              'active'
                                          ? 'inactive'
                                          : 'active',
                                      context,
                                    ));
                              },
                        child: state.statusUpdating
                            ? SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator())
                            : Text(
                                tenderDetail.data!.activeStatus ?? '',
                                //  == 'published'
                                //     ? "not_active".tr
                                //     : 'active'.tr,
                                style: button16.copyWith(
                                    color: ColorResources.red),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.tenderDetailModel!.data!.company?.owner?.id !=
                userState.userInfo!.data!.id) {
              return BottomAppBar(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: CustomButton(
                    width: Get.width,
                    height: 56,
                    onTap: () {
                      String tenderUserId = state
                          .tenderDetailModel!.data!.company!.owner!.id
                          .toString();

                      String myUserId = userState.userInfo!.data!.id.toString();
                      final myUser = userState.userInfo?.data;
                      ChatItem chatItem = ChatItem(
                        chatId: 0,
                        // int.parse(getChatId(userState, state)),
                        firebaseChatId:
                            "tender_${state.tenderDetailModel?.data?.id}_user_$myUserId",
                        type: 'tender',
                        product: ProductListItem(),
                        tender: TenderItem(
                          id: state.tenderDetailModel!.data!.id,
                          title: state.tenderDetailModel!.data!.title,
                          description:
                              state.tenderDetailModel!.data!.description,
                          budgetFrom: state.tenderDetailModel!.data!.budgetFrom,
                          budgetTo: state.tenderDetailModel!.data!.budgetTo,
                          quantity: state.tenderDetailModel!.data!.quantity
                              .toString(),
                          status: state.tenderDetailModel!.data!.status,
                          image: state.tenderDetailModel!.data!.media
                                      ?.isNotEmpty ==
                                  true
                              ? state.tenderDetailModel!.data!.media![0].url
                              : '',
                        ),
                        user: User(
                          id: myUser?.id,
                          name: myUser?.name,
                          image: myUser?.image,
                          phone: myUser?.phone,
                          email: myUser?.email,
                          fcmToken: myUser?.fcmToken,
                        ),
                        company: state.tenderDetailModel!.data!.company,
                        lastMessage: state.tenderDetailModel!.data!.title,
                        lastMessageDate:
                            state.tenderDetailModel!.data!.createdAt,
                        userUnreadCount: 0,
                        productOwnerUnreadCount: 0,
                        createdAt: state.tenderDetailModel!.data!.createdAt,
                      );
                      Get.to(() => ChatConversation(
                            chatItem: chatItem,
                            isFirstMessage: true,
                            // isSeller: false,
                            // product: ProductListItem(),
                            // tender: TenderItem(
                            //   id: state.tenderDetailModel!.data!.id,
                            //   title: state.tenderDetailModel!.data!.title,
                            //   description:
                            //       state.tenderDetailModel!.data!.description,
                            //   budgetFrom:
                            //       state.tenderDetailModel!.data!.budgetFrom,
                            //   budgetTo: state.tenderDetailModel!.data!.budgetTo,
                            //   quantity: state.tenderDetailModel!.data!.quantity
                            //       .toString(),
                            //   status: state.tenderDetailModel!.data!.status,
                            //   image: state.tenderDetailModel!.data!.media
                            //               ?.isNotEmpty ==
                            //           true
                            //       ? state.tenderDetailModel!.data!.media![0].url
                            //       : '',
                            // ),
                            // tenderId: tenderDetail.data!.id.toString(),
                            // type: 'tender',
                            // // tender: tenderDetail.data!,
                            // // tenderName: tenderDetail.data!.title ?? '',
                            // receiverId: tenderUserId,
                            // // getReceiverId(userState, state),
                            // senderId: myUserId,
                            // isFirstMessage: true,
                            // // productId: '0',
                            // firebaseChatId:
                            //     "tender_${state.tenderDetailModel?.data?.id}_user_$myUserId",
                            // productName:
                            //     state.tenderDetailModel?.data?.title ?? '',
                            // productPrice:
                            //     "${state.tenderDetailModel?.data?.budgetFrom}-${state.tenderDetailModel?.data?.budgetTo}",

                            // productUserId: state.tenderDetailModel?.data
                            //         ?.company?.owner?.id ??
                            //     0,
                            // companyId:
                            //     state.tenderDetailModel?.data?.company?.id ?? 0,
                          ));
                    },
                    title: 'Чат с продавцом'),
              );
            } else {
              return SizedBox.shrink();
            }
          });
        },
      ),
    );
  }

  Widget productInfoWidget(
      {String? title,
      String? value,
      bool titleBold = false,
      bool valueBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        children: [
          Text(
            title ?? '',
            style: body14.copyWith(
              color: titleBold ? ColorResources.darkGray : ColorResources.gray,
              fontWeight: titleBold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
              style: body14.copyWith(
                color:
                    titleBold ? ColorResources.darkGray : ColorResources.gray,
                fontWeight: valueBold ? FontWeight.w700 : FontWeight.w400,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
