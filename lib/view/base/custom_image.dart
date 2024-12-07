import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

import '../../utils/Images.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final double radius;
  CustomImage({required this.image, required this.height, required this.width, this.fit = BoxFit.cover, required this.radius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: image.contains(".svg")
          ? SvgPicture.network(
              image,
              height: height,
              width: width,
              fit: fit,
            )
          : CachedNetworkImage(
              imageUrl: image,
              height: height == 0 ? null : height,
              width: width,
              fit: fit,
              placeholder: (context, url) => Image.asset(Images.placeholder, height: height, width: width, fit: fit),
              errorWidget: (context, url, error) => Image.asset(Images.placeholder, height: height, width: width, fit: fit),
            ),
    );
  }
}

class ViewPhoto extends StatelessWidget {
  final String image;
  const ViewPhoto({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: PhotoView(
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
        initialScale: PhotoViewComputedScale.contained * 0.85,
        imageProvider: NetworkImage(image),
      ),
    );
  }
}
