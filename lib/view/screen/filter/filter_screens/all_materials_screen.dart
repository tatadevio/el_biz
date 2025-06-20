import 'package:el_biz/bloc/material/material_bloc.dart' as mb;
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class AllMaterialsScreen extends StatelessWidget {
  const AllMaterialsScreen({super.key});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<mb.MaterialBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.isLoadingMore) {
        int pageSize = accountController.state.pageSize;
        if (accountController.state.currentPage < pageSize) {
          int nextPage = accountController.state.currentPage;

          accountController.add(mb.GetMaterials(currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = ScrollController();
    _callScrolling(context, _controller);
    return Scaffold(
      appBar: AppBar(
        title: Text('material'.tr),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productController) {
        return BlocBuilder<mb.MaterialBloc, mb.MaterialState>(
          builder: (context, materialState) {
            return ListView.builder(
              controller: _controller,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: materialState.materialItems.length,
              itemBuilder: (context, index) {
                final material = materialState.materialItems[index];
                final isSelected =
                    productController.materialSelected(material.name ?? '');

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        context.read<ProductBloc>().add(
                              UpdateMaterialSelected(material.name ?? ''),
                            );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? ColorResources.green : null,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 1,
                            color: ColorResources.lgColor,
                          ),
                        ),
                        child: Text(
                          material.name ?? '',
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
          },
        );
      }),
    );
  }
}
