import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';

class BusInfoItem extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String contents;
  final String? subContents;

  const BusInfoItem({
    Key? key,
    required this.prefixIcon,
    required this.title,
    required this.contents,
    required this.subContents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        ),
        // TODO : Visibility가 아닌 다른 방식으로 같은 공간 확보 필요
        subContents == null
            ? Container()
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingMiddleSize,
                      ),
                      child: Icon(
                        prefixIcon,
                        color: CustomColor.itemSubColor,
                      ),
                    ),
                  ),
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingMiddleSize,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          title,
                          style: kTextMainStyleMiddle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingMiddleSize,
                      ),
                      child: Text(
                        subContents!,
                        style: kTextMainStyleMiddle,
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
