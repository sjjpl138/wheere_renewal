import 'package:flutter/material.dart';
import 'package:wheere/view_model/type/types.dart';

class SettingViewModel extends ChangeNotifier {
  List<ServiceInfoData> serviceInfoDataList = [
    ServiceInfoData(
      prefixIcon: Icons.call,
      title: "서비스센터",
      contents: "010-0000-000",
    ),
  ];

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }

  Future logout(BuildContext context, bool mounted) async {
    await Member().logout();
    if(mounted) {
      Navigator.pop(context);
    }
  }
}
