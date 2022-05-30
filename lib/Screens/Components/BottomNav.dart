import 'package:flutter/material.dart';


class BottomNav extends StatelessWidget {

  BottomNav({Key? key, required this.callback, required this.index}):super(key: key);

  final Function callback;
  final int index;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(

      width: size.width,
      height: size.height*0.09,
      margin: EdgeInsets.symmetric(horizontal: 10),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          IconButton(
            onPressed: (){

              callback(0);


            },
            icon: Icon(Icons.home,  size: 27, color: (index==0)?Colors.green:Colors.black,),

          ),

          IconButton(
            onPressed: (){

              callback(1);


            },
            icon: Icon(Icons.call_missed_outgoing, size: 27, color: (index==1)?Colors.green:Colors.black,),

          ),

//          IconButton(
//            onPressed: (){
//
//              callback(1);
//
//
//            },
//            icon: Icon(Icons.favorite_outline, size: 27, color: (index==1)?Colors.green:Colors.black,),
//
//          ),

          IconButton(
            onPressed: (){

              callback(2);


            },
            icon: Icon(Icons.location_on, size: 35, color: (index==2)?Colors.green:Colors.grey,),

          ),



          IconButton(
            onPressed: (){

              callback(3);

            },
            icon: Icon(Icons.notifications_none,  size: 27, color: (index==3)?Colors.green:Colors.black,),

          ),

          IconButton(
            onPressed: (){

              callback(4);

            },
            icon: Icon(Icons.person_outline,  size: 27, color: (index==4)?Colors.green:Colors.black,),

          )


        ],

      ),


    );
  }
}

