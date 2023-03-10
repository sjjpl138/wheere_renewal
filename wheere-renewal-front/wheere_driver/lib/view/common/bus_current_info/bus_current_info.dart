import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'bus_current_info_item.dart';

class BusCurrentInfo extends StatelessWidget {
  final List<BusStationInfo> busStationInfoList;
  final void Function(BusStationInfo busStationInfo) onTap;

  const BusCurrentInfo({
    Key? key,
    required this.busStationInfoList,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kPaddingLargeSize,
        0.0,
        kPaddingLargeSize,
        kPaddingLargeSize,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kPaddingMiddleSize,
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: (kIconMainSize + kPaddingLargeSize - kLineSize) / 2),
              child: Container(
                width: kLineSize,
                height: (kPaddingMiddleSize * 2 +
                        kTextMiddleSize * kTextHeight * 1.1 +
                        kTextSmallSize * kTextHeight * 1.1) *
                    (busStationInfoList.length - 0.5),
                color: CustomColor.itemSubColor,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: busStationInfoList.length,
              itemBuilder: (BuildContext context, int index) =>
                  BusCurrentInfoItem(
                busStationInfo: busStationInfoList[index],
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusStationInfo {
  final String stationName;
  bool isCurrentStation = false;
  List<ReservationDTO> ridePeople = [];
  List<ReservationDTO> quitPeople = [];
  int leftSeats = 2;

  BusStationInfo({
    required this.stationName,
  });
}
