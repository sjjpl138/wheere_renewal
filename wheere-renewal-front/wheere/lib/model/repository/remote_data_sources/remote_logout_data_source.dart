import 'package:firebase_auth/firebase_auth.dart';
import 'package:wheere/model/repository/remote_data_sources/base_remote_data_source.dart';

class RemoteLogoutDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/memners/logout";

  Future _firebaseLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } catch (e) {
      return null;
    }
  }
  
  Future deleteWithRemote(String mId) async {
    await _firebaseLogout();
    Map<String, dynamic> body = {"mId": mId};
    await BaseRemoteDataSource.post(path, body);
    return null;
  }
}