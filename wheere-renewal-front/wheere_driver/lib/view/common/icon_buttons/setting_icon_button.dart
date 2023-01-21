import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

class SettingIconButton extends StatelessWidget {

  const SettingIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.settings,
        size: kIconMainSize,
        color: CustomColor.itemSubColor,
      ),
    );
  }
}
