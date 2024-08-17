import 'package:flutter/material.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';

class ShowSnackBar {
 static void showBar(BuildContext context, dynamic message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message,
    style:const TextStyle(
      color: Colors.white,
    ),),
    backgroundColor: AppColors.primaryColor,
    ));
  }
}
