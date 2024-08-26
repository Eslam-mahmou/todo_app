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
      this.initialValue,
       this.onChanged,
      this.controller,
    });
  void Function(String)? onChanged;
  final String hintText;
  int maxLines;
  String? initialValue;
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
      onChanged:onChanged ,
      controller: controller,
      keyboardType: TextInputType.text,
      style: theme.textTheme.bodySmall?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      initialValue: initialValue,
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
