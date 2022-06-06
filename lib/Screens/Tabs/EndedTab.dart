import 'package:find_me/RestApi/Tracking.dart';
import 'package:find_me/Screens/Components/EndedCard.dart';
import 'package:find_me/Screens/Components/RequestCards.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter/material.dart';

class EndedTab extends StatefulWidget {
  EndedTab({Key? key, this.ended}):super(key: key);

  var ended;

  @override
  _EndedTabState createState() => _EndedTabState();
}

class _EndedTabState extends State<EndedTab> {


  Tracking tracking = Tracking();

  Prefs pref = Prefs();

  List Ended = [];

  var newData;


  fetchEnded(){

    pref.LoadPref().then((value){
      tracking.fetchEnded(value).then((values){
        pref.LoadPhone().then((phone){
          newData = values.where((o) => o['phone'] != phone).toList();
          setState(() {
            Ended = newData;
          });
          widget.ended(newData.length);
        });
      });
    });

  }


  void initState(){

    super.initState();

    fetchEnded();

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: Ended.length,
      itemBuilder: (BuildContext ctx, i){
        return EndedCard(Data: [Ended[i]],);

      },
    );
  }
}
