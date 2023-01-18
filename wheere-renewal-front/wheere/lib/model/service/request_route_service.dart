import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class RequestRouteService {
  final RequestRouteRepository _requestRouteRepository = RequestRouteRepository();

  Future<RouteFullListDTO?> requestRoute(RequestRouteDTO requestRouteDTO) async {
    RouteFullListDTO? routeFullListDTO =
    await _requestRouteRepository.requestRoute(requestRouteDTO);
    return routeFullListDTO;
  }
}