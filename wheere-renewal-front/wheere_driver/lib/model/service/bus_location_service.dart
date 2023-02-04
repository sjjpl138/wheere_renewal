import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/model/repository/request_bus_location_repository.dart';

class BusLocationService {
  final RequestBusLocationRepository _requestBusLocationRepository = RequestBusLocationRepository();

  Future<BusLocationDTO?> requestRoute(RequestBusLocationDTO requestBusLocationDTO, String bId, String vNo) async {
    return await _requestBusLocationRepository.requestLocation(requestBusLocationDTO, bId, vNo);
  }
}