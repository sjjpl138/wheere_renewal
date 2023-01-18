import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;

  late final String sex;
  late final String birthDate;

  final signUpKey = GlobalKey<FormState>();

  SignUpViewModel() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    sex = "남성";
    birthDate = "생년월일";
  }

  Future signUp() async {}

  void navigatePop() {}
}
