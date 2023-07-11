import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/bus_current_info_view_model.dart';

class BusCurrentInfoView extends StatefulWidget {
  final BusCurrentInfoViewModel busCurrentInfoViewModel;

  const BusCurrentInfoView({Key? key, required this.busCurrentInfoViewModel})
      : super(key: key);

  @override
  State<BusCurrentInfoView> createState() => _BusCurrentInfoViewState();
}

class _BusCurrentInfoViewState extends State<BusCurrentInfoView> {
  late final _busCurrentInfoViewModel = widget.busCurrentInfoViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: "예약정보",
        leading: BackIconButton(
          onPressed: () => _busCurrentInfoViewModel.navigatePop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.backgroundMainColor,
          child: Column(
            children: [
              _busCurrentInfoViewModel.reservationInfo,
              const SizedBox(height: kPaddingLargeSize),
              BusCurrentInfo(
                  busStationInfoList:
                      _busCurrentInfoViewModel.busStationInfoList),
              const SizedBox(height: kPaddingLargeSize),
            ],
          ),
        ),
      ),
    );
  }
}
