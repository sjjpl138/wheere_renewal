import 'package:flutter/material.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/select_tab_view_model.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/model/dto/dtos.dart';

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
      itemCount: _selectTabViewModel.routes.length,
      itemBuilder: (BuildContext context, int index) {
        RouteDTO routeDTO = _selectTabViewModel.routes[index];
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
                        route: routeDTO,
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
                        itemCount: routeDTO.buses.length,
                        itemBuilder: (BuildContext context, int index) {
                          BusDTO busDTo = routeDTO.buses[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: kPaddingMiddleSize,
                            ),
                            child: CustomListItem(
                              bNo: busDTo.bNo,
                              sStation: "${busDTo.sTime}\n${busDTo.sStationName}",
                              eStation: "${busDTo.eTime}\n${busDTo.eStationName}",
                              leftSeats: "${busDTo.leftSeats} 개",
                            ),
                          );
                        },
                      ),
                    ),
                    const CustomOutlinedMiniButton(
                      onPressed: null,
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
