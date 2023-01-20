import 'bus_dto.dart';

class RouteDTO {
  int payment;
  String sWalkingTime;
  int price;
  List<BusDTO> buses;

  RouteDTO({
    required this.payment,
    required this.buses,
    required this.price,
    required this.sWalkingTime,
  });

  factory RouteDTO.fromJson(Map<String, dynamic> json) {
    var list = json['buses'] as List;
    List<BusDTO> buses = list.map((i) => BusDTO.fromJson(i)).toList();
    return RouteDTO(
      payment: json['payment'],
      sWalkingTime: json['sWalkingTime'],
      buses: buses,
      price: json['price'],
    );
  }
}