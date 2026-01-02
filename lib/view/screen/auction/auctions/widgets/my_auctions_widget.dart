import 'package:el_biz/view/screen/auction/auctions/widgets/my_created_auctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import 'my_bid_auctions.dart';

class MyAuctionsWidget extends StatefulWidget {
  final String sortOrder;
  final String orderBy;
  const MyAuctionsWidget(
      {super.key, this.sortOrder = 'asc', this.orderBy = 'created_at'});

  @override
  State<MyAuctionsWidget> createState() => _MyAuctionsWidgetState();
}

class _MyAuctionsWidgetState extends State<MyAuctionsWidget> {
  bool showMyCreated = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // productController.updateShowCategories(true);
                  // context
                  //     .read<ProductBloc>()
                  //     .add(const UpdateShowCategories(true));
                  setState(() {
                    showMyCreated = true;
                  });
                },
                child: Container(
                  height: 40,
                  width: width * 0.46,
                  decoration: BoxDecoration(
                      color: !showMyCreated ? null : ColorResources.primary,
                      border: Border.all(
                        width: 1,
                        // color: productController.isGridView
                        //     ? ColorResources.primary
                        //     : ColorResources.lgColor,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: !showMyCreated
                          ? []
                          : [
                              const BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(16, 24, 40, 0.1),
                              ),
                              const BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(16, 24, 40, 0.06),
                              ),
                            ]),
                  alignment: Alignment.center,
                  child: Text(
                    'my_created'.tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: button16.copyWith(
                        color: !showMyCreated
                            ? ColorResources.gray
                            : Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // productController.updateShowCategories(false);
                  // context
                  //     .read<ProductBloc>()
                  //     .add(const UpdateShowCategories(false));
                  setState(() {
                    showMyCreated = false;
                  });
                },
                child: Container(
                  height: 40,
                  width: width * 0.46,
                  decoration: BoxDecoration(
                      color: showMyCreated ? null : ColorResources.primary,
                      border: Border.all(
                        width: 1,
                        // color: !productController.isGridView
                        //     ? ColorResources.primary
                        //     : ColorResources.lgColor,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: showMyCreated
                          ? []
                          : [
                              const BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(16, 24, 40, 0.1),
                              ),
                              const BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(16, 24, 40, 0.06),
                              ),
                            ]),
                  alignment: Alignment.center,
                  child: Text(
                    'my_bids'.tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: button16.copyWith(
                        color:
                            showMyCreated ? ColorResources.gray : Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: showMyCreated ? MyCreatedAuctions() : MyBidAuctions()),
      ],
    );
  }
}
