import 'bus_dto.dart';

class RouteDTO {
  String sWalkingTime;
  List<BusDTO> buses;

  RouteDTO({
    required this.buses,
    required this.sWalkingTime,
  });
}