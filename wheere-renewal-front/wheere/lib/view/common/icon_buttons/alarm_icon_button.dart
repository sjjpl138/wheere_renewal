import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

class AlarmIconButton extends StatelessWidget {
  final bool isNewAlarm;

  final void Function() onPressed;

  const AlarmIconButton({Key? key, required this.isNewAlarm, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Stack(
        alignment: Alignment.topRight,
        children: [
          const Icon(
            Icons.notifications,
            size: kIconMainSize,
            color: CustomColor.itemSubColor,
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
      ),
    );
  }
}
