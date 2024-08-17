import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';

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
              top: height * .06,
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
            margin: EdgeInsets.only(bottom: height *.3),
          ),
          Positioned(
            top: height * .15,
            child: SizedBox(
              width: width,
              child: EasyInfiniteDateTimeLine(
                controller: controller,
                firstDate: DateTime.now(),
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
                      color: AppColors.wightColor,
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
      Container(
        margin: EdgeInsets.only(
             right: width * .05, left: width * 0.05,
        bottom: height*.05),
        padding: EdgeInsets.symmetric(
            vertical: height * .022, horizontal: width * .01),
        width: width,
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
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Play basket ball",
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: height * .002),
              Text(
                "Description",
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
                    "10:00 AM",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          trailing: Container(
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
      )
    ]);
  }
}
