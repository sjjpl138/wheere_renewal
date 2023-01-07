import 'package:flutter/material.dart';
import 'package:wheere/styles/screens.dart';

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
          borderRadius: BorderRadius.circular(kBorderRadiusSize)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(kPaddingSize),
                child: Icon(
                  prefixIcon,
                  size: kIconSubSize,
                  color: CustomColor.itemSubColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPaddingSize),
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
              contentPadding: const EdgeInsets.only(
                left: kPaddingSize,
                bottom: kPaddingSize,
              ),
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
