import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/Feature/LoginScreen/LoginView.dart';

import '../../Core/Utils/AppAssets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String routeName = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.splashBackground),
                fit: BoxFit.cover)),
      ),
    );
  }
}
