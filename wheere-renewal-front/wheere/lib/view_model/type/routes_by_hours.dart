import 'route_data.dart';

class RoutesByHours {
  String selectTime;
  List<RouteData> routes;

  RoutesByHours({
    required this.selectTime,
    required this.routes,
  });

  factory RoutesByHours.fromJson(Map<String, dynamic> json) {
    var list = json['routes'] as List;
    List<RouteData> getList = list.map((i) => RouteData.fromJson(i)).toList();
    return RoutesByHours(
      selectTime: json['selectTime'],
      routes: getList,
    );
  }
}
