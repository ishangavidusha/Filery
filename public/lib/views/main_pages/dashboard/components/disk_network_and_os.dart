import 'package:fileryapp/utils/appColors.dart';
import 'package:fileryapp/views/components/filery_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DiskNetworkAndOsLayout extends StatelessWidget {
  const DiskNetworkAndOsLayout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 800) {
          return diskNetworkOsMobile(context);
        } else if (constraints.maxWidth <= 1200) {
          return diskNetworkOsTablet(context);
        } else {
          return diskNetworkOsDesktop(context);
        }
      },
    );
  }

  Widget diskNetworkOsMobile(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        getDiskSection(context, Size(devWidth - 260, 192)),
        getNetworkSection(context, Size(devWidth - 260, 192)),
        getOsSection(context, Size(devWidth - 260, 192))
      ],
    );
  }

  Widget diskNetworkOsTablet(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            getDiskSection(context, Size((devWidth - 260) * 0.5, 192)),
            getNetworkSection(context, Size((devWidth - 260) * 0.5, 192)),
          ],
        ),
        getOsSection(context, Size(devWidth - 260, 192))
      ],
    );
  }

  Widget diskNetworkOsDesktop(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        getDiskSection(context, Size((devWidth - 260) * 0.33, devWidth * 0.1)),
        getNetworkSection(context, Size((devWidth - 260) * 0.33, devWidth * 0.1)),
        getOsSection(context, Size((devWidth - 260) * 0.33, devWidth * 0.1))
      ],
    );
  }

  Widget getOsSection(BuildContext context, Size size) {
    double devWidth = MediaQuery.of(context).size.width;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.green,
    );
  }

  Widget getNetworkSection(BuildContext context, Size size) {
    double devWidth = MediaQuery.of(context).size.width;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              FText(
                text: "Network",
                fontSize: 0.015,
                style: TextStyle(
                  color: AppColors.minorTextColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2 
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width,
            child: Row(
              children: [
                Container(
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          color: Colors.blue,
                          size: AppColors.getFontSize(devWidth, 0.025),
                        ),
                        FText(
                          text: "125.5 MB/s",
                          fontSize: 0.02,
                          style: TextStyle(
                            color: AppColors.minorTextColor
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload,
                          color: Colors.green,
                          size: AppColors.getFontSize(devWidth, 0.025),
                        ),
                        FText(
                          text: "5.5 MB/s",
                          fontSize: 0.02,
                          style: TextStyle(
                            color: AppColors.minorTextColor
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 60,
                  minY: 0,
                  maxY: 100,
                  clipData: FlClipData.all(),
                  lineTouchData: LineTouchData(enabled: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 20),
                        FlSpot(5, 20),
                        FlSpot(10, 25),
                        FlSpot(15, 30),
                        FlSpot(20, 35),
                        FlSpot(25, 20),
                        FlSpot(30, 30),
                        FlSpot(35, 40),
                        FlSpot(45, 55),
                        FlSpot(50, 60),
                        FlSpot(55, 40),
                        FlSpot(60, 45),
                        FlSpot(65, 60),
                        FlSpot(70, 50),
                        FlSpot(75, 45),
                        FlSpot(80, 55),
                        FlSpot(85, 30),
                        FlSpot(90, 25),
                        FlSpot(95, 50),
                        FlSpot(100, 75),
                      ],
                      isCurved: false,
                      colors: [Color(0xFF19fe6c), Color(0xFF02eb8f)],
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        colors: [Color(0xFF19fe6c), Color(0xFF02eb8f)].map((color) => color.withOpacity(0.5)).toList(),
                      ),
                    ),
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 55),
                        FlSpot(5, 30),
                        FlSpot(10, 35),
                        FlSpot(15, 40),
                        FlSpot(20, 45),
                        FlSpot(25, 50),
                        FlSpot(30, 20),
                        FlSpot(35, 25),
                        FlSpot(45, 10),
                        FlSpot(50, 15),
                        FlSpot(55, 5),
                        FlSpot(60, 10),
                        FlSpot(65, 15),
                        FlSpot(70, 45),
                        FlSpot(75, 80),
                        FlSpot(80, 95),
                        FlSpot(85, 20),
                        FlSpot(90, 10),
                        FlSpot(95, 0),
                        FlSpot(100, 0),
                      ],
                      isCurved: false,
                      colors: [Color(0xFF0072ff), Color(0xFF4594ff)],
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        colors: [Color(0xFF0072ff), Color(0xFF4594ff)].map((color) => color.withOpacity(0.5)).toList(),
                      ),
                    ),
                  ],
                ),
                swapAnimationDuration: Duration(milliseconds: 10),
                swapAnimationCurve: Curves.easeIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDiskSection(BuildContext context, Size size) {
    double devWidth = MediaQuery.of(context).size.width;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              FText(
                text: "Disk And Swap Memory",
                fontSize: 0.015,
                style: TextStyle(
                  color: AppColors.minorTextColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2 
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 4),
                      child: Icon( 
                        Icons.storage,
                        color: AppColors.highLightColor,
                        size: AppColors.getFontSize(devWidth, 0.04),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: FText(text: "Disk 0 (Mount Point /)", fontSize: 0.012, style: TextStyle(color: AppColors.minorTextColor)),
                          ),
                          SfLinearGauge(
                            orientation: LinearGaugeOrientation.horizontal,
                            minimum: 0.0,
                            maximum: 100.0,
                            showTicks: false,
                            showLabels: false,
                            animateAxis: true,
                            axisTrackStyle: LinearAxisTrackStyle(
                            thickness: 10,
                            edgeStyle: LinearEdgeStyle.bothCurve,
                            borderWidth: 1,
                            borderColor: Colors.grey[350],
                            color: Colors.grey[350],),
                            barPointers: const <LinearBarPointer>[
                              LinearBarPointer(
                                value: 41.467,
                                thickness: 10,
                                edgeStyle: LinearEdgeStyle.bothCurve,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: FText(text: "25 GB free of 50 GB", fontSize: 0.01, style: TextStyle(color: AppColors.minorTextColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 4),
                  child: Icon( 
                    Icons.storage,
                    color: AppColors.highLightColor,
                    size: AppColors.getFontSize(devWidth, 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FText(text: "Swap", fontSize: 0.012, style: TextStyle(color: AppColors.minorTextColor)),
                      ),
                      SfLinearGauge(
                        orientation: LinearGaugeOrientation.horizontal,
                        minimum: 0.0,
                        maximum: 100.0,
                        showTicks: false,
                        showLabels: false,
                        animateAxis: true,
                        axisTrackStyle: LinearAxisTrackStyle(
                        thickness: 10,
                        edgeStyle: LinearEdgeStyle.bothCurve,
                        borderWidth: 1,
                        borderColor: Colors.grey[350],
                        color: Colors.grey[350],),
                        barPointers: const <LinearBarPointer>[
                          LinearBarPointer(
                            value: 41.467,
                            thickness: 10,
                            edgeStyle: LinearEdgeStyle.bothCurve,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FText(text: "2 GB free of 2 GB", fontSize: 0.01, style: TextStyle(color: AppColors.minorTextColor)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}