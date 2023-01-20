import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/check_reservation_service.dart';
import 'package:wheere/model/service/delete_reservation_service.dart';
import 'package:wheere/model/service/make_reservation_service.dart';
import 'package:wheere/view_model/type/member.dart';

class ReservationList extends ChangeNotifier {
  ReservationList._privateConstructor();

  static final ReservationList _instance =
      ReservationList._privateConstructor();

  factory ReservationList() {
    return _instance;
  }

  final MakeReservationService _makeReservationService =
      MakeReservationService();
  final CheckReservationService _checkReservationService =
      CheckReservationService();
  final DeleteReservationService _deleteReservationService =
      DeleteReservationService();

  List<ReservationDTO> get reservationList =>
      _reservationListDTO?.reservationsList ?? [];
  ReservationListDTO? _reservationListDTO;

  int currentPage = 0;

  Future makeReservation(RequestReservationDTO requestReservationDTO) async {
    await _makeReservationService
        .makeReservation(requestReservationDTO)
        .then((value) async {
      if (value != null) {
        _reservationListDTO?.reservationsList?.add(value);
        currentPage = 0;
        await checkReservation("latest", "PAID");
        notifyListeners();
      }
    });
  }

  Future deleteReservation(int rId) async {
    await _deleteReservationService.deleteReservation(rId);
    notifyListeners();
  }

  Future checkReservation(String order, String rState) async {
    print("checkReservation");
    await Future.delayed(const Duration(seconds: 1));
    // TODO : test code 삭제
    ReservationListDTO value = ReservationListDTO([
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
        eTime: 'eTime',
        vNo: 'vNo',
        rState: 'rState',
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
        eTime: 'eTime',
        vNo: 'vNo',
        rState: 'rState',
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
        eTime: 'eTime',
        vNo: 'vNo',
        rState: 'rState',
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
        eTime: 'eTime',
        vNo: 'vNo',
        rState: 'rState',
      ),
    ]);
    if (currentPage == 0) {
      _reservationListDTO = value;
      currentPage++;
    } else {
      if (value.reservationsList != null) {
        _reservationListDTO!.reservationsList!.addAll(value.reservationsList!);
      }
    }
    // TODO : null check 다시 작성
    /*await _checkReservationService
        .checkReservation(
      RequestReservationCheckDTO(
        mId: Member().member.mId,
        order: order,
        rState: rState,
        size: 5,
        page: currentPage++,
      ),
    )
        .then((value) {
      if (value != null) {
        if (currentPage == 0) {
          _reservationListDTO = value;
        } else {
          if (value.reservationsList != null) {
            _reservationListDTO!.reservationsList!
                .addAll(value.reservationsList!);
          }
        }
      }
    });*/
    notifyListeners();
  }
}
