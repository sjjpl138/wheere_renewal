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
          padding: const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "예약확인",
                style: kTextMainStyleLarge,
              ),
              const SizedBox(height: kPaddingLargeSize),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _checkViewModel.reservationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    ReservationDTO reservation =
                        _checkViewModel.reservationList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: kPaddingMiddleSize,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: CustomColor.backGroundSubColor,
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusSize),
                            border: Border.all(
                                width: 2.0, color: CustomColor.itemSubColor)),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => _checkViewModel
                                  .navigateToBusCurrentInfoPage(reservation),
                              child: ReservationInfo(
                                bNo: reservation.bNo,
                                rTime: reservation.rTime,
                                sStationName: reservation.sStationName,
                                sStationTime: reservation.sTime,
                                eStationName: reservation.eStationName,
                                eStationTime: reservation.eTime,
                              ),
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
