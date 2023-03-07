import 'package:flutter/material.dart';
import '../../../styles/styles.dart';

class BackIconButton extends StatelessWidget {
  final void Function()? onPressed;

  const BackIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.navigate_before,
        size: kIconMainSize,
        color: CustomColor.itemSubColor,
      ),
    );
  }
}
