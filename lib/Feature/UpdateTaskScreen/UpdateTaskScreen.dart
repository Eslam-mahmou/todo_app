import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Models/TaskModel.dart';

import '../../Core/Services/Provider/ConfigAppProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Core/Services/showSnakBar.dart';
import '../../Core/Utils/AppColors.dart';
import '../../Core/Utils/AppFirebase.dart';
import '../../Core/Widget/CustomButton.dart';
import '../../Core/Widget/CustomTextFormTaskField.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key});

  static const String routeName = "/update";

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  var arg;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  GlobalKey<FormState>formKey = GlobalKey();
  DateTime selectDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var provider = Provider.of<ConfigAppProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    arg = ModalRoute
        .of(context)!
        .settings
        .arguments as TaskModel;
    return Form(
      key: formKey,
      child: Scaffold(
        body: Stack(clipBehavior: Clip.none, children: [
          Container(
            padding: EdgeInsets.only(
              top: height * .07,
              left: width * .04,
              right: width * .04,
            ),
            width: width,
            height: height * .22,
            color: AppColors.primaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: provider.isDarkMode()
                        ? AppColors.blackColor
                        : AppColors.wightColor,
                  ),
                ),
                SizedBox(
                  width: width * .04,
                ),
                Text(
                  localizations.to_do_list,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: height * .17,
                left: width * .07,
                right: width * .07,
              ),
              padding: EdgeInsets.only(
                top: height * .04,
                left: width * .03,
                right: width * .03,
              ),
              width: width,
              height: height * .74,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: provider.isDarkMode()
                      ? AppColors.bottomBlackColor
                      : AppColors.wightColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    localizations.edit_task,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: provider.isDarkMode()
                            ? AppColors.wightColor
                            : AppColors.blackColor),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  CustomTextFormTaskField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return localizations.please_enter_your_task_title;
                      }
                      return null;
                    },
                    controller: titleController,
                    hintText: arg.title,

                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormTaskField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return localizations.please_enter_your_task_details;
                      }
                      return null;
                    },
                    controller: descriptionController,
                    maxLines: 4,
                    hintText: arg.description,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    localizations.select_time,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  InkWell(
                    onTap: () {
                      showPickerTime();
                    },
                    child: Text(
                      DateFormat("dd MMM yyyy").format(arg.dateTime),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: height * .07,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .06),
                    child: CustomButton(
                      onPressed: ()  {
                        if (formKey.currentState!.validate()) {

                          TaskModel taskModel = TaskModel(
                              id:arg.id,
                              title: titleController.text,
                              description: descriptionController.text,
                              dateTime: arg.dateTime,
                          );
                          EasyLoading.show();
                          AppFirebase.updateTask(taskModel).then((value){
                            EasyLoading.dismiss();
                            Navigator.pop(context);
                            SnackBarService.showSuccessMessage("Task updated successfully");

                          }).catchError((error){
                            EasyLoading.dismiss();
                            SnackBarService.showErrorMessage(error.toString());
                          });
                        }
                      },
                      text: localizations.save_changes,
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  )
                ],
              ),
            ),
          )
        ]),
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
        arg.dateTime = currentDate;
      });
    }
  }
}
