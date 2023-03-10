import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/util/utils.dart';

class SignUpViewModel extends ChangeNotifier {
  final SignUpService _signUpService = SignUpService();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;

  late String sex;
  late String birthDate;

  final signUpKey = GlobalKey<FormState>();

  SignUpViewModel() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    sex = "남성";
    birthDate = birthDateFormat.format(DateTime.now());
  }

  Future signUp(BuildContext context, bool mounted) async {
    if (signUpKey.currentState!.validate()) {
      await _signUpService.signUpWithRemote(
        FirebaseSignUpDTO(
          email: emailController.text,
          password: passwordController.text,
          mName: nameController.text,
          mSex: sex,
          mBirthDate: dateNoTimeFormat.format(birthDateFormat.parse(birthDate)),
          mNum: phoneNumberController.text,
        ),
      );
      if (mounted) Navigator.pop(context);
    }
  }

  void onSexChanged(String value) {
    sex = value;
    notifyListeners();
  }

  void onBirthDateChanged(DateTime value) {
    birthDate = birthDateFormat.format(value);
    notifyListeners();
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
