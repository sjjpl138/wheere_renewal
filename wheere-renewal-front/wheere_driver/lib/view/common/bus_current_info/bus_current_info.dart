import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view_model/type/bus_current_station.dart';
import 'bus_current_info_item.dart';

class BusCurrentInfo extends StatelessWidget {
  final List<BusStationInfo> busStationInfoList;

  const BusCurrentInfo({Key? key, required this.busStationInfoList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Padding(
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
                  height: (kIconSmallSize +
                          kPaddingSmallSize +
                          kPaddingMiddleSize * 2 +
                          kTextSmallSize) *
                      busStationInfoList.length,
                  color: CustomColor.itemSubColor,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: kPaddingMiddleSize),
                itemCount: busStationInfoList.length,
                itemBuilder: (BuildContext context, int index) =>
                    BusCurrentInfoItem(
                      busStationInfo: busStationInfoList[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BusStationInfo {
  final String stationName;
  bool isCurrentStation;
  int ridePeople;
  int quitPeople;
  int leftSeats;

  BusStationInfo({
    required this.stationName,
    this.isCurrentStation = false,
    this.ridePeople = 0,
    this.quitPeople = 0,
    this.leftSeats = 2,
  });
}
