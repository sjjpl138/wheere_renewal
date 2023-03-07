import 'package:flutter/material.dart';
import '../../../styles/styles.dart';

class LogoutIconButton extends StatelessWidget {
  final void Function()? onPressed;

  const LogoutIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.logout,
        size: kIconMainSize,
        color: CustomColor.itemSubColor,
      ),
    );
  }
}
