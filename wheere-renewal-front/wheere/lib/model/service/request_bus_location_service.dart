import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class RequestBusLocationService {
  final RequestBusLocationRepository _requestBusLocationRepository = RequestBusLocationRepository();

  Future<BusLocationDTO?> requestLocation(RequestBusLocationDTO requestDTO, int bId) async {
    BusLocationDTO? busLocationDTO =
    await _requestBusLocationRepository.requestLocation(requestDTO, bId);
    return busLocationDTO;
  }
}