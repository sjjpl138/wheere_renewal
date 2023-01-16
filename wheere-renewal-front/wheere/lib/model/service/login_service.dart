import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class LoginService{
  final LoginRepository _loginRepository = LoginRepository();

  Future<MemberDTO?> login(FirebaseLoginDTO firebaseLoginDTO) async {
    var fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: dotenv.env['FIREBASE_WEB_PUSH']);
    print("token : ${fcmToken ?? 'token NULL!'}");
    return await _loginRepository.login(firebaseLoginDTO);
  }
}