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

  factory RouteData.fromJson(Map<String, dynamic> json) {
    var list = json['buses'] as List;
    List<BusData> buses = list.map((i) => BusData.fromJson(i)).toList();
    return RouteData(
      payment: json['payment'],
      sWalkingTime: json['sWalkingTime'],
      buses: buses,
    );
  }
}