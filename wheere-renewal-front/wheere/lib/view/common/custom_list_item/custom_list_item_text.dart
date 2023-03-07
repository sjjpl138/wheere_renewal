import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class CustomListItemText extends StatelessWidget {
  final String text;

  const CustomListItemText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kTextMainStyleSmall,
      textAlign: TextAlign.center,
    );
  }
}
