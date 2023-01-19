import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class LoginService {
  final LoginRepository _loginRepository = LoginRepository();

  Future<MemberDTO?> loginWithRemote(FirebaseLoginDTO firebaseLoginDTO) async {
    MemberDTO? memberDTO =
        await _loginRepository.readMemberWithRemote(firebaseLoginDTO);
    if (memberDTO != null) _loginRepository.saveMemberWithLocal(memberDTO);
    return memberDTO;
  }

  Future<MemberDTO?> loginWithLocal() async {
    return await _loginRepository.readMemberWithLocal();
  }
}
