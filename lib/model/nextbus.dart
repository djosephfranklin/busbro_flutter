class NextBus {
  final String originCode;
  final String destinationCode;
  final String estimatedArrival;
  final String latitude;
  final String longitude;
  final String visitNumber;
  final String load;
  final String feature;
  final String type;

  const NextBus(
      {required this.originCode,
      required this.destinationCode,
      required this.estimatedArrival,
      required this.latitude,
      required this.longitude,
      required this.visitNumber,
      required this.load,
      required this.feature,
      required this.type});
}
