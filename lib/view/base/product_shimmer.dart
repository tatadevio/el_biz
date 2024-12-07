import 'package:flutter/material.dart';

import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';
import '../../utils/color_resources.dart';


class ProductWidgetShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,childAspectRatio: 1/1.39,
              crossAxisSpacing: 12,mainAxisSpacing: 12),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 12,
        itemBuilder: (context, snapshot) {
          return Container(
              margin: EdgeInsets.only(
                  right: 4, bottom: 4),
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [

                  ]),
              child: Shimmer(
                duration: Duration(seconds: 1), interval: Duration(seconds: 1),
                enabled: true,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      height: 105, width: 195,
                      decoration: BoxDecoration(borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10)), color: ColorResources.hintColor.withOpacity(0.4))),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 6,),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:4,
                                    vertical: 4),
                                child: Container(height: 15, color: ColorResources.hintColor.withOpacity(0.4))
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(height: 8, width: 100,
                                  decoration: BoxDecoration(
                                      color: ColorResources.hintColor.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(6.0)
                                  ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: height * 0.04,
                                  width: height * 0.04,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey.shade300)
                                  ),
                                  child: Icon(Icons.person,color: ColorResources.hintColor,),
                                ),
                                Expanded(child: SizedBox(height: 1,)),
                                Icon(Icons.email,color: ColorResources.hintColor,),
                                SizedBox(width: 15,),
                                Icon(Icons.favorite_border,color: ColorResources.hintColor,),
                              ],
                            ),
                            SizedBox(width: 8),
                          ]),
                    ),
                  ),

                ]),
              )
          );
        }
      ),
    );
  }
}