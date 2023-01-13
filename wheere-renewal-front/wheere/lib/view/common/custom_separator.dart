import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class CustomSeparator extends StatelessWidget {
  final String text;

  const CustomSeparator({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingMiddleSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(
              indent: kPaddingLargeSize,
              endIndent: kPaddingMiddleSize,
              thickness: 1,
              color: CustomColor.buttonSubColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: CustomColor.buttonSubColor,
              borderRadius: BorderRadius.circular(kBorderRadiusSize),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kPaddingSmallSize,
                  horizontal: kPaddingMiddleSize,
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: kTextReverseStyleSmall,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              indent: kPaddingMiddleSize,
              endIndent: kPaddingLargeSize,
              thickness: 1,
              color: CustomColor.buttonSubColor,
            ),
          ),
        ],
      ),
    );
  }
}
