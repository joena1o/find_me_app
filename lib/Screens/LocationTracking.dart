import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Components/TrackingBottomNav.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  bool expand = false;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylinecoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();

  Switch(){

    setState((){

      expand = !expand;

    });

  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 16.151926040649414,
    bearing: 192.8334901395799,
    tilt: 59.440717697143555,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  Marker dest = Marker(
    markerId: const MarkerId('Friend'),
    infoWindow: const InfoWindow(title: 'Driver'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: LatLng(37.43296265331129, -122.08832357078792),
  );


  Marker origin = Marker(
    markerId: const MarkerId('You'),
    infoWindow: const InfoWindow(title: 'Driver'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(37.42796133580664, -122.085749655962),
  );


  void initState(){

    super.initState();

    setPolyLines();

  }



  @override
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(

      body: Container(

        width: size.width,
        height: size.height,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: size.width,
              height: (!expand)?size.height/2:size.height*0.865,
              color: Colors.grey,
              child: GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: _kGooglePlex,
                polylines: _polylines,
                markers: {
                    origin, dest
                  },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),

        (!expand)?Container(
              width: size.width,
              height: size.height*0.365,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              color: Colors.grey[200],
              child: ListView(
                children:[

                  GestureDetector(
                    onTap:(){

                      setState((){

                        expand = !expand;

                      });

                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child:Text("Collapse", style: TextStyle(color: Colors.green, letterSpacing: 1.5, fontSize: 17, fontWeight: FontWeight.bold),)),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tracking: Hyefur Jonathan"),
                        Icon(Icons.location_on, color: Colors.green, size: 39,)
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("You"),
                        Icon(Icons.location_on, color: Colors.blue, size: 39,)
                      ],
                    ),
                  )

                ]
              ),
            ):Container(),

          ],
        ),

      ),

      bottomNavigationBar: TrackingBottomNav(state: expand, callback: Switch,),

    ));
  }

  setPolyLines()async {

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCiet_FcKQLiHioow4uunEJ8TrtWS8wUsc',

      PointLatLng(37.42796133580664, -122.085749655962),

      PointLatLng(37.43296265331129, -122.08832357078792),

    );

    print("result= ${result.points}");

    if(result.status == "OK"){

      result.points.forEach((PointLatLng point) {


        setState((){

          polylinecoordinates.add(
              LatLng(point.latitude, point.longitude)
          );


        });



      });

      setState((){

        _polylines.add(
            Polyline(
                width: 3,
                polylineId: PolylineId("polyline"),
                color: Colors.red,
                points: polylinecoordinates
            )
        );

      });

    }


  }

}


