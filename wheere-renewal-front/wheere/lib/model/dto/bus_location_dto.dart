import 'station_list_dto.dart';

class BusLocationDTO{
  String stationName; //정류소명
  StationListDTO? stations;

  BusLocationDTO({
    required this.stationName,
    this.stations
  });
}