import 'package:flutter/material.dart';

import 'package:fileryapp/utils/appColors.dart';

class DrawerButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final int indexValue;
  final int selectedValue;
  final ValueChanged<int> onTap;


  const DrawerButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.indexValue,
    required this.selectedValue,
    required this.onTap,
  }) : super(key: key);

  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.indexValue);
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovered = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          alignment: Alignment.centerLeft,
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.backgroundColor : AppColors.lightBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppColors.minorTextColor, size: 16,),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.minorTextColor,
                  fontWeight: widget.indexValue == widget.selectedValue ? FontWeight.bold : FontWeight.normal,
                  letterSpacing: 2
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}