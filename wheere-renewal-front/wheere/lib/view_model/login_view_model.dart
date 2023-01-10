import 'package:flutter/cupertino.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/model/type/types.dart';

class LoginViewModel with ChangeNotifier {
  late final LoginService _loginService;

  MemberDTO? get member => _member.member;
  late Member _member;

  LoginViewModel() {
    _loginService = LoginService();
    _member = Member(null);
  }

  Future login(String email, String password) async {
    FirebaseLoginDTO firebaseLoginDTO =
        FirebaseLoginDTO(email: email, password: password);
    await _loginService
        .login(firebaseLoginDTO)
        .then((value) => _member = Member(value));
    notifyListeners();
  }
}
