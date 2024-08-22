import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';

class CustomTextFormTaskField extends StatelessWidget {
  CustomTextFormTaskField(
      {super.key,
      required this.hintText,
      this.maxLines = 1,
      this.validator,
      this.controller});

  final String hintText;
  int maxLines;

  String? Function(String?)? validator;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConfigAppProvider>(context);
    var theme = Theme.of(context);
    return TextFormField(
      cursorColor: AppColors.blackColor,
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.text,
      style: theme.textTheme.bodySmall?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium,
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: provider.isDarkMode()
                      ? AppColors.wightColor
                      : AppColors.blackColor)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2)),
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(
                color: provider.isDarkMode()
                    ? AppColors.wightColor
                    : AppColors.blackColor)
          ),

          contentPadding: const EdgeInsets.symmetric(horizontal: 6,vertical: 0)),
    );
  }
}
