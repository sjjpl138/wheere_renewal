import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class CustomRadioButton<T> extends StatefulWidget {
  final T? value;
  final T? groupValue;

  final void Function(T?)? onChanged;

  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () =>
          widget.onChanged != null ? widget.onChanged!(widget.value) : null,
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.value == widget.groupValue
            ? CustomColor.buttonSubColor
            : CustomColor.buttonDisabledColor,
        shape: const CircleBorder(),
        side: BorderSide.none,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Icon(
        Icons.check,
        color: CustomColor.backGroundSubColor,
        size: kIconMiddleSize,
      ),
    );
  }
}
