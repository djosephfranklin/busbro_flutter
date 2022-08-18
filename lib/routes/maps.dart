import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This widget is the home page of the application.
class MapsPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapsPage> {
  @override
  void initState() {
    super.initState();
  }

  double _latitude = 1.34104;
  double _longitude = 103.9518783;

  Future<void> getUserLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _latitude = (prefs.getDouble('latitude') == null
        ? _latitude
        : prefs.getDouble('latitude'))!;
    _longitude = (prefs.getDouble('longitude') == null
        ? _longitude
        : prefs.getDouble('longitude'))!;
  }

  @override
  Widget build(BuildContext context) {
    //getUserLocation();
    //Completer<MapboxMapController> _controllerCompleter = Completer();

    return new MaterialApp(
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Text("Map")
              //MapboxMap(
              //accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
              //  initialCameraPosition: CameraPosition(
              //      target: LatLng(_latitude, _longitude), zoom: 15),
              //onMapCreated: _onMapCreated,
              //onStyleLoadedCallback: _onStyleLoadedCallback,
              //  myLocationEnabled: true,
              //  myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              //  minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
        ],
      )),
    );
  }
}
