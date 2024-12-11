import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Отмена',
              style: body14.copyWith(color: ColorResources.gray),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: BlocBuilder<ProductBloc, ProductState>(builder: (context, productController) {
            return Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.0), bottomRight: Radius.circular(24.0))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  //   child: SizedBox(
                  //     height: height * 0.06,
                  //     child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                  //       child: Row(
                  //         children: [
                  //           Expanded(
                  //             child: InkWell(
                  //               onTap: () {
                  //                 productController.changeStatusSearch(0);
                  //               },
                  //               child: Container(
                  //                 height: height * 0.06,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(6),
                  //                   color: ColorResources.lightBlue,
                  //                   boxShadow: productController.showFavSearch == 0
                  //                       ? const [
                  //                           BoxShadow(
                  //                             blurRadius: 2,
                  //                             spreadRadius: 0,
                  //                             offset: Offset(0, 1),
                  //                             color: Color.fromRGBO(16, 24, 40, 0.06),
                  //                           ),
                  //                           BoxShadow(
                  //                             blurRadius: 3,
                  //                             spreadRadius: 3,
                  //                             offset: Offset(0, 1),
                  //                             color: Color.fromRGBO(16, 24, 40, 0.1),
                  //                           ),
                  //                         ]
                  //                       : [],
                  //                 ),
                  //                 child: Center(
                  //                     child: Text(
                  //                   "Компании".tr,
                  //                   style: mediumTextStyle.copyWith(
                  //                     color: productController.showFavSearch == 0 ? ColorResources.primary : ColorResources.black,
                  //                   ),
                  //                 )),
                  //               ),
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Expanded(
                  //             child: InkWell(
                  //               onTap: () {
                  //                 productController.changeStatusSearch(1);
                  //               },
                  //               child: Container(
                  //                 height: height * 0.06,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(10.0),
                  //                   // color: productController.showFavSearch == 1 ? ColorResources.primary : ColorResources.background,
                  //                   color: ColorResources.lightBlue,
                  //                   boxShadow: productController.showFavSearch == 1
                  //                       ? const [
                  //                           BoxShadow(
                  //                             blurRadius: 2,
                  //                             spreadRadius: 0,
                  //                             offset: Offset(0, 1),
                  //                             color: Color.fromRGBO(16, 24, 40, 0.06),
                  //                           ),
                  //                           BoxShadow(
                  //                             blurRadius: 3,
                  //                             spreadRadius: 3,
                  //                             offset: Offset(0, 1),
                  //                             color: Color.fromRGBO(16, 24, 40, 0.1),
                  //                           ),
                  //                         ]
                  //                       : [],
                  //                 ),
                  //                 child: Center(
                  //                     child: Text("goods".tr,
                  //                         style: mediumTextStyle.copyWith(
                  //                           color: productController.showFavSearch == 1 ? ColorResources.primary : ColorResources.black,
                  //                         ))),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
