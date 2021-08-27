import 'package:fileryapp/services/auth_service.dart';
import 'package:fileryapp/services/sysinfo_service.dart';
import 'package:fileryapp/utils/appColors.dart';
import 'package:fileryapp/views/components/drawer_button.dart';
import 'package:fileryapp/views/main_pages/dashboard/dashboard_view.dart';
import 'package:fileryapp/views/main_pages/directory_view.dart';
import 'package:fileryapp/views/main_pages/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  double drawerSize = 220;
  late PageController pageController;


  void onPageCahngeClick(int value) {
    pageController.animateToPage(value, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void onPageChange(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    // Provider.of<SysInfoService>(context, listen: false).conect();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    // Provider.of<SysInfoService>(context, listen: false).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: drawerSize,
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  AppColors.normalShadow
                ]
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    height: devHeight * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DrawerButton(
                            text: "Dashboard",
                            icon: Icons.home,
                            indexValue: 0,
                            selectedValue: selectedIndex,
                            onTap: (value) {
                              onPageCahngeClick(value);
                            },
                          ),
                          DrawerButton(
                            text: "Directory",
                            icon: Icons.folder,
                            indexValue: 1,
                            selectedValue: selectedIndex,
                            onTap: (value) {
                              onPageCahngeClick(value);
                            },
                          ),
                          DrawerButton(
                            text: "Settings",
                            icon: Icons.settings,
                            indexValue: 2,
                            selectedValue: selectedIndex,
                            onTap: (value) {
                              onPageCahngeClick(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthService>().logout();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: AppColors.buttonGradeantColors,
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight
                          ),
                          boxShadow: [
                            BoxShadow(color: AppColors.buttonGradeantColors.first.withOpacity(0.4), offset: Offset(0, 4), blurRadius: 8.0,)
                          ],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log Out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: drawerSize,
            right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: onPageChange,
                children: [
                  DashboardView(),
                  DirectoryView(),
                  SettingsView()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}