import 'package:find_me/RestApi/Contacts.dart';
import 'package:find_me/RestApi/Favourites.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter/material.dart';
import 'Components/DisplayPic.dart';

class FindUser extends StatefulWidget {
  FindUser({Key? key, required this.Data}) : super(key: key);

  final List Data;

  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  List data = [];

  String user = "";

  FavouriteClass fav = FavouriteClass();

  Prefs prefs = Prefs();

  void initState() {
    super.initState();

    setState(() {
      data = widget.Data;
    });
  }

  contactClass contact = contactClass();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("FindMe User"),
        elevation: 0,
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.green,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DisplayPic(),
              Container(height: 30),
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
              )
            ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              width: size.width,
              height: size.height * 0.09,
              child: Row(
                children: [
                  Container(
                      color: Colors.green,
                      width: size.width * .5,
                      child: Center(
                          child: IconButton(
                              onPressed: () async {
                                var user = await prefs.LoadPref();

                                contact.SendRequest(
                                        user, data[0]['email'].toString())
                                    .then((value) {
                                  if (value == "Sent")
                                    Navigator.of(context).pop();
                                });
                              },
                              icon: Icon(Icons.send)))),
                  Container(
                      color: Colors.blueGrey,
                      width: size.width * .5,
                      child: Center(
                          child: IconButton(
                              onPressed: () {

                                prefs.LoadPref().then((value){
                                  fav.AddContact(value,data[0]['user_id']).then((value)=>print(value));
                                });



                              }, icon: Icon(Icons.favorite_outline))))
                ],
              ))),
    );
  }
}
