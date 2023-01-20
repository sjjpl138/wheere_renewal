import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'reservation_info_item.dart';

class ReservationInfo extends StatelessWidget {
  final String bNo;
  final String rDate;
  final String sStationName;
  final String sStationTime;
  final String eStationName;
  final String eStationTime;

  const ReservationInfo({
    Key? key,
    required this.bNo,
    required this.rDate,
    required this.sStationName,
    required this.sStationTime,
    required this.eStationName,
    required this.eStationTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kPaddingLargeSize,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.backGroundSubColor,
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        child: Column(
          children: [
            ReservationInfoItem(
              prefixIcon: Icons.directions_bus,
              title: "버스 번호",
              contents: bNo,
              subContents: null,
            ),
            ReservationInfoItem(
              prefixIcon: Icons.event_note,
              title: "날짜",
              contents: rDate,
              subContents: null,
            ),
            ReservationInfoItem(
              prefixIcon: Icons.location_on_outlined,
              title: "출발 정류장",
              contents: sStationTime,
              subContents: sStationName,
            ),
            ReservationInfoItem(
              prefixIcon: Icons.location_on,
              title: "도착 정류장",
              contents: eStationTime,
              subContents: eStationName,
            ),
            const SizedBox(height: kPaddingMiddleSize),
          ],
        ),
      ),
    );
  }
}
