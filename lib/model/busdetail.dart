class BusDetail {
  final String busStopCode;
  final String roadName;
  final String roadDescription;
  final double latitude;
  final double longitude;
  final double distance;

  const BusDetail(
      {required this.busStopCode,
      required this.roadName,
      required this.roadDescription,
      required this.latitude,
      required this.longitude,
      required this.distance});

  factory BusDetail.fromJson(Map<String, dynamic> json) {
    return BusDetail(
        distance: json['di'] == null ? 0.0 : json['di'],
        busStopCode: json['b'],
        roadName: json['r'],
        roadDescription: json['d'],
        latitude: json['la'],
        longitude: json['lo']);
  }
}
