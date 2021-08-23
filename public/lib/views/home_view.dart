import 'package:fileryapp/services/auth_service.dart';
import 'package:fileryapp/services/sysinfo_service.dart';
import 'package:fileryapp/utils/appColors.dart';
import 'package:fileryapp/views/components/drawer_button.dart';
import 'package:fileryapp/views/main_pages/dashboard_view.dart';
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
  double priviewTabSize = 320;
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
    Provider.of<SysInfoService>(context, listen: false).conect();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.lightBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  AppColors.boxShadow
                ]
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.file_download, color: AppColors.mainTextColor, size: 22,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Filery",
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
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
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthService>().logout();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: AppColors.buttonGradeantColors,
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight
                          ),
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
            right: priviewTabSize,
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
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: priviewTabSize,
            child: Container(
              color: Colors.blueGrey
            ),
          ),
        ],
      ),
    );
  }
}