import 'dart:async';
import 'package:find_me/RestApi/Tracking.dart';
import 'package:find_me/Utils/Prefs.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:lottie/src/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Components/TrackingBottomNav.dart';
import 'package:geolocator/geolocator.dart';



class Location extends StatefulWidget {
  Location({Key? key, this.name, this.email}):super(key: key);

  var email;
  var name;

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  Tracking tracking = Tracking();

  Prefs prefs = Prefs();

  late double findlng, findlat;

  bool expand = true;

  bool locationpending = true;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylinecoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();

  late double distanceInMeters = Geolocator.distanceBetween(37.42796133580664, -122.085749655962, 37.43296265331129, -122.08832357078792);

  Switch(){

    setState((){

      expand = !expand;

    });

  }

  Completer<GoogleMapController> _controller = Completer();

   CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 16.151926040649414,
    bearing: 192.8334901395799,
    tilt: 59.440717697143555,
  );

   CameraPosition _kLake = CameraPosition(
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

//    setPolyLines();

    _determinePosition().then((value){

      setState((){


        _kGooglePlex = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 16.151926040649414,
          bearing: 192.8334901395799,
          tilt: 59.440717697143555,
        );


        origin = Marker(
          markerId: const MarkerId('You'),
          infoWindow: const InfoWindow(title: 'Driver'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: LatLng(value.latitude, value.longitude),
        );



      });


      prefs.LoadPref().then((user)=>{

          tracking.UpdateLocation(value.latitude, value.longitude, user).then((status){

           if(status == "Success"){
//              setState((){locationpending = false;});
            }

          })

      });






    });

    FetchLocation(widget.email);

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
              height: (!expand)?size.height*0.369:size.height*0.865,
              color: Colors.grey,
              child:(!locationpending)?GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kLake,
                polylines: _polylines,
                markers: {
                    origin, dest
                  },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ):Container(
                child: Lottie.asset('assets/99680-3-dots-loading.json'),
              ),
            ),

        (!expand)?Container(
              width: size.width,
              height: size.height*0.495,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        Text("Tracking: ${widget.name}"),
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
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Distance: ${ double.parse((distanceInMeters).toStringAsFixed(2))}m"),
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




  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }



    FetchLocation(user) async{

      await tracking.FindLocation(user).then((value){

        setState((){

          CameraPosition _kLake = CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(double.parse(value[0]['lat']), double.parse(value[0]['lng'])),
              tilt: 59.440717697143555,
              zoom: 19.151926040649414);

          locationpending = true;

          });

      });




    }



}


