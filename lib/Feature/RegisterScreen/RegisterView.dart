import 'package:flutter/material.dart';
import 'package:todo_app/Core/Utils/AppFirebase.dart';
import 'package:todo_app/Core/Services/ValidateData.dart';
import '../../Core/Utils/AppAssets.dart';
import '../../Core/Utils/AppColors.dart';
import '../../Core/Widget/CustomTextFormLoginField.dart';
import '../../Core/Widget/CustomCardLogin.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  ValidatorModels validatorModels = ValidatorModels();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText = false;
  bool obscureConfirm = false;

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
            _localization.register,
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
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomTextFormLoginField(
                    controller: validatorModels.nameController,
                    validator: validatorModels.validateName,
                    keyboardType: TextInputType.name,
                    label:_localization.name,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextFormLoginField(
                    controller: validatorModels.emailController,
                    validator: validatorModels.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: const Icon(Icons.email),
                    label: _localization.email,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextFormLoginField(
                    controller: validatorModels.passwordController,
                    validator: validatorModels.validatePassword,
                    keyboardType: TextInputType.text,
                    obscureText: !obscureText,
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
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextFormLoginField(
                    controller: validatorModels.confirmPasswordController,
                    validator: validatorModels.validateConfirmPassword,
                    keyboardType: TextInputType.text,
                    obscureText: !obscureConfirm,
                    suffixIcon: InkWell(
                        onTap: () {
                          obscureConfirm = !obscureConfirm;

                          setState(() {});
                        },
                        child: obscureConfirm
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    label: _localization.password_confirmation,
                  ),
                  SizedBox(
                    height: height * .07,
                  ),
                  CustomLoginCard(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        AppFirebase().signUp(
                            validatorModels.emailController.text,
                            validatorModels.passwordController.text,
                            context,
                            validatorModels.nameController.text);


                      }
                    },
                    text: _localization.register,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
