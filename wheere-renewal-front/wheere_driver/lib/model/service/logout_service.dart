import 'package:wheere_driver/model/repository/repositories.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class LogoutService {
  final LogoutRepository _loginRepository = LogoutRepository();

  Future<DriverDTO?> logoutWithRemote(String dId) async {
    return await _loginRepository.deleteMemberWithRemote(dId);
  }
}
