import 'package:el_biz/bloc/cities/cities_bloc.dart';
import 'package:el_biz/bloc/post_ad/post_ad_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';

class CitiesScreen extends StatefulWidget {
  const CitiesScreen({super.key});

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CitiesBloc>().add(GetCitites(1, true));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    // String comment = '';
    //call(_scrollController);
    var height = Get.height;
    return BlocBuilder<CitiesBloc, CitiesState>(
        builder: (context, citiesState) {
      if (citiesState.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(top: 68.0),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              // color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(24.0))),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 6,
                width: 100,
                decoration: BoxDecoration(
                    color: ColorResources.hintColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12.0)),
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
                          hintStyle:
                              const TextStyle(color: ColorResources.hintColor),
                          fillColor: ColorResources.hintColor.withOpacity(0.2),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: SvgPicture.asset(Images.svgSearch,
                                color: ColorResources.hintColor),
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
                    itemCount: citiesState.cityItem.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          ListTile(
                            dense: true,
                            onTap: () {
                              // Get.find<ProductController>().changeCityId(citiesState.cityItem[i].id.toString(), citiesState.cityItem[i].name);

                              context.read<ProductBloc>().add(ChangeCityId(
                                  citiesState.cityItem[i].id.toString(),
                                  citiesState.cityItem[i].name));

                              context.read<CitiesBloc>().add(ChangeCity(
                                  citiesState.cityItem[i].id.toString(),
                                  citiesState.cityItem[i].name));

                              // citiesState.changeCity(citiesState.cityItem[i].id.toString(), citiesState.cityItem[i].name);

                              context.read<PostAdBloc>().add(UpdateCityId(
                                  citiesState.cityItem[i].id.toString(),
                                  citiesState.cityItem[i].name));
                              Get.back();
                            },
                            title: Text(
                              citiesState.cityItem[i].name,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: citiesState.cityId ==
                                          citiesState.cityItem[i].id.toString()
                                      ? ColorResources.black
                                      : Colors.black),
                            ),
                            trailing: citiesState.cityId ==
                                    citiesState.cityItem[i].id.toString()
                                ? const Icon(
                                    Icons.check,
                                    color: ColorResources.black,
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
              // if (citiesState.bottomLoading) const CircularProgressIndicator(),
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
