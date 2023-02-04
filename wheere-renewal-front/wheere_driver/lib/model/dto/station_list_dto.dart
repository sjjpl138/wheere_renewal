import 'station_dto.dart';

class StationListDTO{
  List<StationDTO> stations;

  StationListDTO({
    required this.stations
  });

  factory StationListDTO.fromJson(Map<String, dynamic> json) {
    var list = json['stations'] as List;
    List<StationDTO> stationList = list.map((i) => StationDTO.fromJson(i)).toList();
    return StationListDTO(
        stations: stationList
    );
  }
}