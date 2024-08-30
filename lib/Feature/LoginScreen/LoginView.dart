import 'package:flutter/material.dart';
import 'package:todo_app/Core/Utils/AppAssets.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';
import 'package:todo_app/Core/Utils/AppFirebase.dart';
import 'package:todo_app/Feature/ForgetPasswordScreen/ForgetPasswordView.dart';
import 'package:todo_app/Feature/RegisterScreen/RegisterView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Core/Widget/CustomTextFormLoginField.dart';
import '../../Core/Widget/CustomCardLogin.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "Eslam12@route.com");
  final passwordController = TextEditingController(text: "ASDasd@123");
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
     var _localization=AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImage),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            _localization.login,
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: height * 0.28,
            right: width * .06,
            left: width * .06,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _localization.welcome_back,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  CustomTextFormLoginField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    suffixIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your email address.";
                      }
                    },
                    label: _localization.email,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextFormLoginField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your password.";
                      }
                    },
                    obscureText: obscureText,
                    suffixIcon: InkWell(
                        onTap: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        child: obscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    label: _localization.password,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordView.routeName);
                      },
                      child: Text(
                        _localization.forget_password,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: height * .05,
                  ),
                  CustomLoginCard(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AppFirebase().signIn(emailController.text,
                            passwordController.text, context);
                      }
                    },
                    text: _localization.login,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  TextButton(
                      style:
                          TextButton.styleFrom(alignment: Alignment.centerLeft),
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterView.routeName);
                      },
                      child: Text(_localization.create_account,
                          style: theme.textTheme.labelMedium?.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
