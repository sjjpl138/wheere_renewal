import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/drivers";

  Future _firebaseLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } catch (e) {
      return null;
    }
  }

  Future deleteWithRemote() async {
    await _firebaseLogout();
    return null;
  }
}
