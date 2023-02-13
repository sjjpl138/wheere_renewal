import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wheere/model/dto/bus_route_dto.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/styles/colors.dart';
import 'package:wheere/view/check/check_page.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view/common/custom_app_bar.dart';
import 'package:wheere/view/common/custom_outlined_button.dart';
import 'package:wheere/view/common/custom_radio/custom_radio_list_tile.dart';
import 'package:wheere/view/common/custom_text_button.dart';
import 'package:wheere/view/common/custom_text_form_field.dart';
import 'package:wheere/view/home/home_page.dart';
import 'package:wheere/view/login/login_page.dart';
import 'package:wheere/view/login/login_view.dart';
import 'package:wheere/view/main/main_page.dart';
import 'package:wheere/view/payment/payment_page.dart';
import 'package:wheere/view/rating/rating_page.dart';
import 'package:wheere/view/search/search_page.dart';
import 'package:wheere/view/search/search_view.dart';
import 'package:wheere/view/select/select_page.dart';
import 'package:wheere/view/select/select_tab_page.dart';
import 'package:wheere/view_model/login_view_model.dart';
import 'package:wheere/view_model/search_view_model.dart';
import 'package:wheere/view_model/type/types.dart';

import '../view/bus_current_info/bus_current_info_page.dart';

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
    return RatingPage(
        reservation: AlarmReservationDTO(
      rId: 0,
      rDate: "rDate",
      bNo: "bNo",
      sStationName: "sStationName",
      eStationName: "eStationName",
      sTime: "sTime",
      eTime: "eTime",
      bId: 0,
    ));
    /*return BusCurrentInfoPage(
      reservation: const ReservationData(
        bNo: "bNo",
        bId: "bId",
        vNo: "vNo",
        rDate: "rDate",
        routeId: "routeId",
        sStationName: "sStationName",
        sStationTime: "sStationTime",
        eStationName: "eStationName",
        eStationTime: "eStationTime",
      ),
      busLocationDTO: BusLocationDTO(
        stationName: "current",
        stations: StationListDTO(stations: [
          StationDTO(sId: "sId", sName: "sName"),
          StationDTO(sId: "sId", sName: "sName"),
          StationDTO(sId: "sId", sName: "current"),
          StationDTO(sId: "sId", sName: "sName"),
          StationDTO(sId: "sId", sName: "sStationName"),
        ]),
      ),
    );*/
//    return const SelectTabPage();
//    return const SelectPage();
//    return const MainPage();
//    return const HomePage();
//    return SearchView(searchViewModel: SearchViewModel());
//    return LoginView(loginViewModel: LoginViewModel());
  }
}
