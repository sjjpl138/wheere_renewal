import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/setting_view_model.dart';

class SettingView extends StatefulWidget {
  final SettingViewModel settingViewModel;

  const SettingView({Key? key, required this.settingViewModel})
      : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late final SettingViewModel _settingViewModel = widget.settingViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: "설정",
        leading: BackIconButton(
          onPressed: () => _settingViewModel.navigatePop(context),
        ),
      ),
      body: Container(
        color: CustomColor.backgroundMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
              child: Text(
                "고객센터",
                style: kTextMainStyleLarge,
              ),
            ),
            ServiceInfo(
              serviceInfoDataList: _settingViewModel.serviceInfoDataList,
            ),
            const SizedBox(height: kPaddingLargeSize),
            OutlinedButton(
              onPressed: _settingViewModel.logout,
              child: const Text(
                "로그아웃",
                style: kTextReverseStyleMiddle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
