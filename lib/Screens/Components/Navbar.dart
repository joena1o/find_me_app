import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {

  Navbar({Key? key, this.name, this.callback}):super(key:key);

  var name;
  var callback;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.12,
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Hello,",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              //Container(height: 2,),
              Text("$name",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))
            ],
          ),
          GestureDetector(
              onTap: (){
                callback(4);
              },
              child:CircleAvatar(
            backgroundColor: Colors.green,
            radius: size.height*0.03,
            child: Text(
              name.substring(0,1),
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ))
        ],
      ),
    );
  }
}
