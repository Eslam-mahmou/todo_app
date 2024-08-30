import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:todo_app/Feature/ForgetPasswordScreen/ForgetPasswordView.dart';
import 'package:todo_app/Feature/LoginScreen/LoginView.dart';
import 'package:todo_app/Feature/RegisterScreen/RegisterView.dart';
import 'package:todo_app/Feature/SplashScreen/SplashView.dart';
import 'package:todo_app/Feature/UpdateTaskScreen/UpdateTaskScreen.dart';
import 'package:todo_app/Feature/layoutView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Core/Utils/AppTheme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ConfigAppProvider()
      ..getTheme()
      ..getLang(),
    child: const ToDoApp(),
  ));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConfigAppProvider>(context);
    return MaterialApp(
      title: "To-Do App",
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routeName,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: provider.themeMode,
      darkTheme: AppTheme.darkTheme,
      locale:provider.locale,

      theme: AppTheme.lightTheme,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LoginView.routeName: (context) => const LoginView(),
        RegisterView.routeName: (context) => const RegisterView(),
        HomeView.routeName: (context) => const HomeView(),
        ForgetPasswordView.routeName: (context) => const ForgetPasswordView(),
        UpdateTaskScreen.routeName: (context) => const UpdateTaskScreen()
      },
    );
  }
}
