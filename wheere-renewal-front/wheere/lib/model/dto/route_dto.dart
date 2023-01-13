import 'bus_dto.dart';

class RouteDTO {
  List<BusDTO> buses;
  String eWalkingTime;

  RouteDTO({
    required this.buses,
    required this.eWalkingTime,
  });
}