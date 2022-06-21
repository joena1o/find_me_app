import 'package:find_me/RestApi/Contacts.dart';
import 'package:find_me/RestApi/DashAct.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:find_me/Utils/utils.dart';
import 'package:flutter/material.dart';
import '../FindUser.dart';
import 'RequestCards.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'SearchBar.dart';

class DashBody extends StatefulWidget {
  @override
  _DashBodyState createState() => _DashBodyState();
}

class _DashBodyState extends State<DashBody> {
  Prefs prefs = Prefs();

  List dashStats = [];

  late IO.Socket socket;

   void initSocket() async{

    try{
      socket = IO.io(conn, <String, dynamic>{
        'transports':['websocket'],
        'autoConnect': false,
      });

      socket.connect();

      socket.onConnect((data){
        print("connected");
      });

      socket.on("location-changed",(data){

        print(data);

      });


    }catch(e){
      print(e.toString());
    }

  }

  var user = '';

  fetchStat() {
    prefs.LoadPref().then((value) {
      setState(() {
        user = value;
      });

      dashAct.fetchDash(value).then((values) {
        setState(() {
          dashStats = values;
        });
      });
    });
  }

  void initState() {
    super.initState();

    fetchStat();
    initSocket();
  }

  DashAct dashAct = DashAct();

  var phone = "";

  setPhone(value) {
    setState(() {
      phone = value;
    });
  }

  contactClass contact = contactClass();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.742,
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: dashStats.length + 1,
        itemBuilder: (BuildContext ctx, i) {
          if (i == 0) {
            return Column(
              children: [
                Container(
                  height: 20,
                ),
                SearchBar(
                  callback: setPhone,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => Center(
                                child: CircularProgressIndicator(
                                    color: Colors.green),
                              ));

                      contact.SearchContact(phone).then((value) {
                        if (value != "failed" || value != null) {


                          Navigator.of(context).pop();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => FindUser(Data: [value[0]])));
                        }
                      });
                    },
                    child: Text(
                      "Search Contact",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: FlatButton(
                    color: Colors.grey[200],
                    onPressed: () {
                    socket.emit("location-change","Hello World");
                    },
                    child: Text(
                      "Select from Favourites",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  //height: size.height*0.1,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tracking Requests",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        radius: 14,
                        child: Text(
                          "${dashStats.length}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  child: Divider(
                    color: Colors.black38,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ],
            );
          } else {
            return GestureDetector(
                onTap: () {
                  if (dashStats[i - 1]['user'] == user)
                    showModalBottomSheet(
                        context: context, builder: (_) => Modal(context));
                },
                child: RequestCards(data: [dashStats[i - 1]], con: "rec"));
          }
        },
      ),
    );
  }

  Widget Modal(context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.clear),
                  ),
                  Container(
                    width: 20,
                  ),
                  Text("Cancel Request")
                ],
              ),
            )
          ],
        ));
  }
}
