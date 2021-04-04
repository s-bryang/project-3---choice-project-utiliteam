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
  late Position currentPosition;
  String currentAddress = "";

  final Geolocator locator = Geolocator() .. forceAndroidLocationManager;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  getCurrentLocation()
  {
    locator.getCurrentPosition(desiredAccuracy:LocationAccuracy.best).then((Position pos)
    {
      setState(() 
      {
        currentPosition = pos;
      });
      getAddress();
    }).catchError((err)
    {
      print(err);
    });
  }

getAddress() async
{
  try
  {
    List<Placemark> places = await 
    locator.placemarkFromCoordinates(currentPosition.latitude, 
    currentPosition.longitude);

    Placemark p = places[0];
    setState(()
    {
      currentAddress = "${p.locality}, ${p.postalCode}, ${p.country}";
    });
  }
  catch (excep)
  {
    print(excep);
  }
}

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
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}