import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/colors.dart';
import 'package:wheere_driver/styles/sizes.dart';
import 'package:wheere_driver/view/common/commons.dart';
import 'package:wheere_driver/view_model/main_view_model.dart';
import 'package:wheere_driver/view_model/type/types.dart';

class MainView extends StatefulWidget {
  final MainViewModel mainViewModel;

  const MainView({Key? key, required this.mainViewModel}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final MainViewModel _mainViewModel = widget.mainViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context,
          title: Driver().driver?.bNo ?? "bNo",
          leading: LogoutIconButton(onPressed: () => _mainViewModel.logout()),
          actions: [
            RefreshIconButton(
              onPressed: _mainViewModel.initReservationInfo,
            ),
            SettingIconButton(
              onPressed: () => _mainViewModel.navigateToSettingPage(context),
            ),
          ]),
      body: Builder(builder: (context) {
        _mainViewModel.setBodyHeight(context);
        return SingleChildScrollView(
          controller: _mainViewModel.scrollController,
          child: Container(
            color: CustomColor.backgroundMainColor,
            child: Column(
              children: [
                BusCurrentInfo(
                  busStationInfoList: _mainViewModel.busStationInfoList,
                  onTap: (BusStationInfo busStationInfo) => _mainViewModel
                      .showMemberListDialog(context, busStationInfo),
                ),
                const SizedBox(height: kPaddingLargeSize),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _mainViewModel.focusListToCurrentLocation,
        backgroundColor: CustomColor.itemSubColor,
        child: const Icon(
          Icons.my_location,
          color: CustomColor.textReverseColor,
          size: kIconMainSize,
        ),
      ),
    );
  }
}
