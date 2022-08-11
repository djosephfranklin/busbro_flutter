import 'nextbus.dart';
import 'nextbus2.dart';
import 'nextbus3.dart';

class Services {
  final String busNo;
  final NextBus nextBus;
  final NextBus2 nextBus2;
  final NextBus3 nextBus3;

  const Services(
      {required this.busNo,
      required this.nextBus,
      required this.nextBus2,
      required this.nextBus3});
}
