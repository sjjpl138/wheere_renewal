import 'package:wheere_driver/model/repository/repositories.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class LoginService {
  final LoginRepository _loginRepository = LoginRepository();

  Future<DriverDTO?> loginWithRemote(FirebaseLoginDTO firebaseLoginDTO) async {
    DriverDTO? memberDTO =
        await _loginRepository.readMemberWithRemote(firebaseLoginDTO);
    return memberDTO;
  }
}
