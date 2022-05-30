import 'package:flutter/material.dart';

class TrackingBottomNav extends StatelessWidget {
  TrackingBottomNav({Key? key, required this.callback, required this.state}):super(key:key);

  final Function callback;
  final bool state;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height*0.09,
      color: Colors.grey[200],
      child: Row(
        children: [

          Container(
            width: size.width/5,
            child: IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.call),
            ),
          ),

          Container(
            width: size.width/5,
            child: IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.message),
            ),
          ),


          Visibility(
              visible: state,
              child:Container(
            width: size.width/5,
            child: IconButton(
              onPressed: (){
                  callback();
              },
              icon: Icon(Icons.remove_red_eye),
            ),
          ))

        ],
      ),
    );
  }
}
