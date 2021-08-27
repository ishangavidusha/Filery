import 'package:fileryapp/services/auth_service.dart';
import 'package:fileryapp/utils/appColors.dart';
import 'package:fileryapp/utils/filery_log.dart';
import 'package:fileryapp/views/auth/init_admin.dart';
import 'package:fileryapp/views/auth/login_view.dart';
import 'package:fileryapp/views/components/filery_text.dart';
import 'package:fileryapp/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({ Key? key }) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String errorText = "";

  Future<bool?> checkLogin() async {
    FileryLog.v("Checking Login Session...");
    setState(() {
      errorText = "";
    });
    try{
      await Future.delayed(Duration(milliseconds: 200));
      await Provider.of<AuthService>(context, listen: false).getLoginSession();
      return true;
    } catch (e) {
      setState(() {
        errorText = e.toString();
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: checkLogin(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Stack(
              children: [
                Positioned(
                  bottom: devHeight * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.buttonGradeantColors.first),
                        color: AppColors.buttonGradeantColors.first,
                        backgroundColor: AppColors.backgroundColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Stack(
              children: [
                Positioned(
                  bottom: devHeight * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Flexible(
                        child: FText( 
                          text: errorText,
                          maxLines: 2,
                          fontSize: 0.015,
                          textOverflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.minorTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          if (context.watch<AuthService>().session != null) {
            return HomeView();
          } else {
            if (context.watch<AuthService>().showRegister) {
              return InitAdminView();
            } else {
              return LoginView();
            }
          }
        }
      },
    );
  }
}