import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/route_info/route_info_item.dart';
import 'package:wheere/view_model/type/transportation.dart';

class RouteInfo extends StatelessWidget {
  final RouteDTO route;
  final List<Widget> _itemList = [];

  RouteInfo({super.key, required this.route}) {
    _itemList.add(
      Container(
        decoration: const BoxDecoration(
          color: CustomColor.itemDisabledColor,
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(kPaddingSmallSize),
          child: Icon(
            Icons.directions_walk,
            color: CustomColor.itemSubColor,
          ),
        ),
      ),
    );
    _itemList.add(
      RouteInfoItem(
        transportation: Transportation.walk,
        text: route.sWalkingTime,
      ),
    );
    for(BusDTO element in route.buses) {
      _itemList.add(
        RouteInfoItem(
          transportation: Transportation.bus,
          text: element.bNo,
        ),
      );
      _itemList.add(
        RouteInfoItem(
            transportation: Transportation.walk,
            text: element.eWalkingTime,
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingMiddleSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _itemList,
      ),
    );
  }
}
