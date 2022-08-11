class BusModel {
  final String busStopCode;
  final List<dynamic> services;

  const BusModel({
    required this.busStopCode,
    required this.services,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      busStopCode: json['BusStopCode'],
      services: json['Services'],
    );
  }
}
