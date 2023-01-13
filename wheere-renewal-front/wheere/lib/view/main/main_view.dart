import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/main_view_model.dart';

class MainView extends StatefulWidget {
  final MainViewModel mainViewModel;

  const MainView({Key? key, required this.mainViewModel}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  late final MainViewModel _mainViewModel = widget.mainViewModel;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: _mainViewModel.tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: 'WHEERE',
        leading: AlarmIconButton(isNewAlarm: _mainViewModel.isNewAlarm),
        actions: [
          const SettingIconButton(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _mainViewModel.tabs.values.toList(),
            ),
          ),
          Container(
            color: CustomColor.itemMainColor,
            child: TabBar(
              controller: _tabController,
              tabs: _mainViewModel.tabs.keys.toList(),
              indicatorColor: Colors.transparent,
              labelColor: CustomColor.textReverseColor,
              unselectedLabelColor: CustomColor.textReverseDisabledColor,
              labelStyle: kTextMainStyleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
