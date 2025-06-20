import 'package:el_biz/bloc/filter_fields/filter_fields_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../bloc/product/product_bloc.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class AllKeywordsScreen extends StatelessWidget {
  const AllKeywordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('keywords'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productController) {
          return BlocBuilder<FilterFieldsBloc, FilterFieldsState>(
              builder: (context, filterState) {
            return ListView.builder(
              itemCount:
                  filterState.filterFieldsModel?.data?.searchTags?.length ?? 0,
              itemBuilder: (context, index) {
                final keyword =
                    filterState.filterFieldsModel!.data!.searchTags![index];

                final isSelected = productController.keywordsSelected(
                  keyword.searchKeywords ?? '',
                );

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft, // Important
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        context.read<ProductBloc>().add(
                              UpdateKeywordSelected(
                                  keyword.searchKeywords ?? ''),
                            );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? ColorResources.green : null,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: ColorResources.lgColor),
                        ),
                        child: Text(
                          keyword.searchKeywords ?? '',
                          style: body14.copyWith(
                            color: isSelected
                                ? ColorResources.white
                                : ColorResources.gray,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          });
        }),
      ),
    );
  }
}
