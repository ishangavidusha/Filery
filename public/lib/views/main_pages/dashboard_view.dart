import 'package:fileryapp/services/sysinfo_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({ Key? key }) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text("Dashboard"),
            Text(context.watch<SysInfoService>().sysData.toString())
          ],
        ),
      ),
    );
  }
}