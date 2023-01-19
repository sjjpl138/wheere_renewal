import 'package:flutter/material.dart';
import 'package:wheere/view/select/select_tab_page.dart';
import 'package:wheere/model/dto/dtos.dart';

class SelectViewModel extends ChangeNotifier {
  final Map<Widget, Widget> tabs = {};

  SelectViewModel() {
    initTabs();
  }

  Future initTabs() async {
    tabs.clear();
    // TODO : 서버로 부터 값 받아오기

    List<RouteDTO> routes = [
      RouteDTO(
        sWalkingTime: 'sWalkingTime',
        buses: [
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            eWalkingTime: 'eWalkingTime',
            leftSeats: 2,
          ),
        ],
      ),
      RouteDTO(
        sWalkingTime: 'sWalkingTime',
        buses: [
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            eWalkingTime: 'eWalkingTime',
            leftSeats: 2,
          ),
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            eWalkingTime: 'eWalkingTime',
            leftSeats: 2,
          ),
        ],
      ),
    ];

    RouteFullListDTO routeFullListDTO = RouteFullListDTO(routeFullList: [
      RoutesByHoursDTO(selectTime: "15시", routes: routes),
      RoutesByHoursDTO(selectTime: "16시", routes: routes),
      RoutesByHoursDTO(selectTime: "17시", routes: routes),
      RoutesByHoursDTO(selectTime: "18시", routes: routes),
      RoutesByHoursDTO(selectTime: "19시", routes: routes),
      RoutesByHoursDTO(selectTime: "20시", routes: routes),
      RoutesByHoursDTO(selectTime: "21시", routes: routes),
      RoutesByHoursDTO(selectTime: "22시", routes: routes),
      RoutesByHoursDTO(selectTime: "23시", routes: routes),
    ]);

    for (RoutesByHoursDTO element in routeFullListDTO.routeFullList) {
      tabs[Tab(text: element.selectTime)] = SelectTabPage(
        routes: element.routes,
      );
    }
    notifyListeners();
  }

  void navigatePop() {}
}
