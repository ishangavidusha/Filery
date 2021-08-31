import 'package:flutter/material.dart';

class FText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  const FText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.style,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: devWidth < 800 ? 800 * fontSize : devWidth > 1200 ? 1200 * fontSize : devWidth * fontSize,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 8),
            blurRadius: 200 * fontSize,
          ),
        ]
      ).copyWith(
        color: style.color,
        letterSpacing: style.letterSpacing,
        fontWeight: style.fontWeight
      ),
    );
  }
}
