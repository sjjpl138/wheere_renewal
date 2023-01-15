import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'type/types.dart';

class LoginViewModel extends ChangeNotifier {
  late Member _member;

  LoginViewModel() {
    _member = Member();
  }

  Future login(String email, String password) async {
    await _member.login(FirebaseLoginDTO(email: email, password: password));
  }
}
