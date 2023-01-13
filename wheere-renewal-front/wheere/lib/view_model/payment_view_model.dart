import 'package:flutter/material.dart';
import 'package:wheere/model/dto/bus_dto.dart';
import 'package:wheere/view/common/commons.dart';

import 'type/types.dart';

class PaymentViewModel extends ChangeNotifier {
  final List<BusDTO> reservations;

  Payment payment = Payment.kakaoPay;

  PaymentViewModel({required this.reservations});

  List<ReservationInfo> get reservationInfoList {
    List<ReservationInfo> reservationInfoList = [];
    for (BusDTO element in reservations) {
      reservationInfoList.add(
        ReservationInfo(
          bNo: element.bNo,
          rTime: "rTime",
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
}
