import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/Core/Services/showSnakBar.dart';

import '../../Feature/layoutView.dart';

class AppFirebase {
  static Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var id = credential.user?.uid ?? '';
      EasyLoading.dismiss();
      ShowSnackBar.showBar(context, "Registration successful!");
      Navigator.pushReplacementNamed(
          context, HomeView.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowSnackBar.showBar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        ShowSnackBar.showBar(context, "Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        ShowSnackBar.showBar(context, "The email address is not valid.");
      } else if (e.code == 'user-disabled') {
        ShowSnackBar.showBar(context,
            "The user corresponding to the given email has been disabled.");
      } else if (e.code == 'too-many-requests') {
        ShowSnackBar.showBar(
            context, "Too many attempts to sign in as this user.");
      } else if (e.code == "The supplied auth credential is incorrect") {
        ShowSnackBar.showBar(
            context, "The supplied auth credential is incorrect.");
      } else if (e.code == "network-request-failed" ||
          e.code == "network-error") {
        ShowSnackBar.showBar(context,
            "network connection error. Please check your internet connection.");
      }
      else{
        ShowSnackBar.showBar(context, "$e");
      }
    } catch (e) {
      ShowSnackBar.showBar(context, e.toString());
    }
    EasyLoading.dismiss();
  }

  static Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.dismiss();
      ShowSnackBar.showBar(context, "Login successful!");
      Navigator.pushReplacementNamed(
          context, HomeView.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowSnackBar.showBar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        ShowSnackBar.showBar(context, "Wrong password provided for that user.");
      } else if (e.code == 'invalid-credential') {
        ShowSnackBar.showBar(context, "Email or password is not valid.");
      } else if (e.code == 'user-disabled') {
        ShowSnackBar.showBar(context,
            "The user corresponding to the given email has been disabled.");
      } else if (e.code == 'too-many-requests') {
        ShowSnackBar.showBar(
            context, "Too many attempts to sign in as this user.");
      } else if (e.code == "Wrong password provided for that user.") {
        ShowSnackBar.showBar(
            context, "The supplied auth credential is incorrect.");
      } else if (e.code == "network-request-failed" ||
          e.code == "network-error") {
        ShowSnackBar.showBar(context,
            "network connection error. Please check your internet connection.");
      }
      else{
        ShowSnackBar.showBar(context, "$e");
      }
    } catch (e) {
      ShowSnackBar.showBar(context, e.toString());
    }
    EasyLoading.dismiss();
  }
  static Future<void> resetPassword(String email, BuildContext context) async {
  try {
    EasyLoading.show();
    final credential=  await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    EasyLoading.dismiss();
    ShowSnackBar.showBar(context, "Password reset email sent.");
  } on Exception catch (e) {
    ShowSnackBar.showBar(context, e.toString());
    print(e.toString());
  }catch (e) {
    ShowSnackBar.showBar(context, e.toString());
    print(e.toString());
  }
  EasyLoading.dismiss();
  }
}
