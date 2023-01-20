import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/login_repository.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/util/utils.dart';

class Member extends ChangeNotifier {
  Member._privateConstructor();

  static final Member _instance = Member._privateConstructor();

  factory Member() {
    return _instance;
  }

  final LoginService _loginService = LoginService();
  final LogoutService _logoutService = LogoutService();
  final UpdateMemberService _updateMemberService = UpdateMemberService();

  MemberDTO get member =>
      _memberDTO ??
      MemberDTO(
          mId: "mId",
          mName: "mName",
          mSex: "남성",
          mBirthDate: birthDateFormat.format(DateTime.now()),
          mNum: "01000000000",
          fcmToken: "");
  MemberDTO? _memberDTO;

  Future login(FirebaseLoginDTO firebaseLoginDTO) async {
    // TODO : test code 삭제
    var fcmToken = await FirebaseMessaging.instance
        .getToken(vapidKey: dotenv.env['FIREBASE_WEB_PUSH']);
    print("token : ${fcmToken ?? 'token NULL!'}");
    if (fcmToken != null) {
      _memberDTO = MemberDTO(
          mId: "mId",
          mName: "mName",
          mSex: "남성",
          mBirthDate: birthDateFormat.format(DateTime.now()),
          mNum: "01000000000",
          fcmToken: fcmToken);
      await LoginRepository().saveMemberWithLocal(_memberDTO!);
    }
/*    await _loginService
        .login(firebaseLoginDTO)
        .then((value) => _memberDTO = value);*/
    notifyListeners();
  }

  Future logout() async {
    await _logoutService.logout().then((value) => _memberDTO = value);
    notifyListeners();
  }

  Future loginByAuto() async {
    await _loginService.loginWithLocal().then((value) => _memberDTO = value);
    notifyListeners();
  }

  Future updateInfo(MemberInfoDTO updateMemberDTO) async {
    await _updateMemberService.updateMember(updateMemberDTO);
    _memberDTO = MemberDTO(
      mId: updateMemberDTO.mId,
      mName: updateMemberDTO.mName,
      mSex: updateMemberDTO.mSex,
      mBirthDate: updateMemberDTO.mBirthDate,
      mNum: updateMemberDTO.mNum,
      fcmToken: member.fcmToken,
    );
    notifyListeners();
  }
}
