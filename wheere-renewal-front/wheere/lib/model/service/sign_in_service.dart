import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class SignUpService {
  final SignUpRepository _loginRepository = SignUpRepository();

  Future signUpWithRemote(FirebaseSignUpDTO firebaseSignUpDTO) async {
    await _loginRepository.writeMemberWithRemote(firebaseSignUpDTO);
  }
}
