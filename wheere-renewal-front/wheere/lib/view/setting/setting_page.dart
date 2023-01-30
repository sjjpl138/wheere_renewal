import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/setting/setting_view.dart';
import 'package:wheere/view_model/setting_view_model.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingViewModel>(
      create: (_) => SettingViewModel(),
      child: Consumer<SettingViewModel>(
        builder: (context, provider, child) => SettingView(
          settingViewModel: provider,
        ),
      ),
    );
  }
}
