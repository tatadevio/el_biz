// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';

// import '../../../../controller/chat_controller.dart';
// import '../../../../utils/color_resources.dart';

// class MessageBubbleShimmer extends StatelessWidget {
//   final bool isMe;
//   MessageBubbleShimmer({required this.isMe});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: isMe ?  EdgeInsets.fromLTRB(50, 5, 10, 5) : EdgeInsets.fromLTRB(10, 5, 50, 5),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           Flexible(
//             child: Shimmer(
//               enabled: Get.find<ChatController>().chatList == null,
//               child: Container(
//                 height: 30, width: 180,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     bottomLeft: isMe ? Radius.circular(30) : Radius.circular(0),
//                     bottomRight: isMe ? Radius.circular(0) : Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   color: !isMe ? Colors.grey.withOpacity(0.3) : ColorResources.primary.withOpacity(0.2),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
