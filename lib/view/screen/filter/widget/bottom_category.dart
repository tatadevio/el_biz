// import 'package:el_biz/bloc/category/category_bloc.dart';
// import 'package:el_biz/bloc/product/product_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// import '../../../../bloc/post_ad/post_ad_bloc.dart';
// import '../../../../data/model/response/category/category_model.dart';
// import '../../../../utils/color_resources.dart';
// import '../../../base/custom_image.dart';

// class ShowBottomCategory extends StatelessWidget {
//   final bool isEdit;

//   const ShowBottomCategory({super.key, required this.isEdit});

//   @override
//   Widget build(BuildContext context) {
//     var height = Get.height;
//     // var width = Get.width;

//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, categoryState) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(24.0),
//               topRight: Radius.circular(24.0),
//             ),
//           ),
//           height: height * 0.8,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 18.0),
//             child: ListView(
//               children: categoryState.categoryItem.map((tile) {
//                 final widget = BasicTileWidget(
//                   tile: tile,
//                   isEdit: isEdit,
//                   showLeadingImage: tile.childs.isNotEmpty, // Show leading image if there is no parent.
//                 );
//                 return widget;
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class BasicTileWidget extends StatelessWidget {
//   final CategoriesItem tile;
//   final bool isEdit;
//   final bool showLeadingImage;

//   const BasicTileWidget({
//     Key? key,
//     required this.tile,
//     required this.isEdit,
//     required this.showLeadingImage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final title = tile.name;
//     final tiles = tile.childs;

//     if (tiles.isEmpty) {
//       return BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, productController) {
//           return ListTile(
//             leading: showLeadingImage
//                 ? CustomImage(
//                     image: tile.image,
//                     height: Get.height * 0.035,
//                     width: Get.height * 0.035,
//                     radius: 6.0,
//                   )
//                 : null,
//             title: Text(
//               title,
//               style: TextStyle(
//                 color: tile.id.toString() == productController.selectedSubCatId ? ColorResources.primary : Colors.black,
//               ),
//             ),
//             onTap: () {
//               context.read<ProductBloc>().add(UpdateNameId(tile.id.toString(), tile.name));
//               // productController.updateNameId(tile.id.toString(), tile.name);
//               // postAdController.addCategoryName(tile.name, isEdit);
//               // postAdController.updateCategoryId(tile.id.toString(), tile.name);
//               context.read<PostAdBloc>().add(AddCategoryName(tile.name, isEdit));
//               context.read<PostAdBloc>().add(UpdateCategoryId(tile.id.toString(), tile.name));
//               Get.back();
//               print("I am");
//             },
//           );
//         },
//       );
//     } else {
//       return ExpansionTile(
//         leading: showLeadingImage
//             ? CustomImage(
//                 image: tile.image,
//                 height: Get.height * 0.035,
//                 width: Get.height * 0.035,
//                 radius: 6.0,
//               )
//             : null,
//         key: PageStorageKey(title),
//         onExpansionChanged: (value) {
//           print(value);
//           if (value) {
//             context.read<PostAdBloc>().add(AddCategoryName(tile.name, false));
//             // Get.find<PostAdController>().addCategoryName(tile.name, false);
//           } else {
//             // Get.find<PostAdController>().addCategoryName(tile.name, false);
//             context.read<PostAdBloc>().add(AddCategoryName(tile.name, false));
//           }
//         },
//         title: Text(
//           title,
//           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 17),
//         children: tiles
//             .map((tile) => BasicTileWidget(
//                   tile: tile,
//                   isEdit: isEdit,
//                   showLeadingImage: false,
//                 ))
//             .toList(),
//       );
//     }
//   }
// }
