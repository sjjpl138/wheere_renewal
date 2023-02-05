import 'package:flutter/material.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/select_tab_view_model.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view_model/type/bus_data.dart';
import 'package:wheere/view_model/type/route_data.dart';

class SelectTabView extends StatefulWidget {
  final SelectTabViewModel selectTabViewModel;

  const SelectTabView({Key? key, required this.selectTabViewModel})
      : super(key: key);

  @override
  State<SelectTabView> createState() => _SelectTabViewState();
}

class _SelectTabViewState extends State<SelectTabView> {
  late final SelectTabViewModel _selectTabViewModel = widget.selectTabViewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _selectTabViewModel.routesByHours.routes.length,
      itemBuilder: (BuildContext context, int index) {
        RouteData route = _selectTabViewModel.routesByHours.routes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: kPaddingMiddleSize),
          child: Container(
            decoration: BoxDecoration(
              color: CustomColor.backGroundSubColor,
              borderRadius: BorderRadius.circular(kBorderRadiusSize),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: kPaddingMiddleSize),
                    Flexible(
                      child: RouteInfo(
                        route: route,
                      ),
                    ),
                    const SizedBox(width: kPaddingMiddleSize),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: kPaddingMiddleSize),
                        itemCount: route.buses.length,
                        itemBuilder: (BuildContext context, int index) {
                          BusData busData = route.buses[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: kPaddingMiddleSize,
                            ),
                            child: CustomListItem(
                              bNo: busData.bNo,
                              sStation:
                                  "${busData.sTime}\n${busData.sStationName}",
                              eStation:
                                  "${busData.eTime}\n${busData.eStationName}",
                              leftSeats: "${busData.leftSeats} 개",
                            ),
                          );
                        },
                      ),
                    ),
                    CustomOutlinedMiniButton(
                      onPressed: () =>
                          _selectTabViewModel.navigateToPaymentPage(
                        context,
                        route,
                      ),
                      text: "예약",
                    ),
                    const SizedBox(width: kPaddingMiddleSize),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
