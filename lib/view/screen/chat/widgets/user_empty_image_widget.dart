import 'dart:math';

import 'package:flutter/material.dart';

class UserEmptyImageWidget extends StatelessWidget {
  final String userName;
  const UserEmptyImageWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Color backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return CircleAvatar(
      radius: (size.height * 0.05) / 2,
      backgroundColor: Colors.black,
      child: Text(
        userName.isNotEmpty ? userName[0].toUpperCase() : '',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
