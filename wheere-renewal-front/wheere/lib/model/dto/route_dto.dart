import 'sub_route_dto.dart';

class RouteDTO {
  int payment;
  int busTransitCount;
  String firstStartStation;
  String lastEndStation;
  List<SubRouteDTO> subRoutes;

  RouteDTO({
    required this.payment,
    required this.busTransitCount,
    required this.firstStartStation,
    required this.lastEndStation,
    required this.subRoutes,
  });

  factory RouteDTO.fromJson(Map<String, dynamic> json) {
    var list = json['subRoutes'] as List;
    List<SubRouteDTO> subRoutes = list.map((i) => SubRouteDTO.fromJson(i)).toList();
    return RouteDTO(
      payment: json['payment'],
      busTransitCount: json['busTransitCount'],
      firstStartStation: json['firstStartStation'],
      lastEndStation: json['lastEndStation'],
      subRoutes: subRoutes
    );
  }
}