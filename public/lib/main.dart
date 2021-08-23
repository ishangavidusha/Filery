import 'package:fileryapp/services/api_service.dart';
import 'package:fileryapp/services/auth_service.dart';
import 'package:fileryapp/services/sysinfo_service.dart';
import 'package:fileryapp/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        print("Base URL : ${Uri.base.origin}");
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => AuthService(),
            ),
            ChangeNotifierProvider(
              create: (_) => ApiService(),
            ),
            ChangeNotifierProvider(
              create: (_) => SysInfoService(),
            ),
          ],
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'Filery',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                ),
              ),
              home: SplashView(),
            );
          }
        );
      }
    );
  }
}