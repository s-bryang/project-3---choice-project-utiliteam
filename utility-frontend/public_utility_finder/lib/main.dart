import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Position? currentPosition = null;
  late String currentAddress;

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
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [ 
          GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
            ),
          ),
          if(currentPosition != null)
            Text(
              "Latitude: ${currentPosition!.latitude}, Longitude: ${currentPosition!.longitude}"
              ),
              TextButton(
                child: Text("Obtain location"),
                onPressed: () {
                  getCurrentLocation();
            }
        ),
        ],
      ),
    )));
  }
  getCurrentLocation() {
    Geolocator
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .then((Position pos) {
      setState((){
        currentPosition = pos;
      });
    }).catchError((err){
      print(err);
      });
    }
  }