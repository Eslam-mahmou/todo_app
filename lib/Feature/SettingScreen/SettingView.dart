import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Feature/SettingScreen/Widget/SettingViewBody.dart';
import '../../Core/Utils/AppColors.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var localizations = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: height * .06,
            left: width * .1,
            right: width * .1,
          ),
          width: width,
          height: height * .22,
          color: AppColors.primaryColor,
          child: Text(
            localizations.setting,
            style: theme.textTheme.titleLarge,
          ),
        ),
       const SettingViewBody()
      ],
    );
  }
}
