import 'package:fileryapp/utils/appColors.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final Function onpressed;
  final bool isLoading;
  final double textSize;
  final List<Color> gradienteColors;
  final Color progressColor;

  RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.width,
    required this.onpressed,
    this.isLoading = false,
    required this.textSize,
    required this.gradienteColors,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: AppColors.buttonGradeantColors.first.withOpacity(0.4), offset: Offset(0, 4), blurRadius: 8.0,),
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: [0.0, 1.0],
          colors: gradienteColors,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, 60)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          onpressed();
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: !isLoading ? Text(
            buttonText,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ) : CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            color: progressColor,
            backgroundColor: gradienteColors.first,
          ),
        ),
      ),
    );
  }
}
