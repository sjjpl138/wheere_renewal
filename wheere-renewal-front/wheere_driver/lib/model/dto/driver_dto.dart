import 'package:wheere_driver/model/dto/dtos.dart';

class DriverDTO {
  String dId = "";
  String dName;
  int bId;
  String fcmToken;
  String vNo;
  String routeId;
  String bNo;
  int totalSeats;
  List<StationDTO> route;
  List<ReservationDTO> reservations;

  DriverDTO({
    required this.dName,
    required this.bId,
    required this.fcmToken,
    required this.vNo,
    required this.routeId,
    required this.bNo,
    required this.totalSeats,
    required this.route,
    required this.reservations});

  factory DriverDTO.fromJson(Map<String, dynamic> json) {
    var getRouteList = json['route'] as List;
    print(getRouteList.length);
    List<StationDTO> routes =
        getRouteList.map((i) => StationDTO.fromJson(i)).toList();

    var getReservationList = json['reservations'] as List;
//    print(getReservationList.first);
    List<ReservationDTO> reservations =
        getReservationList.map((i) => ReservationDTO.fromJson(i)).toList();
    print(json['bId']);
    return DriverDTO(
      dName: json["dName"],
      bId: json["bId"],
      fcmToken: json['fcmToken'],
      vNo: json["vNo"],
      routeId: json["routeId"],
      bNo: json["bNo"],
      totalSeats: json['totalSeats'],
      route: routes,
      reservations: reservations,
    );
  }
}
