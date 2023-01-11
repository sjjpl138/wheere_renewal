import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

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
          color: CustomColor.backGroundSubColor,
          borderRadius: BorderRadius.circular(kBorderRadiusSize)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(kPaddingSmallSize),
                child: Icon(
                  prefixIcon,
                  size: kIconSubSize,
                  color: CustomColor.itemSubColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPaddingSmallSize),
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
            cursorColor: CustomColor.backGroundSubColor,
            keyboardType: keyboardType,
            obscureText: keyboardType == TextInputType.visiblePassword,
            style: kTextMainStyleMiddle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(
                left: kPaddingSmallSize,
                bottom: kPaddingSmallSize,
              ),
              hintText: hintText,
              hintStyle: kTextMainStyleMiddle,
              filled: true,
              fillColor: CustomColor.backGroundSubColor,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
