import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class LogoutRepository {
  final LogoutDataSource _logoutDataSource = LogoutDataSource();

  Future<MemberDTO?> logout() async {
    return await _logoutDataSource.logout();
  }
}