import 'base_remote_data_source.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class BusGetOffDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs/{rId}/get-off-bus";

  Future writeWithRemote(BusGetOffDTO getOffDTO) async {
    try {
      path = "/api/resvs/${getOffDTO.rId}/get-off-bus";
      Map<String, dynamic>? res = await BaseRemoteDataSource.post(path, getOffDTO.toJson());
      return res == null ? 200 : "error";
    } catch (e) {
      return null;
    }
  }
}