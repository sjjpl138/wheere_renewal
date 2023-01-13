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
        buses: [
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sWalkingTime: 'sWalkingTime',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            leftSeats: 2,
          ),
        ],
        eWalkingTime: 'eWalkingTime',
      ),
      RouteDTO(
        buses: [
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sWalkingTime: 'sWalkingTime',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            leftSeats: 2,
          ),
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sWalkingTime: 'sWalkingTime',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            leftSeats: 2,
          ),
        ],
        eWalkingTime: 'eWalkingTime',
      ),
      RouteDTO(
        buses: [
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sWalkingTime: 'sWalkingTime',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            leftSeats: 2,
          ),
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sWalkingTime: 'sWalkingTime',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            leftSeats: 2,
          ),
        ],
        eWalkingTime: 'eWalkingTime',
      ),
    ];

    SearchDTO searchDTO = SearchDTO(selects: [
      SelectDTO(selectTIme: "15시", routes: routes),
      SelectDTO(selectTIme: "16시", routes: routes),
      SelectDTO(selectTIme: "17시", routes: routes),
      SelectDTO(selectTIme: "18시", routes: routes),
      SelectDTO(selectTIme: "19시", routes: routes),
      SelectDTO(selectTIme: "20시", routes: routes),
      SelectDTO(selectTIme: "21시", routes: routes),
      SelectDTO(selectTIme: "22시", routes: routes),
      SelectDTO(selectTIme: "23시", routes: routes),
    ]);

    for (SelectDTO element in searchDTO.selects) {
      tabs[Tab(text: element.selectTIme)] = SelectTabPage(
        routes: element.routes,
      );
    }
    notifyListeners();
  }
}
