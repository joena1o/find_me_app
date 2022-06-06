import 'package:flutter/material.dart';
import 'RequestBottom.dart';
import 'DisplayPic.dart';

class RequestCards extends StatelessWidget {

  RequestCards({Key? key, required this.data, required this.con}):super(key:key);

  final List data;
  final String con;

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
          DisplayPic(initials: "${(data[0]['first_name']).substring(0,1)} ${(data[0]['last_name']).substring(0,1)}"),
          Container(
            width: size.width * .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data[0]['first_name']} ${data[0]['last_name']}"),
                Container(
                  height: 20,
                ),
                Text("Status: ${data[0]['status']}"),
                Container(
                  height: 20,
                ),
                Text("Phone:  * * * * * * * * * *"),
                Container(
                  height: 20,
                ),
                Text("Time Sent: ${(data[0]['time_sent']).substring(0,10)}"),
                Container(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      (con=="send")?Icons.call_missed_outgoing:Icons.call_missed,
                      color: (con=="send")?Colors.blue:Colors.green,
                    ),
                    Container(
                      width: 10,
                    ),
                    (con=="send")?Text("Sent Request"):Text("Incoming Request")
                  ],
                ),
                (con=="send")?Container():RequestBottom(id: data[0]['request_id'], rec: data[0]['receiver'], user: data[0]['email'])
              ],
            ),
          )
        ],
      ),
    );
  }
}
