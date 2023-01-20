import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'type/types.dart';


class LoginViewModel extends ChangeNotifier {
  late Member _member;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  final loginKey = GlobalKey<FormState>();

  LoginViewModel() {
    _member = Member();
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    _loginByAuto();
  }

  Future _loginByAuto() async {
    await _member.loginByAuto();
  }

  Future login() async {
    if (loginKey.currentState!.validate()) {
      await _member.login(
        FirebaseLoginDTO(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  void navigateToSignUpPage() {}
}
