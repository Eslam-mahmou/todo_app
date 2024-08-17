
import 'package:flutter/material.dart';

class ValidatorModels {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email ';
    }
    final regex =
    RegExp( r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email ';
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password ';
    }
    if (value.length < 8) {
      return 'Password should be at least 8 characters long ';
    }
    final regex =RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!regex.hasMatch(value)) {
      return 'Password should contain at least one uppercase letter, one lowercase letter, one number, and one special character ';
    }
    return null;
  }
  String? validateConfirmPassword( String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password ';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match ';
    }
    return null;
  }
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name ';
    }
    return null;
  }

}
