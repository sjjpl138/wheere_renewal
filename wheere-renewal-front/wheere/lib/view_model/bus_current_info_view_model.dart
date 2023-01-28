import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/common/commons.dart';
import 'type/types.dart';

class BusCurrentInfoViewModel extends ChangeNotifier {
  final BusLocationDTO busLocationDTO;
  final ReservationData reservation;
  late List<BusStationInfo> busStationInfoList;

  BusCurrentInfoViewModel({
    required this.busLocationDTO,
    required this.reservation,
  }) {
    makeBusStationInfoList();
  }

  ReservationInfoListItem get reservationInfo => ReservationInfoListItem(
        bNo: reservation.bNo,
        rDate: reservation.rDate,
        sStationName: reservation.sStationName,
        sStationTime: reservation.sStationTime,
        eStationName: reservation.eStationName,
        eStationTime: reservation.eStationTime,
      );

  void makeBusStationInfoList() {
    busStationInfoList = busLocationDTO.stations.stations
        .map((e) => BusStationInfo(
              busStation: e.sName == reservation.sStationName
                  ? BusStation.ride
                  : BusStation.base,
              busCurrentLocation: e.sName == busLocationDTO.stationName
                  ? BusCurrentLocation.current
                  : BusCurrentLocation.base,
              stationName: e.sName,
            ))
        .toList();
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
