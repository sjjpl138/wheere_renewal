import 'package:firebase_messaging/firebase_messaging.dart';
import  'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class LogoutService{
  final LogoutRepository _logoutRepository = LogoutRepository();

  Future<MemberDTO?> logout() async {
    FirebaseMessaging.instance.deleteToken();
    return await _logoutRepository.logout();
  }
}