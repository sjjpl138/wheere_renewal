import 'package:wheere_driver/model/dto/dtos.dart';

class DriverDTO {
  String dName;
  int bId;
  String vNo;
  String routeId;
  String bNo;
  List<StationDTO> route;
  List<ReservationDTO> reservations;

  DriverDTO({
    required this.dName,
    required this.bId,
    required this.vNo,
    required this.routeId,
    required this.bNo,
    required this.route,
    required this.reservations
  });

  factory DriverDTO.fromJson(Map<String, dynamic> json) {

    var getRouteList = json['route'] as List;
    List<StationDTO> routes = getRouteList.map((i) => StationDTO.fromJson(i)).toList();

    var getReservationList = json['reservations'] as List;
    List<ReservationDTO> reservations = getReservationList.map((i) => ReservationDTO.fromJson(i)).toList();
    return DriverDTO(
      dName: json["dName"],
      bId: json["bId"],
      vNo: json["vNo"],
      routeId: json["routeId"],
      bNo: json["bNo"],
      route: routes,
      reservations: reservations,
    );
  }
}