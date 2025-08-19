// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// import '../../../../utils/color_resources.dart';

// class BottomNavItem extends StatelessWidget {
//   final String iconData;
//   final Function onTap;
//   final bool isSelected;
//   final String title;
//   const BottomNavItem(
//       {super.key,
//       required this.iconData,
//       required this.onTap,
//       this.isSelected = false,
//       required this.title});

//   @override
//   Widget build(BuildContext context) {
//     var height = Get.height;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           onTap();
//         },
//         child: Column(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 SvgPicture.asset(
//                   iconData,
//                   color: isSelected
//                       ? ColorResources.primary
//                       // Theme.of(context).primaryColor
//                       : Color.fromRGBO(208, 213, 221, 1),
//                   // ColorResources.greyHard,
//                   height: height * 0.025,
//                 ),
//                 // if (title == "chats".tr)
//                 //   const Positioned(
//                 //     top: -10,
//                 //     right: -10,
//                 //     child: CountUnseenChats(),
//                 //   ),
//               ],
//             ),
//             SizedBox(
//               height: Get.height * 0.005,
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                   color: isSelected
//                       ? ColorResources.primary
//                       // Theme.of(context).primaryColor
//                       : Color.fromRGBO(208, 213, 221, 1),
//                   fontSize: 12),
//               maxLines: 1,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
