import 'base_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/drivers/logout";

  Future _firebaseLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } catch (e) {
      return null;
    }
  }

  Future deleteWithRemote(String dId) async {
    await _firebaseLogout();
    Map<String, dynamic> body = {"dId": dId};
    await BaseRemoteDataSource.post(path, body);
    return null;
  }
}
