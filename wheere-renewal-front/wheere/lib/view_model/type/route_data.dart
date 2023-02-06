import 'bus_data.dart';

class RouteData {
  int payment;
  String sWalkingTime;
  List<BusData> buses;

  RouteData({
    required this.payment,
    required this.buses,
    required this.sWalkingTime,
  });
}