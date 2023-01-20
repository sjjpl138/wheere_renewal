import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wheere/view/home/home_page.dart';
import 'package:wheere/view_model/type/types.dart';

import 'model/dto/dtos.dart';


class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Payment? groupValue = Payment.onSite;
  bool isNewAlarm = true;

  @override
  Widget build(BuildContext context) {
    /*print(json.encode(AlarmDTO(
      alarmType: "rating",
      aTime: "2022-12-31 11:00",
      reservation: ReservationDTO(
        rId: 3,
        routeId: "routeId",
        bNo: "bNo",
        rDate: "2022-12-31",
        sStationId: 3,
        sStationName: "sStationName",
        sTime: "sTime",
        eStationId: 1,
        eStationName: "eStationName",
        eTime: "eTime",
        rState: "rState",
        vNo: "vNo",
      ),
    ).toJson()));*/
    return const HomePage();
  }
}
