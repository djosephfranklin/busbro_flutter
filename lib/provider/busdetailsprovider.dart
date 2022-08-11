import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:busbro_flutter/model/busmodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/services.dart' show rootBundle;

Future<BusModel> getBusArrivalDetails(String busStopCode) async {
  Map<String, String> requestHeaders = {
    'User-Agent': '"Mozilla/5.0"',
    'Accept': 'application/json',
    'AccountKey': 'sxeLsqA5TYGPoOXo0P/jDg=='
  };
  final response = await http.get(
    Uri.parse(
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=' +
            busStopCode),
    headers: requestHeaders,
  );
  if (response.statusCode == 200) {
    return BusModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load bus details' + response.body);
  }
}

Future<void> getFavBusDetails() async {
  final prefs = await SharedPreferences.getInstance();
  final String? favorite = prefs.getString('favBusStops');
  print("FAVOURITE : " + favorite.toString());
}

Future<List<dynamic>> getNearbyBusStops(
    double latitude, double longitude) async {
  double sectorHorRange0 = 1.404396;
  double sectorHorRange1 = 1.349823;
  double sectorHorRange2 = 1.320048;

  double sectorRange0 = 103.675305;
  double sectorRange1 = 103.711011;
  double sectorRange2 = 103.743627;
  double sectorRange3 = 103.776414;
  double sectorRange4 = 103.820229;
  double sectorRange5 = 103.849798;
  double sectorRange6 = 103.879667;
  double sectorRange7 = 103.905073;
  double sectorRange8 = 103.937517;
  double sectorRange9 = 103.967214;
  String fileName = "";

  if (longitude <= sectorRange0) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector0.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector1.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector2.properties";
    }
  }
  if ((longitude) > sectorRange0 && (longitude) < sectorRange1) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector3.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector4.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector5.properties";
    }
  }
  if ((longitude) > sectorRange1 && (longitude) < sectorRange2) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector6.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector7.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector8.properties";
    }
  }
  if ((longitude) > sectorRange2 && (longitude) < sectorRange3) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector9.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector10.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector11.properties";
    }
  }
  if ((longitude) > sectorRange3 && (longitude) < sectorRange4) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector12.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector13.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector14.properties";
    }
  }
  if ((longitude) > sectorRange4 && (longitude) < sectorRange5) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector15.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector16.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector17.properties";
    }
  }
  if ((longitude) > sectorRange5 && (longitude) < sectorRange6) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector18.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector19.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector20.properties";
    }
  }
  if ((longitude) > sectorRange6 && (longitude) < sectorRange7) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector21.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector22.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector23.properties";
    }
  }
  if ((longitude) > sectorRange7 && (longitude) < sectorRange8) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector24.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector25.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector26.properties";
    }
  }
  if ((longitude) > sectorRange8 && (longitude) < sectorRange9) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector27.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector28.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector29.properties";
    }
  }
  if ((longitude) > sectorRange9) {
    if ((latitude) <= sectorHorRange0 ||
        ((latitude) > sectorHorRange0 &&
            (sectorHorRange0 - (latitude)) < 1.5)) {
      fileName = "BusSector30.properties";
    } else if ((latitude) <= sectorHorRange1 ||
        ((latitude) > sectorHorRange1 &&
            (sectorHorRange1 - (latitude)) < 1.5)) {
      fileName = "BusSector31.properties";
    } else if ((latitude) <= sectorHorRange2 ||
        ((latitude) > sectorHorRange2 &&
            (sectorHorRange2 - (latitude)) < 1.5)) {
      fileName = "BusSector32.properties";
    }
  }

  List<Map> busList = [];
  print(fileName);
  var jsonText = await rootBundle.loadString('assets/' + fileName);
  List<dynamic> buses = jsonDecode(jsonText.replaceFirst("content=", ""));
  buses.forEach((bus) {
    Map<String, dynamic> busMap = bus;
    var distance =
        calculateDistance(latitude, longitude, busMap["la"], busMap["lo"]);
    busMap.putIfAbsent("di", () => distance);

    if (distance <= 1) {
      busList.add(jsonDecode(JsonEncoder().convert(busMap)));
    }
    busList.sort((a, b) {
      return a["di"].compareTo(b["di"]);
    });
  });
  log(busList.toString());
  return busList;
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
