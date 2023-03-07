import 'package:firebase_messaging/firebase_messaging.dart';
import  'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class LogoutService{
  final LogoutRepository _logoutRepository = LogoutRepository();

  Future<MemberDTO?> logout(String mId) async {
    FirebaseMessaging.instance.deleteToken();
    await _logoutRepository.deleteMemberWithLocal();
    return await _logoutRepository.deleteMemberWithRemote(mId);
  }
}