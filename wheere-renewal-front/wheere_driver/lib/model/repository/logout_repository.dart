import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class LogoutRepository {
  final LogoutDataSource _logoutDataSource = LogoutDataSource();

  Future<DriverDTO?> deleteMemberWithRemote(String dId) async {
    return await _logoutDataSource.deleteWithRemote(dId);
  }
}