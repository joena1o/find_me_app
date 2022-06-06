import 'package:flutter/material.dart';

import 'DisplayPic.dart';

class EndedCard extends StatelessWidget {
  EndedCard({Key? key, required this.Data}) : super(key: key);

  final List Data;

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;

    return Container(
      width: sz.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: sz.width * .2,
            height: sz.width * .2,
            child: DisplayPic(initials: "${(Data[0]['first_name']).substring(0,1)} ${(Data[0]['last_name']).substring(0,1)}"),
          ),
          Container(
            width: sz.width * 0.6,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${Data[0]['first_name']} ${Data[0]['last_name']}"),
                Container(
                  height: 20,
                ),
                Text("Phone: ************"),
                Container(
                  height: 20,
                ),
                Text(("Date Sent: ${Data[0]['time_sent']}").substring(0, 21))
              ],
            ),
          )
        ],
      ),
    );
  }
}
