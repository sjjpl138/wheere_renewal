import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class RequestRouteRepository {
  final RequestRouteDataSource _requestRouteDataSource = RequestRouteDataSource();

  Future<RouteFullListDTO?> requestRoute(RequestRouteDTO requestRouteDTO) async {
    return await _requestRouteDataSource.writeWithRemote(requestRouteDTO);
  }
}