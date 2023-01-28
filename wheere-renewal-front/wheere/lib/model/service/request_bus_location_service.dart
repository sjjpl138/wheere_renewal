import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class RequestBusLocationService {
  final RequestBusLocationRepository _requestBusLocationRepository =
      RequestBusLocationRepository();

  Future<BusLocationDTO?> requestLocation(
    String routeId,
    String bId,
    String vNo,
  ) async {
    RequestBusLocationDTO requestDTO = RequestBusLocationDTO(routeId: routeId);
    BusLocationDTO? busLocationDTO = await _requestBusLocationRepository
        .requestLocation(requestDTO, bId, vNo);
    return busLocationDTO;
  }
}
