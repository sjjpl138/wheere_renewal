import 'package:wheere_driver/model/repository/repositories.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class LogoutService {
  final LogoutRepository _loginRepository = LogoutRepository();

  Future<DriverDTO?> logoutWithRemote() async {
    DriverDTO? driverDTO =
    await _loginRepository.deleteMemberWithRemote();
    return driverDTO;
  }
}
