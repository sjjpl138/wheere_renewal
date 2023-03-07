import 'package:flutter/material.dart';
import 'package:wheere_driver/view_model/type/types.dart';

class SettingViewModel extends ChangeNotifier {
  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }

  Future logout() async {
    await Driver().logout();
  }
}
