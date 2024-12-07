import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/cities_controller.dart';
import '../../../controller/post_ad_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({Key? key}) : super(key: key);

  call(ScrollController scrollController) {
    print("i am called");
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !Get.find<CitiesController>().isLoading) {
        int pageSize = Get.find<CitiesController>().pageSize;
        if (Get.find<CitiesController>().currentPageSize <= pageSize) {
          int nextPage = Get.find<CitiesController>().currentPageSize;
          // Get.find<ArticlePostController>().setOffset(Get.find<ArticlePostController>().offset+1);
          print('end of the page');
          Get.find<CitiesController>().showBottomLoader();
          Get.find<CitiesController>().getCities(nextPage, false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    // String comment = '';
    //call(_scrollController);
    var height = Get.height;
    return GetBuilder<CitiesController>(builder: (citiesController) {
      return Padding(
        padding: const EdgeInsets.only(top: 68.0),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.only(topRight: Radius.circular(24.0), topLeft: Radius.circular(24.0))),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 6,
                width: 100,
                decoration: BoxDecoration(color: ColorResources.hintColor.withOpacity(0.5), borderRadius: BorderRadius.circular(12.0)),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 18),
                child: SizedBox(
                  height: height * 0.05,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "choose_city".tr,
                          filled: true,
                          hintStyle: const TextStyle(color: ColorResources.hintColor),
                          fillColor: ColorResources.hintColor.withOpacity(0.2),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: SvgPicture.asset(Images.svgSearch, color: ColorResources.hintColor),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: citiesController.cityItem.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          ListTile(
                            dense: true,
                            onTap: () {
                              Get.find<ProductController>().changeCityId(citiesController.cityItem[i].id.toString(), citiesController.cityItem[i].name);

                              citiesController.changeCity(citiesController.cityItem[i].id.toString(), citiesController.cityItem[i].name);
                              Get.find<PostAdController>().updateCityId(citiesController.cityItem[i].id.toString(), citiesController.cityItem[i].name);
                              Get.back();
                            },
                            title: Text(
                              citiesController.cityItem[i].name,
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: citiesController.cityId == citiesController.cityItem[i].id.toString() ? ColorResources.lightBlue : Colors.black),
                            ),
                            trailing: citiesController.cityId == citiesController.cityItem[i].id.toString()
                                ? const Icon(
                                    Icons.check,
                                    color: ColorResources.lightBlue,
                                  )
                                : const SizedBox(),
                          ),
                          const Divider(
                            thickness: 2,
                            color: ColorResources.background,
                          )
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              // if (citiesController.bottomLoading) const CircularProgressIndicator(),
              // const SizedBox(
              //   height: 80,
              // ),
            ],
          ),
        ),
      );
    });
  }
}
