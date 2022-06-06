import 'package:find_me/RestApi/Tracking.dart';
import 'package:find_me/Screens/Components/ReceiveCard.dart';
import 'package:find_me/Screens/Components/RequestCards.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter/material.dart';


class TrackingTab extends StatefulWidget {
  TrackingTab({Key? key, required this.track}) : super(key: key);

  final Function track;

  @override
  _TrackingTabState createState() => _TrackingTabState();
}

class _TrackingTabState extends State<TrackingTab> {
  Prefs prefs = Prefs();

  var user = '';

  var newData = [];

  Tracking tracking = Tracking();

  List TrackList = [];

  removeIndex(i){
    setState((){
      TrackList.removeAt(i);
    });
  }

  fetchData() {
    prefs.LoadPref().then((value) {
      tracking.fetchTracking(value).then((values) {
        prefs.LoadPhone().then((phone) {
          newData = values.where((o) => o['phone'] != phone).toList();
          setState(() {
            TrackList = newData;
          });
          widget.track(newData.length);
        });
      });
    });
  }

  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: TrackList.length,
      itemBuilder: (BuildContext ctx, i) {
        return ReceiveCard(Data: [TrackList[i]], callback: removeIndex, index: i,);
      },
    );
  }
}
