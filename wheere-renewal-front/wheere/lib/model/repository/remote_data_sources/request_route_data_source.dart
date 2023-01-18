import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class RequestRouteDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members/request-routes";
  Future<RouteFullListDTO?> writeWithRemote(RequestRouteDTO requestRouteDTO) async {
    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.post(path, requestRouteDTO.toJson());
      return res != null ? RouteFullListDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}
