import 'package:flutter/material.dart';
import 'package:wheere/view/select/select_tab_page.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view_model/type/types.dart';

class SelectViewModel extends ChangeNotifier {
  final RouteFullList routeFullList;
  final String rDate;

  final Map<Widget, Widget> tabs = {};

  SelectViewModel({
    required this.routeFullList,
    required this.rDate,
  }) {
    initTabs();
  }

  void initTabs() {
    for (RoutesByHours element in routeFullList.routeByHoursList) {
      tabs[Tab(text: element.selectTime)] = SelectTabPage(
        routesByHoursDTO: element,
        rDate: rDate,
      );
    }
    notifyListeners();
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
