import 'request_reservation_bus_dto.dart';

class RequestReservationDTO {
  String mId;
  int bId;
  List<RequestReservationBusDTO> buses;
  String rState;
  String rPrice;
  String rDate;

  RequestReservationDTO({
    required this.mId,
    required this.bId,
    required this.buses,
    required this.rState,
    required this.rPrice,
    required this.rDate
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<Map<String, dynamic>> buses = this.buses.map((i) => i.toJson()).toList();
    data['mId'] = mId;
    data['buses'] = buses;
    data['rState'] = rState;
    data['rPrice'] = rPrice;
    data['rDate'] = rDate;
    return data;
  }
}