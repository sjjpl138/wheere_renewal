import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

class SettingIconButton extends StatelessWidget {
  final void Function() onPressed;

  const SettingIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.settings,
        size: kIconMainSize,
        color: CustomColor.itemSubColor,
      ),
    );
  }
}
