import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter/material.dart';
import 'Components/BottomNav.dart';
import 'Components/DashBody.dart';
import 'Components/Navbar.dart';
import 'History.dart';
import 'Profile.dart';
import 'SentRequest.dart';
import 'Tracking.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  Prefs prefs = Prefs();

  int currNav = 0;

  SwitchNav(i) {
    setState(() {
      currNav = i;
    });
  }

  var name = "";

  fetchName(){

    prefs.LoadName().then((value){

      print(name);

      setState((){

        name = value;

      });
    });

  }

  void initState(){

    super.initState();

    fetchName();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            Navbar(name: name, callback: SwitchNav),
            (currNav == 0)
                ? DashBody()
                : ((currNav == 2)
                    ? TrackingRequest()
                    : ((currNav == 3)
                        ? History()
                        : ((currNav == 4) ? Profile() : SentRequest())))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNav(
          callback: SwitchNav,
          index: currNav,
        ),
      ),
    );
  }
}
