import 'local_data_sources/local_data_sources.dart';
import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class LoginRepository {
  final RemoteLoginDataSource _remoteLoginDataSource = RemoteLoginDataSource();
  final LocalLoginDataSource _localLoginDataSource = LocalLoginDataSource();


  Future<MemberDTO?> readMemberWithRemote(FirebaseLoginDTO firebaseLoginDTO) async {
    return await _remoteLoginDataSource.readWithRemote(firebaseLoginDTO);
  }

  Future<MemberDTO?> readMemberWithLocal() async {
    return await _localLoginDataSource.readWithLocal();
  }

  Future saveMemberWithLocal(MemberDTO memberDTO) async {
    await _localLoginDataSource.writeWithLocal(memberDTO);
  }
}