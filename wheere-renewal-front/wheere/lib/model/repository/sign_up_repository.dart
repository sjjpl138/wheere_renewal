import 'package:wheere/model/repository/remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class SignUpRepository {
  final RemoteSignUpDataSource _remoteLoginDataSource =
      RemoteSignUpDataSource();

  Future<MemberDTO?> writeMemberWithRemote(
      FirebaseSignUpDTO firebaseSignUpDTO) async {
    return await _remoteLoginDataSource.writeWithRemote(firebaseSignUpDTO);
  }
}
