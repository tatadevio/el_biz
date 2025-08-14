// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// import '../../../../utils/Images.dart';
// import '../../../../utils/color_resources.dart';
// import '../../../../utils/custom_text_style.dart';

// class ProductSortWidget extends StatelessWidget {
//   const ProductSortWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(12),
//                             onTap: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(20)),
//                                 ),
//                                 builder: (context) {
//                                   return StatefulBuilder(
//                                     builder: (context, setState) {
//                                       return DraggableScrollableSheet(
//                                         initialChildSize: 0.6,
//                                         minChildSize: 0.5,
//                                         maxChildSize: 0.9,
//                                         expand: false,
//                                         builder: (context, scrollController) {
//                                           return Container(
//                                             padding: const EdgeInsets.all(20),
//                                             decoration: const BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.vertical(
//                                                       top: Radius.circular(20)),
//                                             ),
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       'sort_by'.tr,
//                                                       style: h16.copyWith(
//                                                           color: ColorResources
//                                                               .darkGray,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () =>
//                                                           Navigator.pop(
//                                                               context),
//                                                       icon: const Icon(
//                                                           Icons.close),
//                                                       color:
//                                                           ColorResources.gray,
//                                                     )
//                                                   ],
//                                                 ),
//                                                 const SizedBox(height: 10),
//                                                 Expanded(
//                                                   child: SingleChildScrollView(
//                                                     controller:
//                                                         scrollController,
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(12),
//                                                         color: Colors.white,
//                                                         boxShadow: [
//                                                           BoxShadow(
//                                                             color: Colors.grey
//                                                                 .withOpacity(
//                                                                     0.1),
//                                                             spreadRadius: 1,
//                                                             blurRadius: 5,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       child: Column(
//                                                         children: [
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'newest_first'
//                                                                     .tr,
//                                                             value: 'newest',
//                                                             orderBy:
//                                                                 'created_at',
//                                                             direction: 'desc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'oldest_first'
//                                                                     .tr,
//                                                             value: 'oldest',
//                                                             orderBy:
//                                                                 'created_at',
//                                                             direction: 'asc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'name_a_z'.tr,
//                                                             value: 'name_az',
//                                                             orderBy: 'name',
//                                                             direction: 'asc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'name_z_a'.tr,
//                                                             value: 'name_za',
//                                                             orderBy: 'name',
//                                                             direction: 'desc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'price_low_high'
//                                                                     .tr,
//                                                             value:
//                                                                 'price_low_high',
//                                                             orderBy: 'price',
//                                                             direction: 'asc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'price_high_low'
//                                                                     .tr,
//                                                             value:
//                                                                 'price_high_low',
//                                                             orderBy: 'price',
//                                                             direction: 'desc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'quantity_low_high'
//                                                                     .tr,
//                                                             value:
//                                                                 'quantity_low_high',
//                                                             orderBy: 'quantity',
//                                                             direction: 'asc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                           _buildSortOption(
//                                                             context: context,
//                                                             setState: setState,
//                                                             title:
//                                                                 'quantity_high_low'
//                                                                     .tr,
//                                                             value:
//                                                                 'quantity_high_low',
//                                                             orderBy: 'quantity',
//                                                             direction: 'desc',
//                                                             currentOrderBy:
//                                                                 orderBy,
//                                                             currentDirection:
//                                                                 direction,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                             child: Container(
//                               height: 40,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 14),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                   12,
//                                 ),
//                                 border: Border.all(
//                                     width: 1, color: ColorResources.lgColor),
//                                 color: ColorResources.lightBlue,
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     blurRadius: 2,
//                                     spreadRadius: 0,
//                                     offset: Offset(0, 1),
//                                     color: Color.fromRGBO(16, 24, 40, 0.05),
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SvgPicture.asset(
//                                     Images.svgArrowUpDown,
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     'new'.tr,
//                                     style: body14.copyWith(
//                                         color: ColorResources.gray),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//   }
// }
