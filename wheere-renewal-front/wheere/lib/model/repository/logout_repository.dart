import 'local_data_sources/local_data_sources.dart';
import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class LogoutRepository {
  final RemoteLogoutDataSource _logoutRemoteDataSource =
      RemoteLogoutDataSource();
  final LocalLogoutDataSource _localLogoutDataSource = LocalLogoutDataSource();

  Future<MemberDTO?> deleteMemberWithRemote(String mId) async {
    return await _logoutRemoteDataSource.deleteWithRemote(mId);
  }

  Future deleteMemberWithLocal() async {
    await _localLogoutDataSource.deleteWithLocal();
  }
}
