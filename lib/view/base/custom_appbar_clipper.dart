// import 'package:flutter/material.dart';

// class AppBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();

//     double radius = 16.0;

//     // Start from top-left
//     path.moveTo(0, 0);

//     // Line to top-right
//     path.lineTo(size.width, 0);

//     // Line to bottom-right before the corner
//     path.lineTo(size.width, size.height - radius);

//     // Add bottom-right corner
//     path.quadraticBezierTo(
//       size.width,
//       size.height,
//       size.width - radius,
//       size.height,
//     );

//     // Line to bottom-left before the corner
//     path.lineTo(radius, size.height);

//     // Add bottom-left corner
//     path.quadraticBezierTo(
//       0,
//       size.height,
//       0,
//       size.height - radius,
//     );

//     // Close the path (back to the starting point)
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
