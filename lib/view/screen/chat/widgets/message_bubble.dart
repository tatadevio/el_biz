// import 'package:el_biz/utils/custom_text_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';
// import '../../../../controller/chat_controller.dart';
// import '../../../../controller/user_controller.dart';
// import '../../../../data/model/response/chat/chat_model.dart';
// import '../../../../helper/date_converter.dart';
// import '../../../../utils/Images.dart';
// import '../../../../utils/color_resources.dart';

// class MessageBubble extends StatefulWidget {
//   final ChatList chat;
//   final bool addDate;
//   const MessageBubble({super.key, required this.chat, required this.addDate});

//   @override
//   State<MessageBubble> createState() => _MessageBubbleState();
// }

// class _MessageBubbleState extends State<MessageBubble> {
//   bool isPlaying = false;
//   bool isRecording = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   String audio = "";

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isMe = widget.chat.senderId.id == Get.find<UserController>().userInfoModel!.data.id;
//     String dateTime = DateConverter.isoStringToLocalTimeOnly(widget.chat.createdAt.toString());
//     String _date = DateConverter.isoStringToLocalDateOnly(widget.chat.createdAt.toString()) == DateConverter.estimatedDate(DateTime.now())
//         ? 'Today'
//         : DateConverter.isoStringToLocalDateOnly(widget.chat.createdAt.toString()) == DateConverter.estimatedDate(DateTime.now().subtract(const Duration(days: 1)))
//             ? 'Yesterday'
//             : DateConverter.isoStringToLocalDateOnly(widget.chat.createdAt.toString());

//     return GetBuilder<ChatController>(builder: (chatController) {
//       return Column(
//         crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           widget.addDate
//               ? Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Align(alignment: Alignment.center, child: Text(_date, textAlign: TextAlign.center)),
//                 )
//               : const SizedBox(),
//           Padding(
//             padding: isMe ? const EdgeInsets.fromLTRB(50, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 50, 5),
//             child: Column(
//               crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {},
//                         onLongPress: () {
//                           Get.dialog(CupertinoAlertDialog(
//                             title: Text("are_you_sure".tr),
//                             content: Text("do_you_delete_chat".tr),
//                             actions: [
//                               MaterialButton(
//                                 onPressed: () {
//                                   Get.back();
//                                 },
//                                 child: Text("no".tr),
//                               ),
//                               MaterialButton(
//                                 onPressed: () {
//                                   Get.back();
//                                   Get.find<ChatController>().deleteMessage(widget.chat.id.toString(), widget.chat).then((value) {});
//                                 },
//                                 child: Text(
//                                   "yes".tr,
//                                   style: const TextStyle(color: Colors.red),
//                                 ),
//                               ),
//                             ],
//                           ));
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(isMe ? 16 : 0), bottomRight: Radius.circular(isMe ? 0 : 16)),
//                             boxShadow: const [
//                               BoxShadow(
//                                 blurRadius: 40,
//                                 spreadRadius: 0,
//                                 offset: Offset(-10, 20),
//                                 color: Color.fromRGBO(0, 0, 0, 0.14),
//                               ),
//                             ],
//                             color: widget.chat.type != 'image'
//                                 ? isMe && widget.chat.type != 'audio'
//                                     ? ColorResources.lgColor
//                                     : widget.chat.type != 'audio'
//                                         ? const Color(0xffC5ECEE)
//                                         : Colors.white54
//                                 : Colors.white,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                             children: [
//                               if (widget.chat.type == 'text')
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//                                   child: Text(
//                                     isMe ? widget.chat.message : widget.chat.message,
//                                     style: body14,
//                                   ),
//                                 )
//                               else if (widget.chat.type == 'image')
//                                 widget.chat.image != ""
//                                     ? GestureDetector(
//                                         onTap: () {
//                                           Get.to(() => (ImageView(image: widget.chat.image)));
//                                         },
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(isMe ? 10 : 0),
//                                             bottomRight: Radius.circular(isMe ? 0 : 10),
//                                             topLeft: const Radius.circular(10),
//                                             topRight: const Radius.circular(10),
//                                           ),
//                                           child: FadeInImage.assetNetwork(
//                                             placeholder: Images.placeholder,
//                                             image: widget.chat.image,
//                                             width: MediaQuery.of(context).size.width * 0.7,
//                                             fit: BoxFit.fitWidth,
//                                             height: MediaQuery.of(context).size.height * 0.28,
//                                           ),
//                                         ),
//                                       )
//                                     : const SizedBox(),

//                               const SizedBox(height: 1),
//                               //Text(DateTime.parse(chat.createdAt).toLocal().toString().substring(5,19), style: TextStyle(fontSize: 8, color: Colors.grey.shade500)),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8.0, right: 8),
//                                     child: Text(DateFormat('dd MMM hh:mm').format(widget.chat.createdAt), style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 5),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }

//   getDuration() async {
//     //audioCache.lo(widget.chat.image);
//     //await audioPlayer.(widget.chat.image);
//     //duration = (await audioPlayer.getDuration())!;
//     //print("duration is $duration");
//   }
// }

// String getMinutes(Duration val) {
//   String twoDigits(int n) => n.toString().padLeft(0);
//   final twoDigitMinutes = twoDigits(val.inMinutes.remainder(60));
//   final twoDigitSeconds = twoDigits(val.inSeconds.remainder(60));
//   return "$twoDigitMinutes : $twoDigitSeconds";
// }

// class ImageView extends StatelessWidget {
//   final String image;
//   const ImageView({Key? key, required this.image}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.withOpacity(0.1),
//       appBar: AppBar(),
//       body: PhotoView(imageProvider: NetworkImage(image)),
//     );
//   }
// }
