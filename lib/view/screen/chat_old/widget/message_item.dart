// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter_link_previewer/flutter_link_previewer.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:isooq/utils/appConstant.dart';
// import 'package:swipe_to/swipe_to.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;

// import '../../../../controller/product_controller.dart';
// import '../../../../controller/product_detail_controller.dart';
// import '../../../../data/repo/product_repo.dart';
// import '../../../../helper/route_helper.dart';
// import '../../../../utils/color_resources.dart';
// import '../../../base/custom_image.dart';




// class ChatMessageWidget extends StatelessWidget {
//   final QueryDocumentSnapshot data;
//   final bool isMe;
//   final Function(QueryDocumentSnapshot) onReply;
//   final Function(QueryDocumentSnapshot) onEdit;
//   final Function(QueryDocumentSnapshot) onDelete;
//   final Function(String) onReplyTap;
//   final bool fromSingle;

//   ChatMessageWidget({
//     required this.data,
//     required this.isMe,
//     required this.onReply,
//     required this.onEdit,
//     required this.onDelete,
//     required this.onReplyTap,
//     this.fromSingle = true,
//   });

//   String _formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) {
//       return 'Just now';
//     }
//     DateTime dateTime = timestamp.toDate();
//     return '${dateTime.hour}:${dateTime.minute}';
//   }



//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onLongPress: () => _showMessageOptions(context),
//         child: Align(
//           alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             child: SwipeTo(
//               key: UniqueKey(),
//               onRightSwipe: (v) {
//                 print("i am");
//                 onReply(data);
//               },
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
//                 children: [
//                   if (!isMe) ...[
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(120.0),
//                       child: CustomImage(image: data['sender_image'], height: 40, width: 40, radius: 1,),
//                     ),
//                     SizedBox(width: 10),
//                   ],
//                   ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: MediaQuery.of(context).size.width * 0.6,
//                     ),
//                     child: data['image_url'] != null && data['image_url'].isNotEmpty
//                         ? Container(
//                       decoration: BoxDecoration(
//                         color: isMe
//                             ?  data['message'].contains('isooq.page.link')
//                             ? ColorResources.primary.withOpacity(0.7)
//                             : ColorResources.primary
//                             : Colors.transparent,
//                         borderRadius: BorderRadius.only(
//                           topLeft: !isMe ? Radius.zero : Radius.circular(15),
//                           topRight: Radius.circular(15),
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: isMe ? Radius.zero : Radius.circular(15),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (data['image_url'] != null && data['image_url'].isNotEmpty)
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Scaffold(
//                                       backgroundColor: Colors.black,
//                                       appBar: AppBar(
//                                         backgroundColor: Colors.black,
//                                         iconTheme: IconThemeData(color: Colors.white),
//                                       ),
//                                       body: Center(
//                                         child: InteractiveViewer(
//                                           child: Image.network(data['image_url']),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(15.0),
//                                         topRight: Radius.circular(15.0)
//                                     ),
//                                     border: Border.all(
//                                         color: ColorResources.background
//                                     )
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: !isMe ? Radius.zero : Radius.circular(15),
//                                     topRight: Radius.circular(15),
//                                   ),
//                                   child: Image.network(
//                                     data['image_url'],
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     loadingBuilder: (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Container(
//                                         width: double.infinity,
//                                         height: 200,
//                                         child: Center(child: CircularProgressIndicator()),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // if (!isMe) ...[
//                                 //   Text(
//                                 //     data['sender_name'] ?? 'Unknown',
//                                 //     style: TextStyle(
//                                 //       fontWeight: FontWeight.bold,
//                                 //       color: data['user_type'] == "student" ? ColorResources.green : Colors.white,
//                                 //     ),
//                                 //     maxLines: 1,
//                                 //     overflow: TextOverflow.ellipsis,
//                                 //   ),
//                                 //   SizedBox(height: 5),
//                                 // ],

//                                 if(data['reply_to'] != null)
//                                   InkWell(
//                                     onDoubleTap: () {
//                                       print("i am");
//                                       print(data['reply_to']['message_id']);
//                                     },
//                                     onTap: () => onReplyTap(data['reply_to']['message_id']),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: isMe
//                                               ? Color(0xffF4F4F4)
//                                               : data['user_type'] == "student"
//                                               ? Color(0xff858DEA): Color(0xffF4F4F4),
//                                           borderRadius: BorderRadius.circular(8.0)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(data['reply_to']['sender-name'],
//                                               style: TextStyle(
//                                                   color: isMe
//                                                       ? Color(0xffB0BE0B)
//                                                       : data['user_type'] == "student"
//                                                       ? Colors.white
//                                                       : Color(0xffB0BE0B),
//                                                   fontWeight: FontWeight.w500
//                                               ),),
//                                             data['reply_to']['message'] != ""
//                                                 ?
//                                             Text(data['reply_to']['message'],
//                                             ): const Icon(Icons.image),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 if(data['message'].contains('isooq.page.link'))...[
//                                   PreviewDataMessage(url: data['message'],)
//                                 ]else...[
//                                   Text(data['message'],
//                                     style: TextStyle(color: isMe ? Colors.white : ColorResources.black, fontSize: 16, fontWeight: FontWeight.w500),)
//                                 ],
//                                 SizedBox(height: 5),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       _formatTimestamp(data['timestamp']),
//                                       style: TextStyle(
//                                           color: isMe
//                                               ? Colors.white70
//                                               : data['user_type'] == "student"
//                                               ? ColorResources.grey
//                                               : Colors.white,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500),
//                                     ),

//                                     if(fromSingle)
//                                       Icon(Icons.done_all,
//                                         color: isMe && data['is_seen']!=null && data['is_seen'] == true ? ColorResources.primary: ColorResources.hintColor,),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                         : IntrinsicWidth(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: isMe
//                               ?data['message'].contains('isooq.page.link')
//                               ? ColorResources.primary.withOpacity(0.7)
//                               : ColorResources.primary
//                               : Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: !isMe ? Radius.zero : Radius.circular(12),
//                             topRight: Radius.circular(12),
//                             bottomLeft: Radius.circular(12),
//                             bottomRight: isMe ? Radius.zero : Radius.circular(12),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (data['image_url'] != null && data['image_url'].isNotEmpty)
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => Scaffold(
//                                         backgroundColor: Colors.black,
//                                         appBar: AppBar(
//                                           backgroundColor: Colors.black,
//                                           iconTheme: IconThemeData(color: Colors.white),
//                                         ),
//                                         body: Center(
//                                           child: InteractiveViewer(
//                                             child: Image.network(data['image_url']),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: const BorderRadius.only(
//                                           topLeft: Radius.circular(15.0),
//                                           topRight: Radius.circular(15.0)
//                                       ),
//                                       border: Border.all(
//                                           color: ColorResources.background
//                                       )
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: !isMe ? Radius.zero : Radius.circular(15),
//                                       topRight: Radius.circular(15),
//                                     ),
//                                     child: CustomImage(
//                                       image: data['image_url'],
//                                       width: 200,
//                                       height: 200, radius: 1,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             Padding(
//                               padding:  EdgeInsets.symmetric(horizontal: isMe? 8: 10, vertical: isMe ? 8:2),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   if (!isMe) ...[
//                                     if (data['message'] != null && data['message'].isNotEmpty)
//                                       Text(data['message'],
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             color: Color(0xff29292D),
//                                             fontSize: 15
//                                         ),),
//                                     if(data['reply_to'] != null)
//                                       SizedBox(height: 5),
//                                   ],
//                                   if(data['reply_to'] != null)
//                                     InkWell(
//                                       onDoubleTap: () {
//                                         print("i am");
//                                         print(data['reply_to']['message_id']);
//                                       },
//                                       onTap: () => onReplyTap(data['reply_to']['message_id']),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: isMe
//                                                 ? Color(0xffF4F4F4)
//                                                 : data['user_type'] == "student"
//                                                 ? Color(0xff858DEA): Color(0xffF4F4F4),
//                                             borderRadius: BorderRadius.circular(8.0)
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(data['reply_to']['sender-name'],
//                                                 style: TextStyle(
//                                                     color: isMe
//                                                         ? Color(0xffB0BE0B)
//                                                         : data['user_type'] == "student"
//                                                         ? Colors.white
//                                                         : Color(0xffB0BE0B),
//                                                     fontWeight: FontWeight.w500
//                                                 ),),

//                                               data['reply_to']['message'] != ""
//                                                   ?
//                                               Text(data['reply_to']['message'],
//                                               ): Icon(Icons.image),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   if (isMe && data['message'] != null && data['message'].isNotEmpty)
//                                     if (data['message'] != null && data['message'].isNotEmpty)


//                                       if(data['message'].contains('isooq.page.link'))...[
//                                         PreviewDataMessage(url: data['message'],)
//                                       ]else...[
//                                         Text(data['message'],
//                                         style: TextStyle(color: isMe ? Colors.white : ColorResources.black, fontSize: 16, fontWeight: FontWeight.w500),)
//                                       ],

//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         _formatTimestamp(data['timestamp']),
//                                         style: TextStyle(
//                                             color: isMe
//                                                 ? Colors.white70
//                                                 : data['user_type'] == "student"
//                                                 ? ColorResources.grey
//                                                 : Colors.black54,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500),
//                                       ),

//                                       if(isMe && fromSingle)
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 8.0),
//                                           child: Icon(isMe && data['is_seen']!=null && data['is_seen'] == true
//                                               ? Icons.done_all : Icons.done,
//                                             color:  Colors.white, size: 20,),
//                                         ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   if (isMe) SizedBox(width: 10),
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }

//   void _showMessageOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           child: Wrap(
//             children: <Widget>[
//               if (isMe) ...[
//                 ListTile(
//                   leading: Icon(Icons.edit),
//                   title: Text('Редактировать'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     onEdit(data);
//                   },
//                 ),
//                 Divider(thickness: 1,),
//                 ListTile(
//                   leading: Icon(Icons.delete),
//                   title: Text('Удалить'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     onDelete(data);
//                   },
//                 ),
//                 Divider(thickness: 1,),
//               ],
//               ListTile(
//                 leading: Icon(Icons.reply),
//                 title: Text('Отвечать'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   onReply(data);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



// class PreviewDataMessage extends StatefulWidget {
//   final String url;
//   const PreviewDataMessage({super.key, required this.url});

//   @override
//   State<PreviewDataMessage> createState() => _PreviewDataMessageState();
// }

// class _PreviewDataMessageState extends State<PreviewDataMessage> {
//   PreviewData? _data;


//   void _handleLink(Uri deepLink) {
//     // Navigate based on the deep link
//     List<String> url = deepLink.pathSegments;
//     print(url);
//     if (url[1] == 'product') {
//       final productId = url[0].toString();
//       if (productId != '') {
//         Get.put(ProductRepo(Get.find(), Get.find()));
//         Get.find<ProductController>().getRelatedProduct(productId);
//         Get.find<ProductDetailController>().getProductDetail(productId);
//         Get.toNamed(RouteHelper.getProductDetailRoute());
//       }
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return LinkPreview(
//       onLinkPressed: (link) async {
//         Uri url = Uri.parse(link);

//         // Check if the link is a Firebase Dynamic Link
//         final PendingDynamicLinkData? dynamicLinkData =
//             await FirebaseDynamicLinks.instance.getDynamicLink(url);

//         if (dynamicLinkData != null) {
//           // Firebase resolved the short link; now handle the long link
//           final Uri deepLink = dynamicLinkData.link;

//           print('Resolved Deep Link: $deepLink');
//           print('Path Segments: ${deepLink.pathSegments}');

//           // Call your handler for the resolved dynamic link
//           _handleLink(deepLink);
//         } else {
//           // Handle non-dynamic links (e.g., external URLs)
//           if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//         throw Exception('Could not launch $url');
//         }
//       }
//       },
//       enableAnimation: true,
//       onPreviewDataFetched: (data) {
//         setState(() {
//           _data = data;
//         });
//       },
//       previewData: _data, // Pass the preview data from the state
//       text: widget.url,
//       width: MediaQuery.of(context).size.width,
//     );
//   }
// }
