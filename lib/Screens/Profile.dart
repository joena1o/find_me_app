import 'package:find_me/RestApi/Profile.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'Components/DisplayPic.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileClass profile = ProfileClass();

  Prefs prefs = Prefs();

  List data = [];

  fetch() async {

    prefs.LoadPref().then((value){

      profile.FetchDetails(value).then((value) {

        setState(() {
          data = value;
        });
      });


    });



  }

  void initState() {
    super.initState();

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.742,
      child: (data.length != 0)?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DisplayPic(initials: "${(data[0]['first_name']).substring(0,1)} ${(data[0]['last_name']).substring(0,1)}",),
          Container(height: 30),
          Container(
            margin: EdgeInsets.all(20),
            child: FlatButton(
              color: Colors.green,
              onPressed: (){

              },
              child: Text("Edit Profile", style: TextStyle(color: Colors.white),),
            )
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "${data[0]['first_name']}  ${data[0]['last_name']}",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "${data[0]['phone']}",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "Status: Online",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:Colors.green, width: 2)
              ),
              child: FlatButton(
                color: Colors.transparent,
                onPressed: (){

                  prefs.RemovePrefs();

                },
                child: Text("Sign Out", style: TextStyle(color: Colors.black),),
              )
          ),
        ],


      ):Center(
        child: Container(
            width: size.height*0.3,
            height: size.height*0.3,
            child:Lottie.asset('assets/99680-3-dots-loading.json')),
      ),
    );
  }
}
