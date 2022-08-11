import 'dart:developer';
import 'dart:io';

import 'package:busbro_flutter/provider/busbatchprocess.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'provider/busdetailsprovider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SG Bus Bro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SG Bus Bro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late LocationData _locationData;
  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  void getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
  }

  void getBusArrival(String busStopCode) {
    setState(() {
      print(getBusArrivalDetails(busStopCode));
      _counter++;
    });
  }

  void getFavBus() {
    print(getFavBusDetails());
  }

  void getNearbyStops(double userLat, double userLong) {
    getNearbyBusStops(userLat, userLong).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getNearbyStops(_locationData.latitude!, _locationData.longitude!);
          //getBusArrival("01012");
          //getFavBus();
          //batchBusStops();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
