import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "+234",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Container(
              width: size.width * .64,
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  //border: InputBorder.none
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  callback(text);
                },
              ))
        ],
      ),
    );
  }
}
