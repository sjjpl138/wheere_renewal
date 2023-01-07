import 'package:flutter/material.dart';
import 'package:wheere/styles/border_radius.dart';
import 'package:wheere/styles/colors.dart';

import '../../styles/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;

  final IconData? prefixIcon;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColor.textFormMainColor,
          borderRadius: BorderRadius.circular(kBorderRadius)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Icon(
                  prefixIcon,
                  color: CustomColor.itemSubColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  labelText ?? "",
                  style: kTextMainStyleSmall,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: CustomColor.textFormMainColor,
            keyboardType: keyboardType,
            style: kTextMainStyleMiddle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              hintText: "Enter $hintText",
              hintStyle: kTextMainStyleMiddle,
              filled: true,
              fillColor: CustomColor.textFormMainColor,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
