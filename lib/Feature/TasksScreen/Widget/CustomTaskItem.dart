import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/showSnakBar.dart';
import 'package:todo_app/Core/Utils/AppFirebase.dart';
import 'package:todo_app/Models/TaskModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Core/Services/Provider/ConfigAppProvider.dart';
import '../../../Core/Utils/AppColors.dart';

class CustomTaskItem extends StatelessWidget {
  CustomTaskItem({super.key, required this.taskModel});

  TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<ConfigAppProvider>(context);
    var loc = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
          color: provider.isDarkMode()
              ? AppColors.bottomBlackColor
              : AppColors.wightColor,
          borderRadius: BorderRadius.circular(16)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: .2,
          children: [
            SlidableAction(
              padding: EdgeInsets.zero,
              borderRadius: provider.currentLanguage == "en"
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
              onPressed: (context) {
                EasyLoading.show();
                AppFirebase.deleteTask(taskModel.id).then((value) {
                  EasyLoading.dismiss();
                  SnackBarService.showSuccessMessage(
                      "Task deleted successfully");
                }).catchError((error) {
                  EasyLoading.dismiss();
                  SnackBarService.showErrorMessage("Failed to delete task");
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: loc.delete,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: height * .022, horizontal: width * .01),
          decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? AppColors.bottomBlackColor
                  : AppColors.wightColor,
              borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Container(
              width: width * 0.013,
              height: height * .08,
              decoration: BoxDecoration(
                color: taskModel.isDone
                    ? AppColors.greenColor
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color: taskModel.isDone
                          ? AppColors.greenColor
                          : AppColors.primaryColor),
                ),
                SizedBox(height: height * .002),
                Text(
                  taskModel.description,
                  style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: provider.isDarkMode()
                          ? AppColors.wightColor
                          : AppColors.blackColor),
                ),
                SizedBox(height: height * .006),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.watch_later_outlined),
                    SizedBox(
                      width: width * .005,
                    ),
                    Text(
                      taskModel.time.toString(),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            trailing: InkWell(
              onTap: () {
                AppFirebase.saveTask(taskModel.id);
              },
              child: taskModel.isDone
                  ? Text(
                      loc.done,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: AppColors.greenColor),
                    )
                  : Container(
                      width: width * .16,
                      height: height * .045,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.wightColor,
                        size: 35,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
