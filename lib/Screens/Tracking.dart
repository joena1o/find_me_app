import 'package:flutter/material.dart';
import 'Tabs/TrackingTab.dart';
import 'Tabs/EndedTab.dart';

class TrackingRequest extends StatefulWidget {
  @override
  _TrackingRequestState createState() => _TrackingRequestState();
}

class _TrackingRequestState extends State<TrackingRequest>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  var cartPrice;

  var tracking_num = 0;

  setTrackNum(val){

    setState((){

      tracking_num = val;

    });

  }

  void initState() {
    super.initState();

    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * .75,
      child: Column(
        children: [
          Container(
            height: size.height * .09,
            color: Colors.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: controller,
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 15),
                indicatorColor: Colors.green,
                tabs: [
                  Tab(text: 'Currently Tracking ${tracking_num}'),
                  Tab(
                    text: 'Ended 0',
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.height * .65,
            child: TabBarView(
              children: [
                Container(
                    color: Colors.white,
                    width: size.width,
                    height: size.height * .63,
                    child: TrackingTab(track: setTrackNum,)),
                Container(
                    width: size.width,
                    height: size.height * .63,
                    child: EndedTab()),
              ],
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
