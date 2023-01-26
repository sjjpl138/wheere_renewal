import 'package:flutter/material.dart';
import 'package:wheere/view/common/commons.dart';
import 'type/types.dart';

class BusCurrentInfoViewModel extends ChangeNotifier {
  final ReservationData reservation;

  BusCurrentInfoViewModel({required this.reservation});

  ReservationInfoListItem get reservationInfo => ReservationInfoListItem(
        bNo: reservation.bNo,
        rDate: reservation.rDate,
        sStationName: reservation.sStationName,
        sStationTime: reservation.sStationTime,
        eStationName: reservation.eStationName,
        eStationTime: reservation.eStationTime,
      );

  List<BusStationInfo> busStationInfoList = [
    BusStationInfo(
      busStation: BusStation.base,
      busCurrentLocation: BusCurrentLocation.base,
      stationName: "stationName",
    ),
    BusStationInfo(
      busStation: BusStation.base,
      busCurrentLocation: BusCurrentLocation.current,
      stationName: "stationName",
    ),
    BusStationInfo(
      busStation: BusStation.ride,
      busCurrentLocation: BusCurrentLocation.base,
      stationName: "stationName",
    ),
    BusStationInfo(
      busStation: BusStation.ride,
      busCurrentLocation: BusCurrentLocation.current,
      stationName: "stationName",
    ),
  ];

  void navigatePop() {}
}
