import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Core/Services/Provider/ConfigAppProvider.dart';
import 'package:todo_app/Core/Utils/AppAssets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';
import 'package:todo_app/Core/Widget/ShowBottomSheet.dart';
import 'SettingScreen/SettingView.dart';
import 'TasksScreen/TasksView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _appLocalizations = AppLocalizations.of(context)!;
    var provider = Provider.of<ConfigAppProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: provider.isDarkMode()
            ? AppColors.bottomBlackColor
            : AppColors.wightColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(AppAssets.iconTasks),
                ),
                label: _appLocalizations.tasks_list),
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(AppAssets.iconSetting),
                ),
                label: _appLocalizations.setting)
          ],
        ),
      ),
      body: selectedIndex == 0 ? const TasksListView() : const SettingView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        shape: StadiumBorder(
            side: BorderSide(
                color: provider.isDarkMode()
                    ? AppColors.bottomBlackColor
                    : AppColors.wightColor,
                width: 4)),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const ShowBottomSheet();
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: AppColors.wightColor,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
