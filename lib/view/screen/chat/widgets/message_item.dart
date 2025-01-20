import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/utilities.dart';
import '../../../base/custom_image.dart';
import './full_screen_image.dart';

class ChatMessageWidget1 extends StatefulWidget {
  final QueryDocumentSnapshot data;
  final bool isMe;
  // final Function(QueryDocumentSnapshot) onReply;
  // final Function(QueryDocumentSnapshot) onEdit;
  // final Function(QueryDocumentSnapshot) onDelete;
  // final Function(String) onReplyTap;
  final bool fromSingle;

  const ChatMessageWidget1({
    super.key,
    required this.data,
    required this.isMe,
    // required this.onReply,
    // required this.onEdit,
    // required this.onDelete,
    // required this.onReplyTap,
    this.fromSingle = true,
  });

  @override
  State<ChatMessageWidget1> createState() => _ChatMessageWidget1State();
}

class _ChatMessageWidget1State extends State<ChatMessageWidget1> {
  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'Just now';
    }
    DateTime dateTime = timestamp.toDate();
    return '${dateTime.hour}:${dateTime.minute}';
  }

  openLink(LinkableElement link) {
    // final uri = Uri.parse(link.url);
    // // print('scheme : ${uri.scheme}');
    // // print('host : ${uri.host}');
    // // print('path : ${uri.path}');
    // // print('path segments : ${uri.pathSegments}');
    // // print('query : ${uri.queryParameters}');
    // String type = uri.pathSegments[0];
    // String slug = uri.pathSegments[1];
    // if (type == 'product') {
    //   Get.toNamed('${AppRout.bookDetail}/null/$slug');
    // }
  }

  // ProductDetailModel? productDetail;

  Future<void> _checkForProductLink(String text) async {
    // final link = RegExp(r'(https?://\S+)').stringMatch(text);
    // final urlRegex = RegExp(r'(https?://[^\s]+)');
    // final containsLink = urlRegex.hasMatch(widget.data['text']);
    // final chatController = Get.find<ChatController>();
    // if (link != null && containsLink) {
    //   Uri uri = Uri.parse(text);

    //   final productSlug = uri.pathSegments[1];

    //   try {
    //     final details =
    //         await chatController.getProductDetailBySlug(productSlug);
    //     if (details != null) {
    //       setState(() {
    //         productDetail = details;
    //       });
    //     }
    //   } catch (e) {
    //     print("error -> $e");
    //   } finally {}
    // }
  }

  @override
  void initState() {
    super.initState();
    _checkForProductLink(widget.data['text']);
  }

  @override
  Widget build(BuildContext context) {
    final urlRegex = RegExp(r'(https?://[^\s]+)');
    final containsLink = urlRegex.hasMatch(widget.data['text']);
    return InkWell(
        // onLongPress: () => _showMessageOptions(context),
        child: Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              !widget.isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (!widget.isMe) ...[
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(120.0),
              // child:
              Stack(
                children: [
                  CustomImage(
                    image: '',
                    // data['sender']['image'] ?? '',
                    height: 40,
                    width: 40,
                    radius: 40,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.green,
                      ),
                    ),
                  ),
                ],
              ),
              // ),
              const SizedBox(width: 10),
            ],
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              child: IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.isMe ? 'sender' : 'receiver',
                          style: textSm.copyWith(
                              color: ColorResources.gray,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _formatTimestamp(widget.data['timestamp']),
                          style: body12,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: widget.isMe
                            ? ColorResources.primary
                            : ColorResources.lightBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: !widget.isMe
                              ? isDirectionRTL()
                                  ? const Radius.circular(12)
                                  : Radius.zero
                              : const Radius.circular(12),
                          topRight: !widget.isMe
                              ? isDirectionRTL()
                                  ? Radius.zero
                                  : const Radius.circular(12)
                              : const Radius.circular(12),
                          bottomLeft: widget.isMe
                              ? isDirectionRTL()
                                  ? Radius.zero
                                  : const Radius.circular(12)
                              : const Radius.circular(12),
                          bottomRight: widget.isMe
                              ? isDirectionRTL()
                                  ? const Radius.circular(12)
                                  : Radius.zero
                              : const Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.isMe ? 8 : 10,
                                vertical: widget.isMe ? 8 : 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!widget.isMe) ...[
                                  if (!(widget.data.data()
                                              as Map<String, dynamic>)
                                          .containsKey('type') ||
                                      widget.data['type'] == 'message') ...[
                                    if (widget.data['text'] != null &&
                                        widget.data['text'].isNotEmpty)
                                      containsLink
                                          // ? productDetail == null
                                          ? Linkify(
                                              onOpen: openLink,
                                              text: widget.data['text'],
                                            )
                                          // : InkWell(
                                          //     onTap: () {
                                          //       String productId =
                                          //           productDetail!.data!.id
                                          //               .toString();
                                          //       String productSlug =
                                          //           productDetail!.data!.slug
                                          //               .toString();
                                          //       Get.toNamed(
                                          //           '${AppRout.bookDetail}/$productId/$productSlug');
                                          //     },
                                          //     child: Column(
                                          //       mainAxisSize: MainAxisSize.min,
                                          //       children: [
                                          //         if (productDetail!
                                          //                 .data!.imageUrl !=
                                          //             null)
                                          //           SizedBox(
                                          //             // height: 300,
                                          //             child: CustomImage(
                                          //                 image: productDetail!
                                          //                     .data!.imageUrl,
                                          //                 height:
                                          //                     Get.height * 0.28,
                                          //                 width: Get.width,
                                          //                 radius: 10),
                                          //           ),
                                          //         const SizedBox(
                                          //           height: 10,
                                          //         ),
                                          //         Text(
                                          //           productDetail!.data!.name ??
                                          //               '',
                                          //           style:
                                          //               optionHeading.copyWith(
                                          //             color: const Color(
                                          //                 0xff29292D),
                                          //           ),
                                          //         ),
                                          //         const SizedBox(
                                          //           height: 5,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   )
                                          : Text(
                                              widget.data['text'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff29292D),
                                                  fontSize: 15),
                                            ),
                                  ] else if (widget.data['type'] ==
                                      'image') ...[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => FullScreenImage(
                                                imageUrl: widget.data['link']));
                                          },
                                          child: Hero(
                                            tag: widget.data['link'],
                                            child: CustomImage(
                                                image: widget.data['link'],
                                                height: Get.width * 0.6,
                                                width: Get.width * 0.6,
                                                radius: 10),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (widget.data['text'] != null &&
                                            widget.data['text'].isNotEmpty)
                                          containsLink
                                              // ? productDetail == null
                                              ? Linkify(
                                                  onOpen: openLink,
                                                  text: widget.data['text'],
                                                )
                                              // : InkWell(
                                              //     onTap: () {
                                              //       String productId =
                                              //           productDetail!.data!.id
                                              //               .toString();
                                              //       String productSlug =
                                              //           productDetail!
                                              //               .data!.slug
                                              //               .toString();
                                              //       Get.toNamed(
                                              //           '${AppRout.bookDetail}/$productId/$productSlug');
                                              //     },
                                              //     child: Column(
                                              //       mainAxisSize:
                                              //           MainAxisSize.min,
                                              //       children: [
                                              //         Text(
                                              //           productDetail!
                                              //                   .data!.name ??
                                              //               '',
                                              //           style: optionHeading
                                              //               .copyWith(
                                              //             color: const Color(
                                              //                 0xff29292D),
                                              //           ),
                                              //         ),
                                              //         const SizedBox(
                                              //           height: 5,
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   )
                                              : Text(
                                                  widget.data['text'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff29292D),
                                                      fontSize: 15),
                                                ),
                                      ],
                                    ),
                                  ],
                                  // if (data['reply_to'] != null) SizedBox(height: 5),
                                ],
                                if (widget.isMe)
                                  if (!(widget.data.data()
                                              as Map<String, dynamic>)
                                          .containsKey('type') ||
                                      widget.data['type'] == 'message') ...[
                                    if (widget.data['text'] != null &&
                                        widget.data['text'].isNotEmpty)
                                      containsLink
                                          // ? productDetail == null
                                          ? Linkify(
                                              onOpen: openLink,
                                              text: widget.data['text'],
                                            )
                                          // : InkWell(
                                          //     onTap: () {
                                          //       String productId =
                                          //           productDetail!.data!.id
                                          //               .toString();
                                          //       String productSlug =
                                          //           productDetail!.data!.slug
                                          //               .toString();
                                          //       Get.toNamed(
                                          //           '${AppRout.bookDetail}/$productId/$productSlug');
                                          //     },
                                          //     child: Column(
                                          //       mainAxisSize: MainAxisSize.min,
                                          //       children: [
                                          //         if (productDetail!
                                          //                 .data!.imageUrl !=
                                          //             null)
                                          //           SizedBox(
                                          //             // height: 300,
                                          //             child: CustomImage(
                                          //                 image: productDetail!
                                          //                     .data!.imageUrl,
                                          //                 height:
                                          //                     Get.height * 0.28,
                                          //                 width: Get.width,
                                          //                 radius: 10),
                                          //           ),
                                          //         const SizedBox(
                                          //           height: 10,
                                          //         ),
                                          //         Text(
                                          //           productDetail!.data!.name ??
                                          //               '',
                                          //           style:
                                          //               optionHeading.copyWith(
                                          //             color: const Color(
                                          //                 0xff29292D),
                                          //           ),
                                          //         ),
                                          //         const SizedBox(
                                          //           height: 5,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   )
                                          : Text(
                                              widget.data['text'],
                                              style: TextStyle(
                                                  color: widget.isMe
                                                      ? Colors.white
                                                      : ColorResources.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                  ] else if (widget.data['type'] ==
                                      'image') ...[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => FullScreenImage(
                                                imageUrl: widget.data['link']));
                                          },
                                          child: Hero(
                                            tag: widget.data['link'],
                                            child: CustomImage(
                                                image: widget.data['link'],
                                                height: Get.width * 0.6,
                                                width: Get.width * 0.6,
                                                radius: 10),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (widget.data['text'] != null &&
                                            widget.data['text'].isNotEmpty)
                                          containsLink
                                              // ? productDetail == null
                                              ? Linkify(
                                                  onOpen: openLink,
                                                  text: widget.data['text'],
                                                )
                                              // : InkWell(
                                              //     onTap: () {
                                              //       String productId =
                                              //           productDetail!.data!.id
                                              //               .toString();
                                              //       String productSlug =
                                              //           productDetail!
                                              //               .data!.slug
                                              //               .toString();
                                              //       Get.toNamed(
                                              //           '${AppRout.bookDetail}/$productId/$productSlug');
                                              //     },
                                              //     child: Column(
                                              //       mainAxisSize:
                                              //           MainAxisSize.min,
                                              //       children: [
                                              //         Text(
                                              //           productDetail!
                                              //                   .data!.name ??
                                              //               '',
                                              //           style: optionHeading
                                              //               .copyWith(
                                              //             color: widget.isMe
                                              //                 ? Colors.white
                                              //                 : ColorResources
                                              //                     .black,
                                              //           ),
                                              //         ),
                                              //         const SizedBox(
                                              //           height: 5,
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   )
                                              : Text(
                                                  widget.data['text'],
                                                  style: TextStyle(
                                                      color: widget.isMe
                                                          ? Colors.white
                                                          : ColorResources
                                                              .black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.end,
                                                ),
                                      ],
                                    ),
                                  ],
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Text(
                                    //   _formatTimestamp(
                                    //       widget.data['timestamp']),
                                    //   style: TextStyle(
                                    //       color: widget.isMe
                                    //           ? Colors.white70
                                    //           : Colors.black54,
                                    //       fontSize: 12,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                    if (widget.isMe && widget.fromSingle)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          widget.isMe &&
                                                  widget.data['read'] != null &&
                                                  widget.data['read'] == true
                                              ? Icons.done_all
                                              : Icons.done,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isMe) const SizedBox(width: 10),
          ],
        ),
      ),
    ));
  }
}
