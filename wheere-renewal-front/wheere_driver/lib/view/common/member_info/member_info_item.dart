import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';

class MemberInfoItem extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String contents;

  const MemberInfoItem({
    Key? key,
    required this.prefixIcon,
    required this.title,
    required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            kPaddingSmallSize,
            kPaddingSmallSize,
            kPaddingSmallSize,
            0.0,
          ),
          child: Icon(
            prefixIcon,
            color: CustomColor.itemSubColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            kPaddingSmallSize,
            kPaddingSmallSize,
            kPaddingSmallSize,
            0.0,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              title,
              style: kTextMainStyleMiddle,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              kPaddingSmallSize,
              kPaddingSmallSize,
              kPaddingSmallSize,
              0.0,
            ),
            child: Text(
              contents,
              style: kTextMainStyleMiddle,
            ),
          ),
        ),
      ],
    );
  }
}
