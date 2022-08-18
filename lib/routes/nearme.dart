import 'dart:async';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/busdetail.dart';
import '../provider/busdetailsprovider.dart';
import '../util/animatetoggle.dart';

LocationData? _locationData;

class NearMePage extends StatefulWidget {
  @override
  NearMePageState createState() => NearMePageState();
}

class NearMePageState extends State<NearMePage> {
  List<BusDetail> nearMeBusList = [];
  late double currLat = 0.00;
  int nearMeLength = 0;
  String favorite = "";

  var _toggleValue;

  Future<LocationData> getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.value(null);
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.value(null);
      }
    }
    _locationData = await location.getLocation();
    print(_locationData);
    return Future.value(_locationData);
  }

  Future<List<BusDetail>> getNearbyStops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorite = prefs.getString('favBusStops')!;
    if (_locationData != null && currLat != _locationData?.latitude!) {
      getNearbyBusStops(_locationData!.latitude!, _locationData!.longitude!)
          .then((value) {
        setState(() {
          currLat = _locationData?.latitude! as double;
          nearMeBusList = value;
          nearMeLength = value.length;
        });
      });
    }
    return Future.value(nearMeBusList);
  }

  Future<void> addFav(String busStopCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorite = prefs.getString('favBusStops')!;
    prefs.setString('favBusStops', favorite.toString() + "," + busStopCode);
    favorite = prefs.getString('favBusStops')!;
  }

  @override
  Widget build(BuildContext context) {
    if (_locationData == null) {
      getUserLocation().then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setDouble('latitude', value.latitude!.toDouble());
        prefs.setDouble('longitude', value.longitude!.toDouble());
        favorite = prefs.getString('favBusStops')!;
        getNearbyStops();
      });
    }
    List<bool> _selections = [false, true];
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEAR ME',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                        letterSpacing: 0.1,
                        // color for lighter white so that it's not too hard on the eyes
                        color: false ? Colors.white70 : Colors.black,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Icon(Icons.near_me),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: AnimatedToggle(
                values: ['LIST', 'MAP'],
                onToggleCallback: (value) {
                  setState(() {
                    _toggleValue = value;
                  });
                },
                buttonColor: Color.fromARGB(255, 17, 40, 125),
                backgroundColor: Color.fromARGB(255, 171, 187, 247),
                textColor: Color.fromARGB(255, 254, 251, 251),
              ),
            ),
            _buildHome(context)
          ],
        ));
  }

  Widget _buildHome(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: FutureBuilder<List<BusDetail>>(
            builder: (context, busList) {
              if (nearMeBusList.length == 0) {
                return Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 10.0,
                  width: 10.0,
                ));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: nearMeLength,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onDoubleTap: () {
                        print('Tapped');
                        addFav(nearMeBusList[index].busStopCode);
                        _refresh();
                      },
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: [
                              _buildBox(
                                  context,
                                  nearMeBusList[index],
                                  favorite.contains(
                                          nearMeBusList[index].busStopCode)
                                      ? "favorite"
                                      : favorite),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            future: getNearbyStops(),
          ),
        ));
  }

  Widget _buildBox(BuildContext context, BusDetail busDetail, String fav) {
    return new Container(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 20,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    busDetail.roadDescription,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 8, 8, 8),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      busDetail.busStopCode,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 181, 179, 173),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      busDetail.distance.toString().substring(0, 4) + " km",
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 181, 179, 173),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        borderRadius: BorderRadius.circular(10 * 0.8),
        // onTap: () => ConfirmationBottomSheets.confirmAction(context, code, service),
        onTap: () {},
      ),
      margin: EdgeInsets.only(
        left: 18,
        right: 18,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 244),
        border: fav == "favorite"
            ? Border.all(color: Colors.blue.shade200)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10 * 0.8),
      ),
    );
  }

  Future<Null> _refresh() async {
    getNearbyStops();
  }
}
