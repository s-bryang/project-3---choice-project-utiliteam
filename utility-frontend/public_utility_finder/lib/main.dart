import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
import "package:geocoding/geocoding.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Position? currentPosition = null;
  String? currentAddress = "";

  final LatLng _center = const LatLng(45.521563, -122.677433);
  // Future<void> initializeAppState()
  // async {
    
  //   currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,
  //   forceAndroidLocationManager: true).catchError((error) => print(error));
  //   print(currentPosition.toString());
  // }
  

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps Display'),
          backgroundColor: Colors.green[700],
        ),
        body: Row(
          children: [
            Expanded(
              child:  GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                if(currentAddress != null)
                Text(
                  "Address: ${currentAddress}"
                ),
                Text(
                  "Would you like the app to use your current location?"
                ),
                TextButton(
                  child: Text("Obtain location"),
                  onPressed: () {
                    getCurrentLocation();
                  }
                )
              ],
          )
        )
      ]
      ),
    ));
  }
  getCurrentLocation() {
    Geolocator
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .then((Position pos) {
      setState((){
        currentPosition = pos;
        getAddress();
      });
    }).catchError((err){
      print(err);
      });
    }

    getAddress() async{
      try{
        List<Placemark> marks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
          Placemark mark = marks[0];
          setState(() {
            currentAddress = "${mark.locality}, ${mark.postalCode}, ${mark.country}";
          });
      }
      catch (err){
        print(err);
      }
    }
  }