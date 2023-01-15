import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/check_view_model.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckView extends StatefulWidget {
  final CheckViewModel checkViewModel;

  const CheckView({Key? key, required this.checkViewModel}) : super(key: key);

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  late final CheckViewModel _checkViewModel = widget.checkViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColor.backgroundMainColor,
        child: Padding(
          padding: const EdgeInsets.all(kPaddingLargeSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "예약확인",
                style: kTextMainStyleLarge,
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _checkViewModel.reservations.length,
                  itemBuilder: (BuildContext context, int index) {
                    ReservationDTO reservationDTO =
                        _checkViewModel.reservations[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kPaddingMiddleSize,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: CustomColor.backGroundSubColor,
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusSize),
                            border: Border.all(
                                width: 2.0, color: CustomColor.itemSubColor)),
                        child: Column(
                          children: const [
                            ReservationInfo(
                              bNo: 'bNo',
                              rTime: 'rTime',
                              sStationName: 'sStationName',
                              sStationTime: 'sStationTime',
                              eStationName: 'eStationName',
                              eStationTime: 'eStationTime',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
