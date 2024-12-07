// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class ContactSupportScreen extends StatefulWidget {
//   const ContactSupportScreen({super.key});

//   @override
//   State<ContactSupportScreen> createState() => _ContactSupportScreenState();
// }

// class _ContactSupportScreenState extends State<ContactSupportScreen> {
//   List<String> typeImages = [
//     Images.svgFavoriteBorder,
//     Images.refreshSvg,
//     Images.blockSvg,
//     Images.plusCircleSvg,
//     Images.creditCardSvg,
//     Images.mailSvg,
//   ];

//   List<String> title = [
//     "Is there a free trial?",
//     "Can I change my plan later?",
//     "What is your cancellation policy?",
//     "Can I add other information to the invoice?",
//     "How does invoicing work?",
//     "How do I change my account email?",
//   ];

//   List<String> description = [
//     "Yes, you can try it free for 30 days. Our friendly team will help you get started quickly.",
//     "Certainly. Our pricing policy scales with your company. Contact our friendly team to find a solution that suits you.",
//     "We understand that circumstances may change. You can cancel your plan at any time and we will refund the difference you have already paid.",
//     "Currently, the only way to add additional information to invoices is to add that information to the workspace title.",
//     "Plans operate at the workspace level, not at the account level. You can upgrade one workspace and still have as many free workspaces as you want.",
//     "You can change the email address associated with your account by going to untitled.com/account from a laptop or desktop computer.",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     // var height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       backgroundColor: ColorResources.background,
//       appBar: AppBar(
//         title: Text("Support".tr),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 28.0),
//         child: Container(
//           decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(24.0),
//                   topLeft: Radius.circular(24.0))),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     children: [
//                       const Row(
//                         children: [
//                           SizedBox(
//                             height: 40,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         "Frequently Asked Questions".tr,
//                         textAlign: TextAlign.center,
//                         style: normalTextStyle.copyWith(
//                             color: ColorResources.primary,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Ask us a question".tr,
//                         textAlign: TextAlign.center,
//                         style: boldTextStyle.copyWith(fontSize: 32),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Do you have any questions? Here are the most frequently asked questions."
//                             .tr,
//                         textAlign: TextAlign.center,
//                         style: normalTextStyle.copyWith(
//                             fontSize: 18, color: ColorResources.grey),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         height: 45,
//                         width: width * .9,
//                         decoration: BoxDecoration(
//                             color: ColorResources.background,
//                             borderRadius: BorderRadius.circular(12.0)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(Images.svgSearch),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             Text(
//                               "Search question".tr,
//                               style: normalTextStyle,
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   color: ColorResources.background,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         for (int i = 0; i < typeImages.length; i++)
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 40,
//                                 width: 40,
//                                 decoration: const BoxDecoration(
//                                     color: ColorResources.primary,
//                                     shape: BoxShape.circle),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: SvgPicture.asset(
//                                     typeImages[i],
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Text(
//                                 title[i].tr,
//                                 style: boldTextStyle.copyWith(fontSize: 18),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 description[i].tr,
//                                 style: normalTextStyle.copyWith(
//                                     fontSize: 16, color: ColorResources.grey),
//                               ),
//                               const SizedBox(
//                                 height: 35,
//                               ),
//                             ],
//                           ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12.0)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Any more questions?".tr,
//                                   style: boldTextStyle.copyWith(fontSize: 18),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   "Can't find the answer you're looking for? Please contact our team."
//                                       .tr,
//                                   style: normalTextStyle.copyWith(
//                                       fontSize: 16, color: ColorResources.grey),
//                                 ),
//                                 const SizedBox(
//                                   height: 25,
//                                 ),
//                                 CustomButton(
//                                   width: Get.width * .5,
//                                   height: 45,
//                                   onTap: () {},
//                                   title: "Contact us".tr,
//                                 ),
//                                 const SizedBox(
//                                   height: 35,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
