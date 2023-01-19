import 'package:flutter/material.dart';
import 'package:wheere/view/select/select_tab_page.dart';
import 'package:wheere/model/dto/dtos.dart';

class SelectViewModel extends ChangeNotifier {
  final RouteFullListDTO routeFullListDTO;

  final Map<Widget, Widget> tabs = {};

  SelectViewModel({required this.routeFullListDTO}) {
    initTabs();
  }

  void initTabs() {
    for (RoutesByHoursDTO element in routeFullListDTO.routeFullList) {
      tabs[Tab(text: element.selectTime)] = SelectTabPage(
        routes: element.routes,
      );
    }
    notifyListeners();
  }

  void navigatePop() {}
}
