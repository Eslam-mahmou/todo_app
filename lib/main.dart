import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/Feature/ForgetPasswordScreen/ForgetPasswordView.dart';
import 'package:todo_app/Feature/LoginScreen/LoginView.dart';
import 'package:todo_app/Feature/RegisterScreen/RegisterView.dart';
import 'package:todo_app/Feature/SplashScreen/SplashView.dart';
import 'package:todo_app/Feature/layoutView.dart';

import 'Core/Utils/AppTheme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do App",
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routeName,
      builder: EasyLoading.init(),
      theme: AppTheme.lightTheme,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LoginView.routeName: (context) => const LoginView(),
        RegisterView.routeName: (context) => const RegisterView(),
        HomeView.routeName: (context) => const HomeView(),
        ForgetPasswordView.routeName : (context) => const ForgetPasswordView(),
      },
    );
  }
}
