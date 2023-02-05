import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view/common/reservation_info/reservation_info_list_item.dart';

import 'type/types.dart';

class PaymentViewModel extends ChangeNotifier {
  final RouteData routeData;
  final String rDate;

  MemberDTO? get member => _member.member;
  final Member _member = Member();

  Payment payment = Payment.kakaoPay;

  PaymentViewModel({required this.routeData, required this.rDate});

  List<ReservationInfoListItem> get reservationInfoList => routeData.buses
      .map((e) => ReservationInfoListItem(
            bNo: e.bNo,
            rDate: rDate,
            sStationName: e.sStationName,
            sStationTime: e.sTime,
            eStationName: e.eStationName,
            eStationTime: e.eTime,
          ))
      .toList();

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
