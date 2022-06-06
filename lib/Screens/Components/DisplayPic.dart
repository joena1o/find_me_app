import 'package:flutter/material.dart';

class DisplayPic extends StatelessWidget {
  DisplayPic({Key? key, this.initials}):super(key: key);

  var initials = null;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.2,
      height: size.width * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: (initials==null)?Image(
          image: AssetImage("assets/user.jpg"),
          fit: BoxFit.cover,
        ):Container(
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.grey,
            child: Text(initials, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}
