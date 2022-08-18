import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/busdetail.dart';
import '../provider/busdetailsprovider.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String searchString = "";

  List<BusDetail> searchBusList = [];

  int searchBusLength = 0;

  Future<List<BusDetail>> searchBuses(String searchString) {
    searchBus(searchString).then((value) {
      setState(() {
        searchBusList = value;
        searchBusLength = searchBusList.length;
      });
    });
    return Future.value(searchBusList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SEARCH',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                    letterSpacing: 0.1,
                    // color for lighter white so that it's not too hard on the eyes
                    color: false ? Color(0xccFFFFFF) : Colors.black,
                  ),
                ),
                textAlign: TextAlign.left,
              ),
              Icon(Icons.search_sharp),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              TextField(
                style: GoogleFonts.rubik(),
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Color.fromARGB(255, 12, 17, 85))),
                    hintText: 'Search Bus No/Bus Stops',
                    labelText: 'Find Bus/ Bus Stops',
                    prefixText: '',
                    contentPadding: EdgeInsets.only(left: 10)),
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    searchString = value;
                    searchBus(searchString);
                  });
                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 13, 35, 100),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print(searchString);
                    searchBuses(searchString);
                  },
                  child: Text(
                    'Search',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 236, 235, 232),
                          fontWeight: FontWeight.w600),
                    ),
                  ))
            ],
          ),
        ),
        _buildHome(context)
      ],
    );
  }

  Widget _buildHome(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: FutureBuilder<List<BusDetail>>(
          builder: (context, busList) {
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: searchBusLength,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Column(
                      children: [_buildBox(context, searchBusList[index])],
                    ),
                    // Widget to display the list of project
                  ],
                );
              },
            );
          },
          //initialData: getFavBus(),
          future: searchBus(searchString),
        ),
      ),
    );
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
    searchBuses(searchString);
  }
}
