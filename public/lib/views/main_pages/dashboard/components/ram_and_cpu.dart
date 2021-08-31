import 'package:fileryapp/models/system_infomation.dart';
import 'package:fileryapp/services/sysinfo_service.dart';
import 'package:fileryapp/utils/appColors.dart';
import 'package:fileryapp/views/components/filery_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RamAndCpuLayoutBuilder extends StatelessWidget {
  RamAndCpuLayoutBuilder({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 800) {
          return ramAndCpuMobile(context);
        } else if (constraints.maxWidth <= 1200) {
          return ramAndCpuTablet(context);
        } else {
          return ramAndCpuDesktop(context);
        }
      },
    );
  }

  Widget ramAndCpuMobile(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        getRamSection(context, Size(devWidth, 220)),
        getCpuSection(context, Size(devWidth, 220)),
      ],
    );
  }

  Widget ramAndCpuTablet(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        getRamSection(context, Size((devWidth - 260) * 0.6, 220)),
        getCpuSection(context, Size((devWidth - 260) * 0.4, 220)),
      ],
    );
  }

  Widget ramAndCpuDesktop(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        getRamSection(context, Size((devWidth - 260) * 0.65, devWidth * 0.15)),
        getCpuSection(context, Size((devWidth - 260) * 0.34, devWidth * 0.15)),
      ],
    );
  }

  Widget getRamSection(BuildContext context, Size size) {
    double devWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: size.width,
          child: Row(
            children: [
              FText(
                text: "RAM Usage",
                fontSize: 0.015,
                style: TextStyle(
                  color: AppColors.minorTextColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2 
                ),
              ),
              Spacer(),
              FText(
                text: context.watch<SysInfoService>().currentRamUsageString,
                fontSize: 0.01,
                style: TextStyle(
                  color: Color(0xff68737d).withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: size.height,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  switch (value.toInt()) {
                    case 20:
                    case 40:
                    case 60:
                    case 80:
                    case 100:
                      return FlLine(
                        color: const Color(0xff37434d).withOpacity(0.1),
                        strokeWidth: 1,
                      );
                    default:
                      return FlLine(
                        color: Colors.transparent,
                        strokeWidth: 1,
                      );
                  }
                  
                },
                getDrawingVerticalLine: (value) {
                  if (value.floor().isEven) {
                    return FlLine(
                      color: const Color(0xff37434d).withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  } else {
                    return FlLine(
                        color: Colors.transparent,
                      strokeWidth: 1,
                    );
                  }
                  
                }
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTextStyles: (value) => TextStyle(color: Color(0xff68737d), fontSize: AppColors.getFontSize(devWidth, 0.01)),
                  getTitles: (value) {
                    if (value == 0) {
                      return "60 seconds";
                    } else if (value == 2) {
                      return "";
                    } else if (value.floor().isEven) {
                      return (60 - value).toString();
                    } else {
                      return "";
                    }
                  },
                  margin: 8,
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => TextStyle(color: Color(0xff67727d), fontSize: AppColors.getFontSize(devWidth, 0.01)),
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 20:
                        return '20%';
                      case 40:
                        return '40%';
                      case 60:
                        return '60%';
                      case 80:
                        return '80%';
                      case 100:
                        return '100%';
                    }
                    return '';
                  },
                  reservedSize: 28,
                  margin: 12,
                ),
              ),
              borderData: FlBorderData(show: true, border: Border(
                bottom: BorderSide(color: const Color(0xff37434d).withOpacity(0.1), width: 1),
                left: BorderSide(color: const Color(0xff37434d).withOpacity(0.1), width: 1),
              )),
              minX: 0,
              maxX: 60,
              minY: 0,
              maxY: 110,
              clipData: FlClipData.all(),
              lineTouchData: LineTouchData(enabled: false),
              lineBarsData: [
                LineChartBarData(
                  spots: context.watch<SysInfoService>().ramUsage.asMap().entries.map((e) {
                    SystemInfomationInfoVirtualMemory memory = e.value;
                    int used = memory.used ?? 0;
                    int total = memory.total ?? 0;
                    double percentage = (used/total) * 100;
                    return FlSpot(e.key.toDouble(), percentage.isNaN ? 0.0 : percentage);
                  }).toList(),
                  isCurved: false,
                  colors: AppColors.buttonGradeantColors,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    colors: AppColors.buttonGradeantColors.map((color) => color.withOpacity(0.3)).toList(),
                  ),
                ),
              ],
            ),
            swapAnimationDuration: Duration(milliseconds: 10),
            swapAnimationCurve: Curves.easeIn,
          ),
        ),
      ],
    );
  }

  Widget getCpuSection(BuildContext context, Size size) {
    double devWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: size.width,
          padding: EdgeInsets.only(left: devWidth > 800 ? 20 : 0),
          child: FText(
            text: "CPU Utillization",
            fontSize: 0.015,
            style: TextStyle(
              color: AppColors.minorTextColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 2 
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: size.height,
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1000,
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                labelOffset: 15,
                axisLineStyle: AxisLineStyle(thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
                radiusFactor: 0.9,
                showTicks: true,
                axisLabelStyle: const GaugeTextStyle(fontSize: 12),
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 100, gradient: SweepGradient(colors: AppColors.buttonGradeantColors),),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    enableAnimation: true,
                    gradient: LinearGradient(
                      colors: AppColors.buttonGradeantColors, 
                      stops: <double>[
                        0.25,
                        0.75
                      ], 
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    ),
                    animationType: AnimationType.ease,
                    value: context.watch<SysInfoService>().getCpuLoad(),
                    lengthUnit: GaugeSizeUnit.factor,
                    animationDuration: 1300,
                    needleLength: 0.8,
                    needleStartWidth: 1,
                    needleEndWidth: 5,
                    knobStyle: KnobStyle(
                      knobRadius: 0.08,
                      color: AppColors.buttonGradeantColors.last,
                    ),
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Container(
                      child: Text(
                        context.watch<SysInfoService>().getCpuLoad().toString() + "%",
                        style: TextStyle(color: Color(0xff67727d), fontSize: AppColors.getFontSize(devWidth, 0.01)),
                      )
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  )
                ]
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class RamAndCpu extends StatefulWidget {
//   const RamAndCpu({ Key? key }) : super(key: key);

//   @override
//   _RamAndCpuState createState() => _RamAndCpuState();
// }

// class _RamAndCpuState extends State<RamAndCpu> {
//   @override
//   Widget build(BuildContext context) {
//     double devWidth = MediaQuery.of(context).size.width;
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               width: devWidth * 0.5,
//               child: Row(
//                 children: [
//                   FText(
//                     text: "RAM Usage",
//                     fontSize: 0.015,
//                     style: TextStyle(
//                       color: AppColors.minorTextColor,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2 
//                     ),
//                   ),
//                   Spacer(),
//                   FText(
//                     text: context.watch<SysInfoService>().currentRamUsageString,
//                     fontSize: 0.01,
//                     style: TextStyle(
//                       color: Color(0xff68737d).withOpacity(0.6),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: FText(
//                 text: "CPU Utillization",
//                 fontSize: 0.015,
//                 style: TextStyle(
//                   color: AppColors.minorTextColor,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2 
//                 ),
//               ),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           children: [
//             Container(
//               height: devWidth * 0.15,
//               width: devWidth * 0.5,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: true,
//                     getDrawingHorizontalLine: (value) {
//                       switch (value.toInt()) {
//                         case 20:
//                         case 40:
//                         case 60:
//                         case 80:
//                         case 100:
//                           return FlLine(
//                             color: const Color(0xff37434d).withOpacity(0.1),
//                             strokeWidth: 1,
//                           );
//                         default:
//                           return FlLine(
//                             color: Colors.transparent,
//                             strokeWidth: 1,
//                           );
//                       }
                      
//                     },
//                     getDrawingVerticalLine: (value) {
//                       if (value.floor().isEven) {
//                         return FlLine(
//                           color: const Color(0xff37434d).withOpacity(0.1),
//                           strokeWidth: 1,
//                         );
//                       } else {
//                         return FlLine(
//                             color: Colors.transparent,
//                           strokeWidth: 1,
//                         );
//                       }
                      
//                     }
//                   ),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     bottomTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 22,
//                       getTextStyles: (value) => TextStyle(color: Color(0xff68737d), fontSize: AppColors.getFontSize(devWidth, 0.01)),
//                       getTitles: (value) {
//                         if (value == 0) {
//                           return "60 seconds";
//                         } else if (value == 2) {
//                           return "";
//                         } else if (value.floor().isEven) {
//                           return (60 - value).toString();
//                         } else {
//                           return "";
//                         }
//                       },
//                       margin: 8,
//                     ),
//                     leftTitles: SideTitles(
//                       showTitles: true,
//                       getTextStyles: (value) => TextStyle(color: Color(0xff67727d), fontSize: AppColors.getFontSize(devWidth, 0.01)),
//                       getTitles: (value) {
//                         switch (value.toInt()) {
//                           case 20:
//                             return '20%';
//                           case 40:
//                             return '40%';
//                           case 60:
//                             return '60%';
//                           case 80:
//                             return '80%';
//                           case 100:
//                             return '100%';
//                         }
//                         return '';
//                       },
//                       reservedSize: 28,
//                       margin: 12,
//                     ),
//                   ),
//                   borderData: FlBorderData(show: true, border: Border(
//                     bottom: BorderSide(color: const Color(0xff37434d).withOpacity(0.1), width: 1),
//                     left: BorderSide(color: const Color(0xff37434d).withOpacity(0.1), width: 1),
//                   )),
//                   minX: 0,
//                   maxX: 60,
//                   minY: 0,
//                   maxY: 110,
//                   clipData: FlClipData.all(),
//                   lineTouchData: LineTouchData(enabled: false),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: context.watch<SysInfoService>().ramUsage.asMap().entries.map((e) {
//                         SystemInfomationInfoVirtualMemory memory = e.value;
//                         int used = memory.used ?? 0;
//                         int total = memory.total ?? 0;
//                         double percentage = (used/total) * 100;
//                         return FlSpot(e.key.toDouble(), percentage.isNaN ? 0.0 : percentage);
//                       }).toList(),
//                       isCurved: false,
//                       colors: AppColors.buttonGradeantColors,
//                       barWidth: 2,
//                       isStrokeCapRound: true,
//                       dotData: FlDotData(
//                         show: false,
//                       ),
//                       belowBarData: BarAreaData(
//                         show: true,
//                         colors: AppColors.buttonGradeantColors.map((color) => color.withOpacity(0.3)).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//                 swapAnimationDuration: Duration(milliseconds: 10),
//                 swapAnimationCurve: Curves.easeIn,
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Container(
//                 height: devWidth * 0.15,
//                 child: SfRadialGauge(
//                   enableLoadingAnimation: true,
//                   animationDuration: 1000,
//                   axes: <RadialAxis>[
//                     RadialAxis(
//                       minimum: 0,
//                       maximum: 100,
//                       labelOffset: 15,
//                       axisLineStyle: AxisLineStyle(thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
//                       radiusFactor: 0.9,
//                       showTicks: true,
//                       axisLabelStyle: const GaugeTextStyle(fontSize: 12),
//                       ranges: <GaugeRange>[
//                         GaugeRange(startValue: 0, endValue: 100, gradient: SweepGradient(colors: AppColors.buttonGradeantColors),),
//                       ],
//                       pointers: <GaugePointer>[
//                         NeedlePointer(
//                           enableAnimation: true,
//                           gradient: LinearGradient(
//                             colors: AppColors.buttonGradeantColors, 
//                             stops: <double>[
//                               0.25,
//                               0.75
//                             ], 
//                             begin: Alignment.topCenter, end: Alignment.bottomCenter,
//                           ),
//                           animationType: AnimationType.ease,
//                           value: context.watch<SysInfoService>().getCpuLoad(),
//                           lengthUnit: GaugeSizeUnit.factor,
//                           animationDuration: 1300,
//                           needleLength: 0.8,
//                           needleStartWidth: 1,
//                           needleEndWidth: 5,
//                           knobStyle: KnobStyle(
//                             knobRadius: 0.08,
//                             color: AppColors.buttonGradeantColors.last,
//                           ),
//                         ),
//                       ],
//                       annotations: <GaugeAnnotation>[
//                         GaugeAnnotation(
//                           widget: Container(
//                             child: Text(
//                               context.watch<SysInfoService>().getCpuLoad().toString() + "%",
//                               style: TextStyle(color: Color(0xff67727d), fontSize: AppColors.getFontSize(devWidth, 0.01)),
//                             )
//                           ),
//                           angle: 90,
//                           positionFactor: 0.5,
//                         )
//                       ]
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }