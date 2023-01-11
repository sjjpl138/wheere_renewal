import 'package:flutter/cupertino.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/login_service.dart';
import 'package:wheere/model/service/logout_service.dart';

class Member extends ChangeNotifier {
  Member._privateConstructor();

  static final Member _instance = Member._privateConstructor();

  factory Member() {
    return _instance;
  }

  late final LoginService _loginService = LoginService();
  late final LogoutService _logoutService = LogoutService();

  MemberDTO? get member => _memberDTO;
  MemberDTO? _memberDTO;

  Future login(FirebaseLoginDTO firebaseLoginDTO) async {
//    _memberDTO = MemberDTO(mId: "mId", mName: "mName", mSex: "mSex", mBrithDate: "mBrithDate", mNum: "mNum");
    await _loginService
        .login(firebaseLoginDTO)
        .then((value) => _memberDTO = value);
    notifyListeners();
  }

  Future logout() async {
//    _memberDTO = null;
    await _logoutService.logout().then((value) => _memberDTO = value);
    notifyListeners();
  }
}