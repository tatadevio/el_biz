
// import 'package:flutter/material.dart';
// import 'dart:io';

// class ImagePreviewScreen extends StatefulWidget {
//   final File imageFile;
//   final Function(String, String) onSend;

//   ImagePreviewScreen({required this.imageFile, required this.onSend});

//   @override
//   _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
// }

// class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
//   final TextEditingController _captionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.check),
//             onPressed: () async {
//               // Show loading indicator
//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (BuildContext context) {
//                   return Center(child: CircularProgressIndicator());
//                 },
//               );

//               try {
//                 String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//                 Reference ref = FirebaseStorage.instance.ref().child('chat_images/$fileName');
//                 await ref.putFile(widget.imageFile);
//                 String downloadURL = await ref.getDownloadURL();

//                 // Hide loading indicator
//                 Navigator.of(context).pop();

//                 // Send the image URL and caption, then close the preview screen
//                 widget.onSend(downloadURL, _captionController.text);
//                 Navigator.of(context).pop();
//               } catch (e) {
//                 // Hide loading indicator
//                 Navigator.of(context).pop();

//                 // Show error message
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Failed to upload image. Please try again.')),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: Image.file(widget.imageFile),
//             ),
//           ),
//           Container(
//             color: Colors.black.withOpacity(0.5),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: TextField(
//               controller: _captionController,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: 'Add a caption...',
//                 hintStyle: TextStyle(color: Colors.white70),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }