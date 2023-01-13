import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class CustomAppBar {
  const CustomAppBar({Key? key});

  static AppBar build(
    BuildContext context, {
    required String title,
    Widget? leading,
    List<Widget>? actions,
  }) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: kTextMainStyleLarge,
      ),
      backgroundColor: CustomColor.backgroundMainColor,
      elevation: 0.0,
      leading: leading,
      actions: actions,
    );
  }
}
