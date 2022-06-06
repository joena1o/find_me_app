import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool loadComplete = false;

  Prefs prefs = Prefs();

  void Boot(value) {

    Timer(Duration(seconds: 19), () {

      print(value);

      if(value!=null || value.toString()!="null")
        widget.callback(3);
      else{
        setState(() {
          loadComplete = true;
        });
      }

    });

  }

  void initState() {
    super.initState();

    prefs.LoadPref().then((value){

        Boot(value);

    });


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "FIND ME",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 29,
                letterSpacing: 2.5),
          ),
          Container(
            height: size.height * 0.1,
          ),
          (!loadComplete)
              ? Container(
              width: size.height*0.3,
              height: size.height*0.3,
              child:Lottie.asset('assets/94027-location.json')):Container(),
          Container(
            height: size.height * 0.1,
          ),
          (!loadComplete)
              ? Container(
                  width: size.width * .1,
                  height: size.width * .1,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 10,
                  ),
                )
              : AuthButton()
        ],
      ),
    ));
  }

  Widget AuthButton() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: FlatButton(
            color: Colors.transparent,
            onPressed: () {
              widget.callback(2);
            },
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          margin: EdgeInsets.only(top: 20),
          child: FlatButton(
            color: Colors.transparent,
            onPressed: () {
              widget.callback(2);
            },
            child: Text(
              "Sign In",
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
