import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class RequestBusLocationService {
  final RequestBusLocationRepository _requestBusLocationRepository =
      RequestBusLocationRepository();

  Future<BusLocationDTO?> requestLocation(
    String routeId,
    int bId,
    String vNo,
    String sStationName,
  ) async {
    RequestBusLocationDTO requestDTO = RequestBusLocationDTO(routeId: routeId);
    BusLocationDTO? busLocationDTO = await _requestBusLocationRepository
        .requestLocation(requestDTO, bId, vNo, sStationName);
    return busLocationDTO;
  }
}
