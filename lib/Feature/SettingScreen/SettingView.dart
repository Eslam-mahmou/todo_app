import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Core/Utils/AppColors.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<ConfigAppProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    List<String> _languages = [localizations.english, localizations.arabic];
    List<String> _modes = [localizations.light, localizations.dark];
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: height * .12, horizontal: width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.language,
            style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                color: provider.isDarkMode()
                    ? AppColors.wightColor
                    : AppColors.blackColor),
          ),
          SizedBox(
            height: height * .02,
          ),
          CustomDropdown<String>(
              hintText: "Select your language",

              decoration: CustomDropdownDecoration(
                  closedFillColor: provider.isDarkMode()
                      ? AppColors.bottomBlackColor
                      : AppColors.wightColor,
                  expandedFillColor: provider.isDarkMode()
                      ? AppColors.bottomBlackColor
                      : AppColors.wightColor,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: provider.isDarkMode()
                        ? AppColors.wightColor
                        : AppColors.blackColor,
                  ),
             headerStyle: theme.textTheme.bodyMedium?.copyWith(
                 fontSize: 18,
                 color: AppColors.primaryColor
             ),
                listItemStyle: provider.isDarkMode()?theme.textTheme.bodyMedium?.copyWith(
                   fontSize: 16,
                   color: AppColors.wightColor
                 ):theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColors.blackColor
                ),
                ),
              items: _languages,
              initialItem: provider.currentLanguage == "en"
                  ? _languages[0]
                  : _languages[1],
              onChanged: (value) {
                if (value == _languages[0]) {
                  provider.changeLanguage("en");
                }
                if (value == _languages[1]) {
                  provider.changeLanguage("ar");
                }
              }),
          SizedBox(
            height: height * .06,
          ),
          Text(
            localizations.mode,
            style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                color: provider.isDarkMode()
                    ? AppColors.wightColor
                    : AppColors.blackColor),
          ),
          SizedBox(
            height: height * .015,
          ),
          CustomDropdown<String>(
              hintText: "Select your theme",
              decoration: CustomDropdownDecoration(
                  closedFillColor: provider.isDarkMode()
                      ? AppColors.bottomBlackColor
                      : AppColors.wightColor,
                  expandedFillColor: provider.isDarkMode()
                      ? AppColors.bottomBlackColor
                      : AppColors.wightColor,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: provider.isDarkMode()
                        ? AppColors.wightColor
                        : AppColors.blackColor,
                  ),
                headerStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    color: AppColors.primaryColor
                ),
                listItemStyle: provider.isDarkMode()?theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: AppColors.wightColor
                ):theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColors.blackColor
                ),
              ),
              items: _modes,
              initialItem: provider.currentThemeMode == ThemeMode.light
                  ? _modes[0]
                  : _modes[1],
              onChanged: (value) {
                if (value == _modes[0]) {
                  provider.changeThemeMode(ThemeMode.light);
                }
                if (value == _modes[1]) {
                  provider.changeThemeMode(ThemeMode.dark);
                }
              })
        ],
      ),
    );
  }
}
