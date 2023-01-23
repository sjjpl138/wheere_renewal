import 'package:flutter/material.dart';
import 'package:wheere_driver/view/common/commons.dart';
import 'type/types.dart';

class MainViewModel extends ChangeNotifier {
  late List<BusStationInfo> busStationInfoList;

  MainViewModel() {
//    _makeBusStationInfo();
    busStationInfoList = [
      BusStationInfo(
        stationName: "stationName",
      ),
      BusStationInfo(
        stationName: "stationName",
      ),
      BusStationInfo(
        stationName: "stationName",
      ),
      BusStationInfo(
        stationName: "stationName",
      ),
    ];
  }

  void _makeBusStationInfo() {
    busStationInfoList = Driver()
            .driver
            ?.route
            .map((e) => BusStationInfo(
                  stationName: e.sName,
                ))
            .toList() ??
        [
          BusStationInfo(
            stationName: "stationName",
          ),
          BusStationInfo(
            stationName: "stationName",
          ),
          BusStationInfo(
            stationName: "stationName",
          ),
          BusStationInfo(
            stationName: "stationName",
          ),
        ];
  }

  Future logout() async {
    await Driver().logout();
  }
}
