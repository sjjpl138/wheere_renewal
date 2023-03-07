import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view_model/type/types.dart';

class RouteInfoItem extends StatelessWidget {
  final Transportation transportation;
  final String text;

  const RouteInfoItem({
    Key? key,
    required this.transportation,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: transportation == Transportation.bus ? 2 : 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          transportation == Transportation.bus
              ? Container(
                  decoration: const BoxDecoration(
                    color: CustomColor.buttonMainColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(kPaddingSmallSize),
                    child: Icon(
                      Icons.directions_bus,
                      color: CustomColor.backGroundSubColor,
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: transportation == Transportation.bus
                    ? CustomColor.buttonMainColor
                    : CustomColor.buttonDisabledColor,
                borderRadius: BorderRadius.circular(kBorderRadiusSize),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kPaddingMiddleSize),
                child: Text(
                  text,
                  style: transportation == Transportation.bus
                      ? kTextReverseStyleMini
                      : kTextMainStyleMini,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
