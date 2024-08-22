import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';
import 'package:todo_app/Core/Utils/AppFirebase.dart';
import 'package:todo_app/Feature/TasksScreen/Widget/CustomTaskItem.dart';
import 'package:todo_app/Feature/UpdateTaskScreen/UpdateTaskScreen.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  final EasyInfiniteDateTimelineController controller =
      EasyInfiniteDateTimelineController();
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<ConfigAppProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Column(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: height * .07,
              left: width * .1,
              right: width * .1,
            ),
            width: width,
            height: height * .22,
            color: AppColors.primaryColor,
            child: Text(
              localizations.to_do_list,
              style: theme.textTheme.titleLarge,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: height * .3),
          ),
          Positioned(
            top: height * .15,
            child: SizedBox(
              width: width,
              child: EasyInfiniteDateTimeLine(
                controller: controller,
                firstDate: DateTime(2024, 7, 28),
                focusDate: focusDate,
                lastDate: DateTime(2025, 12, 31),
                onDateChange: (selectedDate) {
                  setState(() {
                    focusDate = selectedDate;
                  });
                },
                showTimelineHeader: false,
                timeLineProps: const EasyTimeLineProps(separatorPadding: 20),
                dayProps: EasyDayProps(
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: provider.isDarkMode()
                          ? AppColors.bottomBlackColor.withOpacity(.8)
                          : AppColors.wightColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    dayNumStyle:
                        theme.textTheme.labelMedium?.copyWith(fontSize: 18),
                    monthStrStyle: theme.textTheme.labelMedium,
                    dayStrStyle: theme.textTheme.labelMedium,
                  ),
                  inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppColors.wightColor.withOpacity(.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      dayNumStyle: theme.textTheme.labelMedium
                          ?.copyWith(color: AppColors.blackColor),
                      monthStrStyle: theme.textTheme.labelMedium
                          ?.copyWith(fontSize: 14, color: AppColors.blackColor),
                      dayStrStyle: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.blackColor, fontSize: 14)),
                  todayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppColors.wightColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      dayNumStyle: theme.textTheme.bodySmall
                          ?.copyWith(color: AppColors.blackColor),
                      monthStrStyle: theme.textTheme.bodySmall
                          ?.copyWith(fontSize: 14, color: AppColors.blackColor),
                      dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.blackColor, fontSize: 14)),
                ),
              ),
            ),
          ),
        ],
      ),
      StreamBuilder(
          stream: AppFirebase.getTasksFromFireStore(focusDate),
          builder: (context, snapshot) {
            var taskList =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: taskList.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, UpdateTaskScreen.routeName,
                      arguments: taskList[index],
                    );
                    },
                    child: CustomTaskItem(
                      taskModel: taskList[index],
                    ),
                  );
                },
              ),
            );
          }),
    ]);
  }
}
