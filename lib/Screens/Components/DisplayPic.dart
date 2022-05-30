import 'package:flutter/material.dart';

class DisplayPic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.2,
      height: size.width * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image(
          image: AssetImage("assets/user.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
