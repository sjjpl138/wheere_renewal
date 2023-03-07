import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/view_model/type/types.dart';

class LoginViewModel extends ChangeNotifier {
  final Driver _driver = Driver();

  final loginKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController vehicleNoController = TextEditingController();
  final TextEditingController busNoController = TextEditingController();
  final TextEditingController outNoController = TextEditingController();

  Future login() async {
    if (loginKey.currentState!.validate()) {
      await _driver.login(
        FirebaseLoginDTO(
          email: emailController.text,
          password: passwordController.text,
          vNo: vehicleNoController.text,
          bOutNo: int.parse(outNoController.text),
          bNo: busNoController.text,
        ),
      ).then((value) => print(_driver.driver == null));
    }
  }
}
