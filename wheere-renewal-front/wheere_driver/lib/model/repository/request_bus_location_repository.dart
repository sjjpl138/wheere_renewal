import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class RequestBusLocationRepository {
  final RequestBusLocationDataSource _requestBusLocationDataSource = RequestBusLocationDataSource();

  Future<BusLocationDTO?> requestRoute(RequestBusLocationDTO requestDTO) async {
    return await _requestBusLocationDataSource.readWithRemote(requestDTO);
  }
}