import 'package:flutter/material.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key,required this.text,this.onPressed});
  final String text;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FilledButton(
        style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
        ),
        onPressed: onPressed, child: Text(text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: AppColors.wightColor,
        fontWeight: FontWeight.w600,
      ),));
  }
}
