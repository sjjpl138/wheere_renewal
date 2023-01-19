import 'package:flutter/material.dart';

import '../../styles/styles.dart';
import 'commons.dart';

class SexRadioField extends StatelessWidget {
  final String groupValue;

  final void Function(String) onChanged;

  const SexRadioField({
    Key? key,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  kPaddingMiddleSize,
                  kPaddingMiddleSize,
                  kPaddingMiddleSize,
                  0.0,
                ),
                child: Icon(
                  Icons.face,
                  size: kIconMiddleSize,
                  color: CustomColor.itemSubColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: kPaddingMiddleSize),
                child: Text(
                  "성별",
                  style: kTextMainStyleSmall,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kPaddingSmallSize),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CustomRadioListTitle(
                    value: "남성",
                    groupValue: groupValue,
                    title: "남성",
                    onChanged: (dynamic value) => onChanged(value),
                    contentsPadding: kPaddingMiddleSize,
                  ),
                ),
                const SizedBox(width: kPaddingMiddleSize),
                Flexible(
                  child: CustomRadioListTitle(
                    value: "여성",
                    groupValue: groupValue,
                    title: "여성",
                    onChanged: (dynamic value) => onChanged(value),
                    contentsPadding: kPaddingMiddleSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
