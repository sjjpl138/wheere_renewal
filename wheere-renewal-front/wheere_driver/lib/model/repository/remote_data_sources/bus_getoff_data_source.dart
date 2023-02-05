import 'base_remote_data_source.dart';

class BusGetOffDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs/{rId}/get-off-bus";

  Future writeWithRemote(String bId) async {
    try {
      path = "/api/resvs/{$bId}/get-off-bus";
      Map<String, dynamic>? res = await BaseRemoteDataSource.get(path);
      return res == null ? 200 : "error";
    } catch (e) {
      return null;
    }
  }
}