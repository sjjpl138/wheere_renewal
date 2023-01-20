import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class LoginDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/drivers";
  Future<DriverDTO?> readWithRemote(LoginDTO loginDTO) async {
    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.post(path, loginDTO.toJson());
      return res != null ? DriverDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}
