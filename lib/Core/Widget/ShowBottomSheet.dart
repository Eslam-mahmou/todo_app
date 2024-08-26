import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:todo_app/Core/Services/showSnakBar.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Core/Utils/AppFirebase.dart';
import 'package:todo_app/Core/Widget/CustomButton.dart';
import 'package:todo_app/Core/Widget/CustomTextFormTaskField.dart';
import 'package:todo_app/Models/TaskModel.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TimeOfDay timeDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var _localizations = AppLocalizations.of(context)!;
    var provider = Provider.of<ConfigAppProvider>(context);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
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
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return _localizations.please_enter_your_task_title;
                  }
                  return null;
                },
                controller: titleController,
                hintText: _localizations.enter_task_title,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextFormTaskField(
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return _localizations.please_enter_your_task_details;
                  }
                  return null;
                },
                controller: descriptionController,
                maxLines: 4,
                hintText: _localizations.enter_task_details,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _localizations.select_date,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  InkWell(
                    onTap: () {
                      showPickerDate();
                    },
                    child: Text(
                      DateFormat("dd MMM yyyy").format(selectedDate),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _localizations.select_time,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  InkWell(
                    onTap: () {
                      showPickerTime();
                    },
                    child: Text(
                      "${timeDay.hour}:${timeDay.minute}",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .04,
              ),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel taskModel = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        dateTime: selectedDate,
                        time: "${timeDay.hour}:${timeDay.minute}");
                    EasyLoading.show();
                    AppFirebase.addTaskToFireStore(taskModel).then((value) {
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      SnackBarService.showSuccessMessage(
                          "Task added successfully");
                      print("Task added successfully");
                    });
                  }
                },
                text: _localizations.save,
              ),
              SizedBox(
                height: height * .02,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showPickerDate() async {
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

  void showPickerTime() async {
    var currentTime = await showTimePicker(
        context: context,
        initialTime: timeDay,
        initialEntryMode: TimePickerEntryMode.dial,
    );
    if (currentTime != null) {
      setState(() {
        timeDay = currentTime;
      });
    }
  }
}
