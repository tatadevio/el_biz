// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

// import 'appConstant.dart';

// class FirebaseDynamicLinkService {
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

//   final String dynamicLink = 'https://isooq.page.links/';
//   final String link = 'https://isooq.page.links';

//   Future<dynamic> createDynamicLink(bool short, String id, String type,
//       String image, String title, String description) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://isooq.page.link',
//       link: Uri.parse(dynamicLink + "$id/$type"),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.isooq.tatadev',
//         minimumVersion: AppConstants.androidVersion,
//       ),
//       iosParameters: const IOSParameters(
//         appStoreId: AppConstants.appStoreId,
//         bundleId: 'kg.isooq.tatadev',
//         minimumVersion: AppConstants.iosVersion,
//       ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: title,
//         description: description,
//         imageUrl: Uri.parse(image),
//       ),
//     );

//     Uri url;
//     if (short) {
//       print("i am coming here");
//       final ShortDynamicLink shortLink =
//           await dynamicLinks.buildShortLink(parameters);
//       url = shortLink.shortUrl;
//       print("dynamic links is");
//       print(url);
//       return url;
//     } else {
//       url = await dynamicLinks.buildLink(parameters);
//       print("dynamic links is");
//       print(url);
//     }
//     return url;
//   }
// }
