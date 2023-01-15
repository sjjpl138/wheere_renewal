import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view_model/type/bus_current_station.dart';

class BusCurrentInfoItem extends StatelessWidget {
  final BusStation busStation;
  final BusCurrentLocation busCurrentLocation;
  final String stationName;

  late final TextStyle _textStyle;
  late final double _headSize;
  late final double _headPadding;
  late final Color _headBoarderColor;
  late final Color _headBackgroundColor;
  late final Widget _headChild;

  BusCurrentInfoItem({
    super.key,
    required this.busStation,
    required this.busCurrentLocation,
    required this.stationName,
  }) {
    _textStyle = busCurrentLocation == BusCurrentLocation.current
        ? kTextPointStyleMiddle
        : kTextMainStyleMiddle;
    switch (busStation) {
      case BusStation.base:
        _headBoarderColor = busCurrentLocation == BusCurrentLocation.current
            ? CustomColor.pointColor
            : CustomColor.itemSubColor;
        _headBackgroundColor = busCurrentLocation == BusCurrentLocation.current
            ? CustomColor.pointColor
            : CustomColor.backGroundSubColor;
        _headSize = busCurrentLocation == BusCurrentLocation.current
            ? kIconMainSize + kPaddingSmallSize
            : kIconSmallSize;
        _headPadding = busCurrentLocation == BusCurrentLocation.current
            ? (kPaddingLargeSize - kPaddingSmallSize) / 2
            : (kIconMainSize + kPaddingLargeSize - kIconSmallSize) / 2;
        _headChild = busCurrentLocation == BusCurrentLocation.current
            ? const Icon(
                Icons.directions_bus,
                color: CustomColor.backGroundSubColor,
                size: kIconSmallSize,
              )
            : Container();
        break;
      case BusStation.ride:
        _headBoarderColor = busCurrentLocation == BusCurrentLocation.current
            ? CustomColor.pointColor
            : CustomColor.itemSubColor;
        _headBackgroundColor = busCurrentLocation == BusCurrentLocation.current
            ? CustomColor.pointColor
            : CustomColor.itemSubColor;
        _headSize = kIconMainSize + kPaddingSmallSize;
        _headPadding = (kPaddingLargeSize - kPaddingSmallSize) / 2;
        _headChild = busCurrentLocation == BusCurrentLocation.current
            ? const Icon(
                Icons.directions_bus,
                color: CustomColor.backGroundSubColor,
                size: kIconSmallSize,
              )
            : const Text(
                "승차",
                style: kTextReverseStyleMini,
                textAlign: TextAlign.center,
              );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kPaddingMiddleSize,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _headPadding,
            ),
            child: Container(
              width: _headSize,
              height: _headSize,
              decoration: BoxDecoration(
                color: _headBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _headBoarderColor,
                  width: kLineSize,
                ),
              ),
              child: Center(child: _headChild),
            ),
          ),
          const SizedBox(width: kPaddingLargeSize),
          Expanded(
            child: Text(
              stationName,
              style: _textStyle,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
