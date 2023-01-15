import 'package:flutter/material.dart';
import 'package:wheere/model/dto/bus_dto.dart';
import 'package:wheere/view/common/commons.dart';
import 'type/types.dart';

class BusCurrentInfoViewModel extends ChangeNotifier {
  final BusDTO reservation;

  BusCurrentInfoViewModel({required this.reservation});

  ReservationInfo get reservationInfo => ReservationInfo(
        bNo: reservation.bNo,
        rTime: "rTime",
        sStationName: reservation.sStationName,
        sStationTime: reservation.sTime,
        eStationName: reservation.eStationName,
        eStationTime: reservation.eTime,
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
}
