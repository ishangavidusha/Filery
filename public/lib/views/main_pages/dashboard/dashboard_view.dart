import 'package:fileryapp/models/system_infomation.dart';
import 'package:fileryapp/services/sysinfo_service.dart';
import 'package:fileryapp/utils/appColors.dart';
import 'package:fileryapp/views/components/filery_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'components/disk_network_and_os.dart';
import 'components/ram_and_cpu.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({ Key? key }) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}
class _DashboardViewState extends State<DashboardView> {

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FText(
                  text: "Dashboard",
                  fontSize: 0.02,
                  style: TextStyle(
                    color: AppColors.mainTextColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2 
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.watch<SysInfoService>().conected ? Color(0xFF0be881) : Color(0xFFff5e57),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.watch<SysInfoService>().conected ? Color(0xFF05c46b) : Color(0xFFff3f34)
                        ),
                        child: Icon(context.watch<SysInfoService>().conected ? Icons.done : Icons.close, color: Colors.white, size: AppColors.getFontSize(devWidth, 0.01),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 2),
                        child: FText(
                          text: context.watch<SysInfoService>().conected ? "online" : "offline",
                          fontSize: 0.01,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RamAndCpuLayoutBuilder(),
            SizedBox(
              height: 10,
            ),
            DiskNetworkAndOsLayout(),
          ],
        ),
      ),
    );
  }
}