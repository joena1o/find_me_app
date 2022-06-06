import 'package:find_me/RestApi/Tracking.dart';
import 'package:flutter/material.dart';
import '../LocationTracking.dart';
import 'RequestBottom.dart';
import 'DisplayPic.dart';

class ReceiveCard extends StatelessWidget {
  ReceiveCard({Key? key, required this.Data, this.callback, this.index}):super(key: key);

  final List Data;
  var callback;
  var index;

  Tracking tracking = Tracking();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DisplayPic(initials:"${(Data[0]['first_name']).substring(0,1)} ${(Data[0]['last_name']).substring(0,1)}"),
          Container(
            width: size.width * .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${Data[0]['first_name']} ${Data[0]['last_name']}"),
                Container(
                  height: 20,
                ),
                Text("Phone: ${Data[0]['phone']}"),
                Container(
                  height: 20,
                ),
                Text("Coordinates: Lat ****, Lng **** "),
                Container(
                  height: 20,
                ),
                Container(
                  width: size.width * .6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: size.width * .15,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_)=> Location(name: "${Data[0]['first_name']} ${Data[0]['last_name']}"  )
                              )
                            );
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * .15,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          onPressed: () {



                            tracking.endTracking(Data[0]['request_id']).then((value){

                              print(value);

                              if(value=="Done")
                                callback(index);

                            });

                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
