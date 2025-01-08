import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:photo_view/photo_view.dart';

class ReviewPhotoGalleryView extends StatelessWidget {
  final List<XFile> galleries;
  final String productName;
  const ReviewPhotoGalleryView(
      {super.key, required this.galleries, required this.productName});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController(initialPage: 0);

    for (int i = 0; i < galleries.length; i++) {
      precacheImage(FileImage(File(galleries[i].path)), context);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          productName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: PageView.builder(
            controller: _controller,
            itemCount: galleries.length,
            physics: const AlwaysScrollableScrollPhysics(),
            onPageChanged: (page) {},
            itemBuilder: (context, index) {
              return PhotoView(
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
                //initialScale: PhotoViewComputedScale.covered * 0.9,
                imageProvider: FileImage(File(galleries[index].path)),

                // Image.file(
                //   galleries[index].image,
                // ),
              );
            }),
      ),
    );
  }
}

class ImageGalleryScreen extends StatefulWidget {
  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  List<String> images = [
    "https://yourimageurl1.png",
    "https://yourimageurl2.png",
    "https://yourimageurl3.png",
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Handle close button action
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(height: 10),
          SizedBox(height: 10),
          Text(
            '${(currentIndex + 1).toString().padLeft(2, '0')}/${images.length.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
