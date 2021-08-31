import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:fileryapp/services/auth_service.dart';
import 'package:fileryapp/views/components/customButton.dart';
import 'package:fileryapp/views/components/textField.dart';
import 'package:fileryapp/views/components/filery_text.dart';
import 'package:flutter/material.dart';
import 'package:fileryapp/utils/appColors.dart';
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
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
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
                  color: AppColors.backgroundColor,
                  shadows: [
                    AppColors.normalShadow,
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
                        Icon(Icons.file_download, color: AppColors.highLightColor, size: AppColors.getFontSize(devWidth, 0.08),),
                        SizedBox(
                          width: 20,
                        ),
                        FText(
                          text: "Filery",
                          fontSize: 0.06,
                          style: TextStyle(
                            color: AppColors.highLightColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4 
                          ),
                        ),
                      ],
                    ),
                    FText(
                      text: "Create Admin Account",
                      fontSize: 0.03,
                      style: TextStyle(
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    FText(
                      text: "Name",
                      fontSize: 0.015,
                      style: TextStyle(
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    BeautyTextfield(
                      height: 50,
                      width: 400,
                      textEditingController: fullNameEditingController,
                      backgroundColor: Colors.transparent,
                      backgroundFocusColor: Colors.white.withOpacity(0.1),
                      icon: Icon(Icons.person, color: AppColors.minorTextColor, size: AppColors.getFontSize(devWidth, 0.015),),
                      focusIcon: Icon(Icons.person, color: AppColors.mainTextColor, size: AppColors.getFontSize(devWidth, 0.015),),
                      textStyle: TextStyle(
                        fontSize: AppColors.getFontSize(devWidth, 0.015),
                        color: AppColors.mainTextColor,
                      ),
                      hintText: "Enter your name",
                      hintTextStyle: TextStyle(
                        fontSize: AppColors.getFontSize(devWidth, 0.015),
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
                    FText(
                      text: "Username",
                      fontSize: 0.015,
                      style: TextStyle(
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    BeautyTextfield(
                      height: 50,
                      width: 400,
                      textEditingController: usernameEditingController,
                      backgroundColor: Colors.transparent,
                      backgroundFocusColor: Colors.white.withOpacity(0.1),
                      icon: Icon(Icons.person, color: AppColors.minorTextColor, size: AppColors.getFontSize(devWidth, 0.015),),
                      focusIcon: Icon(Icons.person, color: AppColors.mainTextColor, size: AppColors.getFontSize(devWidth, 0.015),),
                      textStyle: TextStyle(
                        fontSize: AppColors.getFontSize(devWidth, 0.015),
                        color: AppColors.mainTextColor,
                      ),
                      hintText: "Enter new username",
                      hintTextStyle: TextStyle(
                        fontSize: AppColors.getFontSize(devWidth, 0.015),
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
                    FText(
                      text: "Password",
                      fontSize: 0.015,
                      style: TextStyle(
                        color: AppColors.minorTextColor,
                      ),
                    ),
                    BeautyTextfield(
                      height: 50,
                      width: 400,
                      textEditingController: passwordEditingController,
                      backgroundColor: Colors.transparent,
                      backgroundFocusColor: Colors.white.withOpacity(0.1),
                      icon: Icon(Icons.password, color: AppColors.minorTextColor, size: AppColors.getFontSize(devWidth, 0.015),),
                      focusIcon: Icon(Icons.password, color: AppColors.mainTextColor, size: AppColors.getFontSize(devWidth, 0.015),),
                      textStyle: TextStyle(
                        fontSize: AppColors.getFontSize(devWidth, 0.015),
                        color: AppColors.mainTextColor,
                      ),
                      obscureText: true,
                      hintText: "Enter new password",
                      hintTextStyle: TextStyle(
                        fontSize: AppColors.getFontSize(devWidth, 0.015),
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
                    errorText.isNotEmpty ? Flexible(
                      child: FText(
                        text: errorText,
                        fontSize: 0.015,
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 6,
                          color: Colors.red,
                        ),
                      ),
                    ) : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButtonWidget(
                      width: 400,
                      buttonText: "Sign Up",
                      textSize: AppColors.getFontSize(devWidth, 0.015),
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