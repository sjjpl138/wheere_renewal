import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/drivers";

  Future<LoginDTO?> _firebaseLogin(FirebaseLoginDTO loginDTO) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginDTO.email,
        password: loginDTO.password,
      );
      String? dId = FirebaseAuth.instance.currentUser?.uid;
      var fcmToken = await FirebaseMessaging.instance
          .getToken(vapidKey: dotenv.env['FIREBASE_WEB_PUSH']);
      if (fcmToken == null) throw Exception();
      return dId != null
          ? LoginDTO(
              dId: dId,
              vNo: loginDTO.vNo,
              bOutNo: loginDTO.bOutNo,
              bNo: loginDTO.bNo,
              fcmToken: fcmToken,
            )
          : null;
    } catch (e) {
      print("e1");
      print(e);
      return null;
    }
  }

  Future<DriverDTO?> readWithRemote(FirebaseLoginDTO firebaseLoginDTO) async {
    try {
      LoginDTO? loginDTO = await _firebaseLogin(firebaseLoginDTO);
      Map<String, dynamic>? res = loginDTO != null
          ? await BaseRemoteDataSource.post(path, loginDTO.toJson())
          : null;
      var driverDTO = res != null ? DriverDTO.fromJson(res) : null;
      if (res != null) driverDTO!.dId = loginDTO!.dId;
      return driverDTO;
    } catch (e) {
      print("e2");
      print(e);
      return null;
    }
  }
}
