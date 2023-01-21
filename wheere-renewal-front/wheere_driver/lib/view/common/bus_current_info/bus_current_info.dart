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
                          kPaddingMiddleSize * 2) *
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
                  busStation: busStationInfoList[index].busStation,
                  busCurrentLocation:
                      busStationInfoList[index].busCurrentLocation,
                  stationName: busStationInfoList[index].stationName,
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
  final BusStation busStation;
  final BusCurrentLocation busCurrentLocation;
  final String stationName;

  BusStationInfo({
    required this.busStation,
    required this.busCurrentLocation,
    required this.stationName,
  });
}
