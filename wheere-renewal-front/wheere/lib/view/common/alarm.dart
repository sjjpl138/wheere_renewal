import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class Alarm extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final String contents;
  final String aTime;
  final bool isNewAlarm;

  const Alarm({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    required this.contents,
    required this.aTime,
    required this.isNewAlarm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColor.backGroundSubColor,
            borderRadius: BorderRadius.circular(kBorderRadiusSize),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      kPaddingMiddleSize,
                      kPaddingMiddleSize,
                      kPaddingMiddleSize,
                      0.0,
                    ),
                    child: Icon(
                      prefixIcon,
                      size: kIconMiddleSize,
                      color: CustomColor.itemSubColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: kPaddingMiddleSize),
                    child: Text(
                      labelText,
                      style: kTextMainStyleSmall,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      kPaddingMiddleSize,
                      kPaddingMiddleSize,
                      kPaddingMiddleSize,
                      0.0,
                    ),
                    child: Text(
                      aTime,
                      textAlign: TextAlign.end,
                      style: kTextMainStyleSmall,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingMiddleSize),
                      child: Icon(
                        prefixIcon,
                        size: kIconMiddleSize,
                        color: CustomColor.itemSubColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: kPaddingMiddleSize),
                    child: Text(
                      contents,
                      style: kTextMainStyleSmall,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: kIconMainSize * 0.1,
          right: kIconMainSize * 0.1,
          child: Container(
            width: kIconMainSize * 0.3,
            height: kIconMainSize * 0.3,
            decoration: BoxDecoration(
              color: isNewAlarm ? CustomColor.pointColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }
}
