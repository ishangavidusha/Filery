import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:fileryapp/services/auth_service.dart';
import 'package:fileryapp/utils/customButton.dart';
import 'package:fileryapp/utils/textField.dart';
import 'package:flutter/material.dart';
import 'package:fileryapp/utils/appColors.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class InitAdminView extends StatefulWidget {
  const InitAdminView({ Key? key }) : super(key: key);

  @override
  _InitAdminViewState createState() => _InitAdminViewState();
}

class _InitAdminViewState extends State<InitAdminView> {
  late TextEditingController usernameEditingController;
  late TextEditingController passwordEditingController;
  late TextEditingController fullNameEditingController;
  String errorText = "";
  bool isLoading = false;

  @override
  void initState() { 
    super.initState();
    usernameEditingController = TextEditingController(text: "");
    passwordEditingController = TextEditingController(text: "");
    fullNameEditingController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    usernameEditingController.dispose();
    passwordEditingController.dispose();
    fullNameEditingController.dispose();
    super.dispose();
  }

  void register() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      isLoading = true;
      errorText = "";
    });
    if (usernameEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty && fullNameEditingController.text.isNotEmpty) {
      // Create Admin
      Map<String, dynamic> data = await context.read<AuthService>().initAdmin(fullNameEditingController.text, usernameEditingController.text, passwordEditingController.text);
      if (!data["success"]) {
        setState(() {
          errorText = data["msg"];
        });
      }

    } else {
      setState(() {
        errorText = "Name, Username or Password can't be empty!";
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                decoration: ShapeDecoration(
                  shape: SquircleBorder(
                    radius: BorderRadius.circular(80),
                  ),
                  gradient: LinearGradient(
                    colors: AppColors.cardGradeantColors,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  ),
                  shadows: [
                    AppColors.boxShadow,
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.file_download, color: AppColors.mainTextColor, size: 16.sp,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Filery",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4 
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Create Admin Account",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    BeautyTextfield(
                      height: 50,
                      width: 400,
                      textEditingController: fullNameEditingController,
                      backgroundColor: Colors.transparent,
                      backgroundFocusColor: Colors.white.withOpacity(0.1),
                      icon: Icon(Icons.person, color: AppColors.minorTextColor, size: 10.sp,),
                      focusIcon: Icon(Icons.person, color: AppColors.mainTextColor, size: 12.sp,),
                      textStyle: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.mainTextColor,
                      ),
                      hintText: "Enter your name",
                      hintTextStyle: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.minorTextColor,
                      ),
                      onTap: () {
                        setState(() {
                          errorText = "";
                        });
                      },
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    BeautyTextfield(
                      height: 50,
                      width: 400,
                      textEditingController: usernameEditingController,
                      backgroundColor: Colors.transparent,
                      backgroundFocusColor: Colors.white.withOpacity(0.1),
                      icon: Icon(Icons.person, color: AppColors.minorTextColor, size: 10.sp,),
                      focusIcon: Icon(Icons.person, color: AppColors.mainTextColor, size: 12.sp,),
                      textStyle: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.mainTextColor,
                      ),
                      hintText: "Enter new username",
                      hintTextStyle: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.minorTextColor,
                      ),
                      onTap: () {
                        setState(() {
                          errorText = "";
                        });
                      },
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    BeautyTextfield(
                      height: 50,
                      width: 400,
                      textEditingController: passwordEditingController,
                      backgroundColor: Colors.transparent,
                      backgroundFocusColor: Colors.white.withOpacity(0.1),
                      icon: Icon(Icons.password, color: AppColors.minorTextColor, size: 10.sp,),
                      focusIcon: Icon(Icons.password, color: AppColors.mainTextColor, size: 12.sp,),
                      textStyle: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.mainTextColor,
                      ),
                      obscureText: true,
                      hintText: "Enter new password",
                      hintTextStyle: TextStyle(
                        fontSize: 6.sp,
                        color: AppColors.minorTextColor,
                      ),
                      onTap: () {
                        setState(() {
                          errorText = "";
                        });
                      },
                      onChanged: (value) {},
                      onSubmitted: (value) {
                        register();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    errorText.isNotEmpty ? Text(
                      errorText,
                      style: TextStyle(
                        fontSize: 6.sp,
                        color: Colors.red,
                      ),
                    ) : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButtonWidget(
                      width: 400,
                      buttonText: "Sign Up",
                      textSize: 6.sp,
                      onpressed: () async {
                        register();
                      },
                      progressColor: AppColors.mainTextColor,
                      gradienteColors: AppColors.buttonGradeantColors,
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}