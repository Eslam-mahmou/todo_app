import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Core/Widget/CustomButton.dart';
import 'package:todo_app/Core/Widget/CustomTextFormTaskField.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var _localizations = AppLocalizations.of(context)!;
    var provider = Provider.of<ConfigAppProvider>(context);
    return SingleChildScrollView(
      child: Container(
        width: width,
        padding: EdgeInsets.only(
            top: height * .03,
            left: width * .08,
            right: width * .08,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: provider.isDarkMode()
              ? AppColors.bottomBlackColor
              : AppColors.wightColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _localizations.add_new_task,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                  color: provider.isDarkMode()
                      ? AppColors.wightColor
                      : AppColors.blackColor),
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextFormTaskField(
              hintText: _localizations.enter_task_title,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CustomTextFormTaskField(
              maxLines: 4,
              hintText: _localizations.enter_task_details,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              _localizations.select_time,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.blackColor),
            ),
            SizedBox(
              height: height * .03,
            ),
            InkWell(
              onTap: () {
                showPickerTime();
              },
              child: Text(
                DateFormat("dd MMM yyyy").format(selectedDate),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            CustomButton(
              onPressed: () {},
              text: "Save",
            ),
            SizedBox(
              height: height * .02,
            )
          ],
        ),
      ),
    );
  }

  void showPickerTime() async {
    var currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (currentDate != null) {
      setState(() {
        selectedDate = currentDate;
      });
    }
  }
}
