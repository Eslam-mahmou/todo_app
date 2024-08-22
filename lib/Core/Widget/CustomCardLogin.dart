import 'package:flutter/material.dart';

import '../Utils/AppColors.dart';

class CustomLoginCard extends StatelessWidget {
  CustomLoginCard(
      {super.key, required this.text, this.onPressed, this.icon, this.color,this.style});

  final String text;
  void Function()? onPressed;
  Icon? icon;
  Color? color;
  TextStyle? style;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor:color?? AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            fixedSize: Size(width, height * .054)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style:style?? theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.wightColor, fontWeight: FontWeight.w700),
            ),
            icon ??
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.wightColor,
                  size: 30,
                )
          ],
        ));
  }
}
