import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';

class CustomDropDownButton extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(dynamic) onChanged;

  const CustomDropDownButton({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(
                value: e, child: Text(e, style: kTextMainStyleSmall)))
            .toList(),
        onChanged: onChanged);
  }
}
