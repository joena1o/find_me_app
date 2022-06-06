import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.742,
      child: ListView(
        children: [
          Container(
            height: size.height *.1,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
                "Notifications",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: size.width,
            height: size.height * .642,
          )
        ],
      ),
    );
  }
}
