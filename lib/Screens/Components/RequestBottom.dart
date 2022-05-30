import 'package:find_me/RestApi/DashAct.dart';
import 'package:flutter/material.dart';

class RequestBottom extends StatelessWidget {

  RequestBottom({Key? key, required this.id, this.rec, this.user}):super(key: key);

  var id,rec, user;

  DashAct dash = DashAct();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(

      width: size.width * .6,
      height: size.height * 0.09,
      margin: EdgeInsets.symmetric(vertical: 9),

      child: Row(

        children: [

          Container(
            width: size.width*.3,

            child: FlatButton(
              onPressed: (){

                dash.AcceptRequest(rec,user).then((value){

                  print(value);

                });

              },
                child:Text("Accept", textAlign: TextAlign.center, style: TextStyle(color: Colors.green,
                fontWeight: FontWeight.bold, fontSize: 15),))
          ),
          Container(
            width: size.width*.3,
            child: FlatButton(
              onPressed: (){

              },
              child:Text("Decline", textAlign: TextAlign.center, style: TextStyle(color: Colors.red,
            fontWeight: FontWeight.bold, fontSize: 15),)),
          )

        ],

      ),


    );
  }
}
