import 'package:find_me/RestApi/Request.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter/material.dart';

import 'Components/RequestCards.dart';

class SentRequest extends StatefulWidget {
  @override
  _SentRequestState createState() => _SentRequestState();
}

class _SentRequestState extends State<SentRequest> {
  Request request = Request();

  Prefs prefs = Prefs();

  List Data = [];

  fetchSentRequest() {
    prefs.LoadPref().then((value) {
      request.FetchSent(value).then((value) {
        if (value != null || value != "failed") {
          setState(() {
            Data = value;
          });
        } else {}
      });
    });
  }

  void initState() {
    super.initState();

    fetchSentRequest();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.742,
      child: ListView(
        children: [
          Container(
            height: size.height * .09,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(20),
            child: Text(
              "Sent Requests",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: size.width,
            height: size.height * .642,
            child: ListView.builder(
              itemCount: Data.length,
              itemBuilder: (BuildContext ctx, i){

                return RequestCards(data: [Data[0]], con: "send",);

              },
            ),
          )
        ],
      ),
    );
  }
}
