import 'package:flutter/material.dart';
import '../../../styles/styles.dart';

class EditIconButton extends StatelessWidget {
  final void Function()? onPressed;

  const EditIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.edit,
        size: kIconMainSize,
        color: CustomColor.itemSubColor,
      ),
    );
  }
}
