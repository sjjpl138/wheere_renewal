import 'package:flutter/material.dart';

import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/services.dart';
import 'type/types.dart';

class HomeViewModel extends ChangeNotifier {
  late final LoginService _loginService;
  late final LogoutService _logoutService;

  MemberDTO? get member => _member.member;
  late Member _member;

  HomeViewModel() {
    _loginService = LoginService();
    _logoutService = LogoutService();
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

  Future logout() async {
    await _logoutService.logout().then((value) => _member = Member(value));
    notifyListeners();
  }
}
