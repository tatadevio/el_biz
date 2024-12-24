import 'package:el_biz/bloc/favorite/favorite_bloc.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/base/product_list_item.dart';
import 'package:el_biz/view/base/tender_grid_item.dart';
import 'package:el_biz/view/base/tender_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/product_grid_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'favorites'.tr,
          style: h16.copyWith(color: ColorResources.blackText),
        ),
        actions: const [
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, favoriteState) {
            return Container(
              // decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.0), bottomRight: Radius.circular(24.0))),
              color: ColorResources.background,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: SizedBox(
                      height: height * 0.06,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<FavoriteBloc>().add(const UpdateShowCategories(true));
                                },
                                child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(6),
                                    border: Border(
                                      bottom: BorderSide(
                                        width: favoriteState.isShowCategories ? 2 : 1,
                                        color: favoriteState.isShowCategories ? ColorResources.blue : ColorResources.lgColor,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Закупки".tr,
                                    style: mediumTextStyle.copyWith(
                                      color: favoriteState.isShowCategories ? ColorResources.primary : ColorResources.black,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<FavoriteBloc>().add(const UpdateShowCategories(false));
                                },
                                child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: !favoriteState.isShowCategories ? 2 : 1,
                                        color: !favoriteState.isShowCategories ? ColorResources.blue : ColorResources.lgColor,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text("goods".tr,
                                          style: mediumTextStyle.copyWith(
                                            color: !favoriteState.isShowCategories ? ColorResources.primary : ColorResources.black,
                                          ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // if (!favoriteState.isShowCategories) ...[
                      // const SizedBox(width: 10),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          context.read<FavoriteBloc>().add(const UpdateShowGridView(true));
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: favoriteState.isShowGridView ? ColorResources.primary : null,
                            border: Border.all(
                              width: 1,
                              color: favoriteState.isShowGridView ? ColorResources.primary : ColorResources.lgColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            Images.svgCategory,
                            color: favoriteState.isShowGridView ? ColorResources.white : ColorResources.gray,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          context.read<FavoriteBloc>().add(const UpdateShowGridView(false));
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: favoriteState.isShowGridView ? null : ColorResources.primary,
                            // border: Border.all(
                            //   width: 1,
                            //   color: !favoriteState.isShowGridView ? ColorResources.primary : ColorResources.lgColor,
                            // ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            Images.svgList,
                            color: !favoriteState.isShowGridView ? ColorResources.white : ColorResources.gray,
                          ),
                        ),
                      ),
                      // ],
                      const SizedBox(
                        width: 10,
                      ),
                    ],
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state.isShowCategories) {
              return state.isShowGridView
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.7),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const TenderGridItem(
                          isFavorite: true,
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const TenderListItem(
                          isFavorite: true,
                        );
                      },
                    );
            }
            return state.isShowGridView
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.7),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ProductGridItem(
                        isFavorite: true,
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ProductListItem(
                        isFavorite: true,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
