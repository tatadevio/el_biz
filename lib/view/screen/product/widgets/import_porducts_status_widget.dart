import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import '../../../../bloc/product_import/product_import_bloc.dart';
import '../../../../bloc/product_import/product_import_state.dart';
import '../../../base/custom_dialog.dart';

class ImportPorductsStatusWidget extends StatefulWidget {
  const ImportPorductsStatusWidget({
    super.key,
  });

  @override
  State<ImportPorductsStatusWidget> createState() =>
      _ImportPorductsStatusWidgetState();
}

class _ImportPorductsStatusWidgetState
    extends State<ImportPorductsStatusWidget> {
  @override
  void initState() {
    super.initState();
    startApiCall();
  }

  startApiCall() async {
    Future.delayed(Duration(seconds: 2), () {
      final data = context.read<ProductImportBloc>().state.importProductsModel;
      if (data?.data?.progress?.totalRows != null &&
          data?.data?.progress?.processedRows != null) {
        int totalRows = data?.data?.progress?.totalRows ?? 0;
        int processedRows = data?.data?.progress?.processedRows ?? 0;
        if (totalRows > processedRows) {
          startApiCall();
        } else {
          Get.back();
        }
      } else {
        startApiCall();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductImportBloc, ProductImportState>(
      builder: (context, state) {
        log('this is the response = ${state.importProductsModel?.toJson()}');
        int totalRows =
            state.importProductsModel?.data?.progress?.totalRows ?? 0;
        int sucessfullRows =
            state.importProductsModel?.data?.progress?.successfulRows ?? 0;
        int errorRows =
            state.importProductsModel?.data?.progress?.failedRows ?? 0;
        return CustomDialog(
            widget: AlertDialog(
          title: Text('Adding Products'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('your file is uploaded and now adding the products.'),
              Text('total products: $totalRows'),
              Text('uploaded products: $sucessfullRows '),
              Text('error products: $errorRows'),
            ],
          ),
        ));
      },
    );
  }
}
