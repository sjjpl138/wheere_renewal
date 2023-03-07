import 'request_reservation_bus_dto.dart';

class RequestReservationDTO {
  String mId;
  int startStationId;
  int endStationId;
  List<RequestReservationBusDTO> buses;
  String rState;
  int rPrice;
  String rDate;

  RequestReservationDTO({
    required this.mId,
    required this.startStationId,
    required this.endStationId,
    required this.buses,
    required this.rState,
    required this.rPrice,
    required this.rDate
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<Map<String, dynamic>> busesJson = this.buses.map((i) => i.toJson()).toList();
    data['mId'] = mId;
    data['startStationId'] = busesJson.first['sStationId'];
    data['endStationId'] = busesJson.last['eStationId'];
    data['buses'] = busesJson;
    data['rState'] = rState;
    data['rPrice'] = rPrice;
    data['rDate'] = rDate;
    return data;
  }
}