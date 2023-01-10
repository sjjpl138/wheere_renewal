import 'package:firebase_auth/firebase_auth.dart';
import 'package:wheere/model/repository/remote_data_sources/base_data_source.dart';

class LogoutDataSource implements BaseDataSource {
  @override
  String path = "";

  Future _firebaseLogin() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } catch (e) {
      return null;
    }
  }

  Future logout() async {
    await _firebaseLogin();
    return null;
  }
}