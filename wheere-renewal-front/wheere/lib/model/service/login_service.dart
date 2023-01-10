import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class LoginService{
  final LoginRepository _loginRepository = LoginRepository();

  Future<MemberDTO?> login(FirebaseLoginDTO firebaseLoginDTO) async {
    return await _loginRepository.login(firebaseLoginDTO);
  }
}