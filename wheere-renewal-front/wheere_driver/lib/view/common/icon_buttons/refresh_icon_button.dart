import 'package:flutter/material.dart';
import '../../../styles/styles.dart';

class RefreshIconButton extends StatelessWidget {
  final void Function()? onPressed;

  const RefreshIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.refresh,
        size: kIconMainSize,
        color: CustomColor.itemSubColor,
      ),
    );
  }
}
