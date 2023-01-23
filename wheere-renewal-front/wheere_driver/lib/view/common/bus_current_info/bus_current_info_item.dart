import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';
import 'package:wheere_driver/view_model/type/bus_current_station.dart';

class BusCurrentInfoItem extends StatelessWidget {
  final BusStationInfo busStationInfo;

  late final TextStyle _stationNameTextStyle;
  late final TextStyle _ridePeopleTextStyle;
  late final TextStyle _quitPeopleTextStyle;
  late final double _headSize;
  late final double _headPadding;
  late final Color _headBoarderColor;
  late final Color _headBackgroundColor;
  late final Widget _headChild;

  BusCurrentInfoItem({
    super.key,
    required this.busStationInfo,
  }) {
    _stationNameTextStyle = busStationInfo.isCurrentStation
        ? kTextPointStyleMiddle
        : kTextMainStyleMiddle;
    // TODO : 각종 style 정의 필요
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  busStationInfo.stationName,
                  style: _stationNameTextStyle,
                  textAlign: TextAlign.start,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "탑승 인원: ",
                      style: kTextMainStyleSmall,
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                    Text(
                      "하차 인원: ",
                      style: kTextMainStyleSmall,
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                    Text(
                      "남은 좌석: ",
                      style: kTextMainStyleSmall,
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
