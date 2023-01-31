import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';

class BusCurrentInfoItem extends StatelessWidget {
  final BusStationInfo busStationInfo;
  final void Function(BusStationInfo busStationInfo) onTap;

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
    required this.onTap,
  }) {
    _stationNameTextStyle =
        busStationInfo.ridePeople.isNotEmpty || busStationInfo.quitPeople.isNotEmpty
            ? kTextPointStyleMiddle
            : kTextMainStyleMiddle;
    _ridePeopleTextStyle = busStationInfo.ridePeople.isNotEmpty
        ? kTextPointStyleSmall
        : kTextMainStyleSmall;
    _quitPeopleTextStyle = busStationInfo.quitPeople.isNotEmpty
        ? kTextPointStyleSmall
        : kTextMainStyleSmall;
    _headSize = busStationInfo.isCurrentStation
        ? kIconMainSize + kPaddingSmallSize
        : kIconSmallSize;
    _headPadding = busStationInfo.isCurrentStation
        ? (kPaddingLargeSize - kPaddingSmallSize) / 2
        : (kIconMainSize + kPaddingLargeSize - kIconSmallSize) / 2;
    _headChild = busStationInfo.isCurrentStation
        ? const Icon(
            Icons.directions_bus,
            color: CustomColor.backGroundSubColor,
            size: kIconSmallSize,
          )
        : Container();
    _headBackgroundColor = busStationInfo.isCurrentStation
        ? CustomColor.pointColor
        : CustomColor.backGroundSubColor;
    _headBoarderColor =
        busStationInfo.ridePeople.isNotEmpty || busStationInfo.quitPeople.isNotEmpty
            ? CustomColor.pointColor
            : CustomColor.itemSubColor;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(busStationInfo),
      child: Padding(
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
                        "탑승 인원: ${busStationInfo.ridePeople.length}",
                        style: _ridePeopleTextStyle,
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      Text(
                        "하차 인원: ${busStationInfo.quitPeople.length}",
                        style: _quitPeopleTextStyle,
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      Text(
                        "남은 좌석: ${busStationInfo.leftSeats}",
                        style: kTextMainStyleSmall,
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
