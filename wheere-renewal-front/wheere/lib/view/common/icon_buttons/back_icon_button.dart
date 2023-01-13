import 'package:flutter/material.dart';
import '../../../styles/styles.dart';

class BackIconButton extends StatelessWidget {

  const BackIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.navigate_before,
        size: kIconMainSize,
        color: CustomColor.itemSubColor,
      ),
    );
  }
}
