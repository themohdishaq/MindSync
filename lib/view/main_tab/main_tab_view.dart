import 'package:flutter/material.dart';
import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/common_widget/tab_button.dart';
import 'package:nayapakistan/view/dialogue_flow/screen.dart';
import 'package:nayapakistan/view/home/home_view.dart';

import 'package:nayapakistan/view/main_tab/select_view.dart';
import 'package:nayapakistan/view/profile/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 1;
  final PageStorageBucket pageBucket = PageStorageBucket();
  Widget currentTab = const HomeView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(color: TColor.white, boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
        ]),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(
                icon: "assets/images/home_tab.png",
                selectIcon: "assets/images/home_tab_select.png",
                isActive: selectTab == 0,
                onTap: () {
                  selectTab = 0;
                  print('ok');
                  currentTab = const HomeView();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: "assets/images/activity_tab.png",
                selectIcon: "assets/images/activity_tab_select.png",
                isActive: selectTab == 1,
                onTap: () {
                  selectTab = 1;

                  currentTab = const SelectView();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: "assets/images/camera_tab.png",
                selectIcon: "assets/images/camera_tab.png",
                isActive: selectTab == 2,
                onTap: () {
                  selectTab = 2;
                  //  currentTab = const PhotoProgressView();
                  currentTab = const Dialogue();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: "assets/images/profile_tab.png",
                selectIcon: "assets/images/profile_tab_select.png",
                isActive: selectTab == 3,
                onTap: () {
                  selectTab = 3;
                  currentTab = const ProfileView();
                  if (mounted) {
                    setState(() {});
                  }
                })
          ],
        ),
      )),
    );
  }
}
