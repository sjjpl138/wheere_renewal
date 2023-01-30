import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class ServiceInfoItem extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String contents;

  const ServiceInfoItem({
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
            kPaddingMiddleSize,
            kPaddingMiddleSize,
            kPaddingMiddleSize,
            0.0,
          ),
          child: Icon(
            prefixIcon,
            color: CustomColor.itemSubColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            kPaddingMiddleSize,
            kPaddingMiddleSize,
            kPaddingMiddleSize,
            0.0,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              title,
              style: kTextMainStyleMiddle,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              kPaddingMiddleSize,
              kPaddingMiddleSize,
              kPaddingMiddleSize,
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
