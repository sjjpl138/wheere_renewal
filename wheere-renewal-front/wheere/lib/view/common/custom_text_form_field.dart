import 'package:flutter/material.dart';
import 'package:wheere/styles/colors.dart';

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
          borderRadius: BorderRadius.circular(12)),
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
                  style: const TextStyle(
                      color: CustomColor.textMainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: CustomColor.textFormMainColor,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: CustomColor.textMainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              hintText: "Enter $hintText",
              hintStyle: const TextStyle(
                color: CustomColor.textSubColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                overflow: TextOverflow.ellipsis,
              ),
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
