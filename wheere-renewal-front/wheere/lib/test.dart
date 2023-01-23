import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wheere/model/dto/bus_dto.dart';
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
/*    return BusCurrentInfoPage(
      reservation: ReservationDTO(
        rId: 1,
        routeId: 'routeId',
        bNo: "bNo",
        rTime: 'rTime',
        sStationId: 1,
        sStationName: "sStationName",
        sTime: "sTime",
        eStationId: 1,
        eStationName: "eStationName",
        eTime: "eTime",
      ),
    );*/
//    return const MainPage();
/*    return PaymentPage(reservations: [
      BusDTO(
        bId: 1,
        bNo: "bNo",
        sStationId: 1,
        sStationName: "sStationName",
        sTime: "sTime",
        eStationId: 1,
        eStationName: "eStationName",
        eTime: "eTime",
        eWalkingTime: "eWalkingTime",
        leftSeats: 2,
      ),
      BusDTO(
        bId: 1,
        bNo: "bNo",
        sStationId: 1,
        sStationName: "sStationName",
        sTime: "sTime",
        eStationId: 1,
        eStationName: "eStationName",
        eTime: "eTime",
        eWalkingTime: "eWalkingTime",
        leftSeats: 2,
      ),
    ]);*/
//    return const SelectTabPage();
//    return const SelectPage();
//    return const MainPage();
    return const HomePage();
//    return SearchView(searchViewModel: SearchViewModel());
//    return LoginView(loginViewModel: LoginViewModel());
  }
}
