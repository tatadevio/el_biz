import 'dart:async';
import 'dart:developer';

import 'package:el_biz/bloc/product_import/product_import_event.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/view/screen/product/widgets/import_products_errors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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

  bool _showEndButton = false;

  startApiCall() async {
    Future.delayed(Duration(seconds: 2), () {
      final data = context.read<ProductImportBloc>().state.importProductsModel;
      callApi();
      if (data?.data?.progress?.totalRows != null &&
          data?.data?.progress?.processedRows != null) {
        int totalRows = data?.data?.progress?.totalRows ?? 0;
        int processedRows = data?.data?.progress?.processedRows ?? 0;
        if (totalRows > processedRows) {
          startApiCall();
        } else {
          // Get.back();
          setState(() {
            _showEndButton = true;
          });
        }
      } else {
        startApiCall();
      }
    });
  }

  Future<void> callApi() async {
    final data = context.read<ProductImportBloc>().state.importProductsModel;
    // context.read<ProductImportBloc>().add(ImportProductStatus(id: 1));
    if (data?.data?.id != null) {
      context
          .read<ProductImportBloc>()
          .add(ImportProductStatus(id: data!.data!.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductImportBloc, ProductImportState>(
      builder: (context, state) {
        log('this is the response = ${state.importProductsModel?.toJson()}');
        int totalRows =
            state.importProductsModel?.data?.progress?.totalRows ?? 0;
        int processedRows =
            state.importProductsModel?.data?.progress?.processedRows ?? 0;
        int sucessfullRows =
            state.importProductsModel?.data?.progress?.successfulRows ?? 0;
        int errorRows =
            state.importProductsModel?.data?.progress?.failedRows ?? 0;
        return CustomDialog(
          widget: AlertDialog(
            title: Text('Importing Products'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (totalRows > 0)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          value: processedRows / totalRows,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      Text(
                        '${((processedRows / totalRows) * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Text('Your file is uploaded and is being processed.'),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Rows: $totalRows'),
                      Text('Processed: $processedRows'),
                      Text('Successful: $sucessfullRows',
                          style: TextStyle(color: Colors.green)),
                      Text('Failed: $errorRows',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              if (_showEndButton && errorRows > 0)
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductImportBloc>().add(ImportProductError(
                        id: state.importProductsModel!.data!.id!));
                    Get.back();
                    Get.dialog(CustomDialog(
                      widget: Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        child: SizedBox(
                          height: MediaQuery.of(Get.context!).size.height * 0.7,
                          width: double.infinity,
                          child: ImportProductsErrorsWidget(),
                        ),
                      ),
                    ));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(ColorResources.primary),
                      foregroundColor: WidgetStatePropertyAll(Colors.white)),
                  child: Text(
                    errorRows > 1 ? 'Show Erros' : 'Show Error',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              if (_showEndButton)
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(ColorResources.primary),
                      foregroundColor: WidgetStatePropertyAll(Colors.white)),
                  child: Text(
                    'Ok',
                    style: TextStyle(fontSize: 16),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
