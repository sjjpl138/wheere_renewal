import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/alarm_view_model.dart';

class AlarmView extends StatefulWidget {
  final AlarmViewModel alarmViewModel;

  const AlarmView({Key? key, required this.alarmViewModel}) : super(key: key);

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  late final _alarmViewModel = widget.alarmViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context,
          title: "알림",
          leading: BackIconButton(onPressed: _alarmViewModel.navigatePop)),
      body: Container(
        color: CustomColor.backgroundMainColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
                child: Text(
                  "오늘",
                  style: kTextMainStyleLarge,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: kPaddingMiddleSize),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _alarmViewModel.todayAlarms.length,
                itemBuilder: (BuildContext context, int index) =>
                    _alarmViewModel.todayAlarms[index],
              ),
              const SizedBox(height: kPaddingLargeSize),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
                child: Text(
                  "이번주",
                  style: kTextMainStyleLarge,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: kPaddingMiddleSize),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _alarmViewModel.thisWeekAlarms.length,
                itemBuilder: (BuildContext context, int index) =>
                _alarmViewModel.thisWeekAlarms[index],
              ),
              const SizedBox(height: kPaddingLargeSize),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
                child: Text(
                  "오래전",
                  style: kTextMainStyleLarge,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: kPaddingMiddleSize),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _alarmViewModel.lastAlarms.length,
                itemBuilder: (BuildContext context, int index) =>
                _alarmViewModel.lastAlarms[index],
              ),
              const SizedBox(height: kPaddingLargeSize),
            ],
          ),
        ),
      ),
    );
  }
}
