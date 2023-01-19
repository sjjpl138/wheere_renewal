import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckViewModel extends ChangeNotifier {
  List<ReservationDTO> reservations = [
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rDate: 'rDate',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime', vNo: 'vNo', rState: 'rState',
    ),
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rDate: 'rDate',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime', vNo: 'vNo', rState: 'rState',
    ),
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rDate: 'rDate',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime', vNo: 'vNo', rState: 'rState',
    ),
    ReservationDTO(
      rId: 1,
      routeId: 'routeId',
      bNo: 'bNo',
      rDate: 'rDate',
      sStationId: 1,
      sStationName: 'sStationName',
      sTime: 'sTime',
      eStationId: 1,
      eStationName: 'eStationName',
      eTime: 'eTime', vNo: 'vNo', rState: 'rState',
    ),
  ];

  void navigateToBusCurrentInfoPage(ReservationDTO reservation) {}
}
