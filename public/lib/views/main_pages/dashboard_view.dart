import 'package:fileryapp/models/system_infomation.dart';
import 'package:fileryapp/services/sysinfo_service.dart';
import 'package:fileryapp/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({ Key? key }) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}
class _DashboardViewState extends State<DashboardView> {
  SystemInfomation systemInfomation = SystemInfomation();

  @override
  Widget build(BuildContext context) {
    systemInfomation = context.watch<SysInfoService>().sysData;
    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.mainTextColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 4 
            ),
          ),
          SizedBox(
            height: 10,
          ),
          systemInfomation.info != null ? Text(
            "Server Uptime: ${systemInfomation.info!.bootTime.toString()}",
            style: TextStyle(
              fontSize: 8.sp,
              color: AppColors.mainTextColor,
              letterSpacing: 4 
            ),
          ) : Container(),
          SizedBox(
            height: 10,
          ),
          systemInfomation.info != null ? Text(
            "Cpu Load: ${systemInfomation.info!.cpuLoad.toString()}",
            style: TextStyle(
              fontSize: 8.sp,
              color: AppColors.mainTextColor,
              letterSpacing: 4 
            ),
          ) : Container(),
        ],
      ),
    );
  }
}