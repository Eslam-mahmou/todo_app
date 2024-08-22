import 'package:flutter/material.dart';

import '../Utils/AppColors.dart';

class CustomTextFormLoginField extends StatelessWidget {
  CustomTextFormLoginField(
      {super.key,
      required this.label,
      this.validator,
      this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.suffixIcon,
    });

  final String label;
  String? Function(String?)? validator;
  TextEditingController? controller;
  bool obscureText;
  TextInputType? keyboardType;
  Widget? suffixIcon;


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      cursorColor: AppColors.blackColor,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style:const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: theme.textTheme.labelMedium?.copyWith(fontSize: 18),
          border: buildOutlineInputBorder(),
          focusedBorder:
              buildOutlineInputBorder(width: 3, color: AppColors.primaryColor),
          enabledBorder: buildOutlineInputBorder(),
          suffixIcon: suffixIcon,

      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(
      {double width = 1.5, Color color = AppColors.blackColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: width, color: color));
  }
}
