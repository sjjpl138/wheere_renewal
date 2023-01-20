import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class UpdateDriverDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/drivers";
  Future<DriverDTO?> writeWithRemote(UpdateDriverDTO updateDriverDTO) async {
    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.put(path, updateDriverDTO.toJson());
      return res != null ? DriverDTO.fromJson(res) : null; //200 ok
    } catch (e) {
      return null;
    }
  }
}
