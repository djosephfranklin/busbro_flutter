import 'package:busbro_flutter/provider/busdetailsprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/busdetail.dart';

class MorePage extends StatefulWidget {
  @override
  MorePageState createState() => MorePageState();
}

class MorePageState extends State<MorePage> {
  List<BusDetail> favBusList = [];
  int favLength = 0;
  String theme = "light";

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MORE',
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
                  Icon(Icons.more),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 20,
                                        child: Column(children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Icon(
                                                    Icons
                                                        .theater_comedy_rounded,
                                                    size: 30,
                                                  )),
                                              Text(
                                                "Choose Theme",
                                                style: GoogleFonts.rubik(
                                                  textStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 8, 8, 8),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue.shade900,
                                                    textStyle: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {});
                                                  },
                                                  child: Text(
                                                    "Light Theme",
                                                    style: GoogleFonts.rubik(
                                                      textStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 8, 8, 8),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue.shade900,
                                                    textStyle: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Dark Theme",
                                                    style: GoogleFonts.rubik(
                                                      textStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 8, 8, 8),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
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
                            ),
                            Container(
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 20,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "Favourites",
                                            style: GoogleFonts.rubik(
                                              textStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 8, 8, 8),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
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
                                borderRadius: BorderRadius.circular(10 * 0.8),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 20,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "View MRT Map",
                                            style: GoogleFonts.rubik(
                                              textStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 8, 8, 8),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
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
                                borderRadius: BorderRadius.circular(10 * 0.8),
                              ),
                            )
                          ],
                        ),
                        // Widget to display the list of project
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
