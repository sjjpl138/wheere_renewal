import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckViewModel extends ChangeNotifier {
  List<ReservationDTO> reservations = [
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rTime: 'rTime',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime',
    ),
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rTime: 'rTime',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime',
    ),
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rTime: 'rTime',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime',
    ),
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rTime: 'rTime',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime',
    ),
  ];

  void navigateToBusCurrentInfoPage(ReservationDTO reservation) {}
}
