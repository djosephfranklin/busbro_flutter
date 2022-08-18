import 'package:busbro_flutter/provider/busdetailsprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/busdetail.dart';

class FavouritePage extends StatefulWidget {
  @override
  FavouritePageState createState() => FavouritePageState();
}

class FavouritePageState extends State<FavouritePage> {
  List<BusDetail> favBusList = [];
  int favLength = 0;
  String currFav = "";

  Future<List<BusDetail>> getFavBus() async {
    final prefs = await SharedPreferences.getInstance();
    String? favorite = prefs.getString('favBusStops');
    if (currFav != (favorite == null ? " " : favorite)) {
      getFavBusDetails().then((value) {
        setState(() {
          favBusList = value;
          print(favBusList.toString());
          favLength = value.length;
        });
      });
      currFav = favorite == null ? " " : favorite;
    }
    return Future.value(favBusList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FAVOURITE',
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
                  Icon(Icons.favorite_sharp),
                ],
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
          height: MediaQuery.of(context).size.height * 0.9,
          child: FutureBuilder<List<BusDetail>>(
            builder: (context, busList) {
              if (favBusList.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: favLength,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Column(
                          children: [_buildBox(context, favBusList[index])],
                        ),
                        // Widget to display the list of project
                      ],
                    );
                  },
                );
              } else {
                return Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 10.0,
                  width: 10.0,
                ));
              }
            },
            //initialData: getFavBus(),
            future: getFavBus(),
          ),
        ));
  }

  Widget _buildBox(BuildContext context, BusDetail busDetail) {
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
                          fontWeight: FontWeight.w500),
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
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
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
        borderRadius: BorderRadius.circular(10 * 0.8),
      ),
    );
  }

  Future<Null> _refresh() async {
    getFavBus();
  }
}
