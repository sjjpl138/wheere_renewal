import 'reservation_buses_dto.dart';

class ReservationDTO {
  int rId;
  String rDate;
  String rState;
  List<BusesDTO> buses;

  ReservationDTO({
    required this.rId,
    required this.rDate,
    required this.rState,
    required this.buses
  });

  factory ReservationDTO.fromJson(Map<String, dynamic> json) {
    var list = json['buses'] as List;
    List<BusesDTO> buses = list.map((i) => BusesDTO.fromJson(i)).toList();
    return ReservationDTO(
      rId: json['rId'],
      rDate: json['rDate'],
      rState: json['rState'],
      buses: buses
    );
  }
}
