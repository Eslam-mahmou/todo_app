import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:todo_app/Core/Utils/AppFirebase.dart';
import 'package:todo_app/Core/Widget/CustomTextFormLoginField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Core/Utils/AppAssets.dart';
import '../../Core/Utils/AppColors.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  static const String routeName = '/forgot-password';

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var _localization=AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: Container(
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
                _localization.forget,
                style: theme.textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * .05,
                  right: width * .05,
                  top: height * .3,
                ),
                child: Column(
                  children: [
                    Text(
                      _localization.you_can_reset_your_password,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: height * .05),
                    CustomTextFormLoginField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter an email address.';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: const Icon(Icons.mail_outline_outlined),
                      label: _localization.email,
                    ),
                    SizedBox(height: height * .06),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(8)
                        ),
                        fixedSize: Size(width * .65, height * .055)
                      ),
                        onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppFirebase.resetPassword(emailController.text, context);
                        }
                        },
                        child: Text(
                        _localization.reset_password,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.wightColor,
                            fontWeight: FontWeight.w700
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
