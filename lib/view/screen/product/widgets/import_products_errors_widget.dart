import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/product_import/product_import_bloc.dart';
import '../../../../bloc/product_import/product_import_state.dart';

class ImportProductsErrorsWidget extends StatelessWidget {
  const ImportProductsErrorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.7,
      width: double.infinity,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(width: 48), // Placeholder for alignment
            Text(
              'Import Errors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ]),
          // Expanded(
          //     child: BlocConsumer<ProductImportBloc, ProductImportState>(
          //       listener: (context, state) {
          //     if (state is ImportProductErrorFailed) {
          //       ScaffoldMessenger.of(context)
          //           .showSnackBar(SnackBar(content: Text(state.error)));
          //     }
          //       },
          //   builder: (context, state) {
          //     if (state is ProductImportLoading) {
          //       return Center(child: CircularProgressIndicator());
          //     }  else if (state is ImportProductErrorSuccess) {
          //      return  ListView.separated(
          //         itemCount: state.error.data?.errors?.length ?? 0,
          //         separatorBuilder: (context, index) => Divider(),
          //         itemBuilder: (context, index) {
          //           final errorItem = state.error.data!.errors![index];
          //           return ListTile(
          //             title: Text(errorItem.data?.name ?? ''),
          //             subtitle: Text(errorItem.message ?? ''),
          //           );
          //         },
          //       );
          //     }
          //   },
          //   // child: SizedBox(),
          // ))
          Expanded(
            child: BlocConsumer<ProductImportBloc, ProductImportState>(
              listener: (context, state) {
                if (state is ImportProductErrorFailed) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is ProductImportLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ImportProductErrorSuccess) {
                  final errors = state.error.data?.errors ?? [];

                  if (errors.isEmpty) {
                    return const Center(child: Text('No errors found'));
                  }

                  return ListView.separated(
                    itemCount: errors.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final errorItem = errors[index];
                      return ListTile(
                        title: Text(errorItem.data?.name ?? ''),
                        subtitle: Text(errorItem.message ?? ''),
                      );
                    },
                  );
                }

                return const Center(child: Text('No data'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
