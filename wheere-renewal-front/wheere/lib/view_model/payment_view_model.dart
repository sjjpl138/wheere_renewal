import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/common/commons.dart';

import 'type/types.dart';

class PaymentViewModel extends ChangeNotifier {
  final RouteDTO routeDTO;
  final String rDate;

  MemberDTO? get member => _member.member;
  final Member _member = Member();

  Payment payment = Payment.kakaoPay;

  PaymentViewModel({required this.routeDTO, required this.rDate});

  List<ReservationInfo> get reservationInfoList {
    List<ReservationInfo> reservationInfoList = [];
    for (BusDTO element in routeDTO.buses) {
      reservationInfoList.add(
        ReservationInfo(
          bNo: element.bNo,
          rDate: rDate,
          sStationName: element.sStationName,
          sStationTime: element.sTime,
          eStationName: element.eStationName,
          eStationTime: element.eTime,
        ),
      );
    }
    return reservationInfoList;
  }

  void changePayment(dynamic payment) {
    this.payment = payment ?? this.payment;
    notifyListeners();
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context, false);
  }

  Future payForReservations() async {}

  Future makeReservation(BuildContext context) async {
//    _makeReservationService.makeReservation(RequestReservationDTO(mId: member!.mId, bId: bId, sStationId: sStationId, eStationId: eStationId, rDate: rDate))
    Navigator.pop(context, true);
  }
}
