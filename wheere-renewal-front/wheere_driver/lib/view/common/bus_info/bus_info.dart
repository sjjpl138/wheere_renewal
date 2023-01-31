import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'bus_info_item.dart';

class BusInfo extends StatelessWidget {
  final String bNo;
  final String vNo;
  final int bOutNo;

  const BusInfo({
    Key? key,
    required this.bNo,
    required this.vNo,
    required this.bOutNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kPaddingLargeSize,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.backGroundSubColor,
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        child: Column(
          children: [
            BusInfoItem(
              prefixIcon: Icons.directions_bus,
              title: "버스 번호",
              contents: bNo,
              subContents: null,
            ),
            BusInfoItem(
              prefixIcon: Icons.directions_car,
              title: "차량번호",
              contents: vNo,
              subContents: null,
            ),
            BusInfoItem(
              prefixIcon: Icons.location_on_outlined,
              title: "배차 순번",
              contents: "$bOutNo번",
              subContents: null,
            ),
            const SizedBox(height: kPaddingMiddleSize),
          ],
        ),
      ),
    );
  }
}
