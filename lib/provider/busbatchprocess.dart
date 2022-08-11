import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

/*
* To be run to get the complete list of bus stops and then 
* compare against the BusProperties file. This can be run
* every week to compare if any new bus stops is introduced
*/

Future<void> batchBusStops() async {
  String url = "http://datamall2.mytransport.sg/ltaodataservice/BusStops";

  try {
    Map<String, String> requestHeaders = {
      'User-Agent': '"Mozilla/5.0"',
      'Accept': 'application/json',
      'AccountKey': 'sxeLsqA5TYGPoOXo0P/jDg=='
    };
    String resString = "";
    for (var counter = 0; counter < 6000; counter = counter + 500) {
      url = url + "?\$skip=" + counter.toString();
      print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      resString = resString + jsonEncode(body['value']);
      if (response.statusCode == 200) {
        print("started writing");
        resString = resString.replaceAll("BusStopCode", "b");
        resString = resString.replaceAll("RoadName", "r");
        resString = resString.replaceAll("Description", "d");
        resString = resString.replaceAll("Latitude", "la");
        resString = resString.replaceAll("Longitude", "lo");
        resString = resString.replaceAll("[[", "content=[");
        resString = resString.replaceAll("][", ",");
        resString = resString.replaceAll("],[", ",");
        resString = resString.replaceAll("]]", "]");
        //log("writing done" + resString);
      } else {
        throw Exception('Failed to load album' + response.body);
      }
    }

    String busProperties = "";
    readContent().then((value) {
      busProperties = value.replaceAll("content=", "").toString();
      if (resString == busProperties) {
        print("same");
      } else {
        print("not same");
      }
    });
  } catch (e) {
    e.toString();
  }
}

Future<String> localFile() async {
  return rootBundle.loadString('assets/BusProperties.properties');
}

Future<String> readContent() async {
  try {
    print("file read");
    // Read the file
    final contents = await localFile();

    return contents.toString();
  } catch (e) {
    // If encountering an error, return 0
    return "";
  }
}
