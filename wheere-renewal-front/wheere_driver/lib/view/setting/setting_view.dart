import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';
import 'package:wheere_driver/view_model/setting_view_model.dart';
import 'package:wheere_driver/view_model/type/types.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "버스 정보",
                style: kTextMainStyleLarge,
              ),
              BusInfo(
                bNo: Driver().driver?.bNo ?? "bNo",
                vNo: Driver().driver?.vNo ?? "vNo",
                bOutNo: 1,
              ),
              const SizedBox(height: kPaddingLargeSize),
              CustomOutlinedButton(
                onPressed: _settingViewModel.logout,
                text: "로그아웃",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
