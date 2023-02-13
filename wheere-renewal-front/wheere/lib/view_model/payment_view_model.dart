import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/make_reservation_service.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view/common/reservation_info/reservation_info_list_item.dart';

import 'type/types.dart';

class PaymentViewModel extends ChangeNotifier {
  final MakeReservationService _makeReservationService =
      MakeReservationService();

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

  Future makeReservation(BuildContext context, bool mounted) async {
    await _makeReservationService.makeReservation(RequestReservationDTO(
      mId: member!.mId,
      rDate: rDate,
      startStationId: routeData.buses[0].sStationId,
      endStationId: routeData.buses[0].eStationId,
      buses: routeData.buses
          .map((e) => RequestReservationBusDTO(
              bId: e.bId, sStationId: e.sStationId, eStationId: e.eStationId))
          .toList(), rState: 'PAID', rPrice: routeData.payment,
    ));
    if(mounted) Navigator.pop(context, true);
  }
}
