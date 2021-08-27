

import 'package:flutter/material.dart';

class BeautyTextfield extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final Color borderFocusColor;
  final Color backgroundColor;
  final Color backgroundFocusColor;
  final Icon icon; 
  final Icon focusIcon;
  final bool obscureText;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final String hintText;
  final GestureTapCallback onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController textEditingController;

  const BeautyTextfield({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 10,
    this.borderColor = Colors.grey,
    this.borderFocusColor = Colors.blueGrey,
    required this.backgroundColor,
    required this.backgroundFocusColor,
    required this.icon,
    required this.focusIcon,
    this.obscureText = false,
    required this.textStyle,
    required this.hintTextStyle,
    required this.hintText,
    required this.onTap,
    required this.onChanged,
    required this.onSubmitted,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _BeautyTextfieldState createState() => _BeautyTextfieldState();
}

class _BeautyTextfieldState extends State<BeautyTextfield> {
  FocusNode _focusNode = FocusNode();
  bool isFocus = false;

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        isFocus = true;
      });
    } else {
      setState(() {
        isFocus = false;
      });
    }
  }

  @override
  void initState() { 
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: isFocus ? widget.borderFocusColor : widget.borderColor,
        )
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: isFocus ? widget.width : widget.width * 0.15,
              height: widget.height,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: isFocus ? widget.backgroundFocusColor : widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            height: widget.height,
            width: widget.width * 0.2,
            child: Center(
              child: isFocus ? widget.focusIcon : widget.icon,
            ),
          ),
          Positioned(
            left: widget.width * 0.2,
            height: widget.height,
            right: 0,
            child: TextField(
              controller: widget.textEditingController,
              focusNode: _focusNode,
              style: widget.textStyle,
              obscureText: widget.obscureText,
              cursorColor: widget.borderFocusColor,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: widget.hintTextStyle,
                border: InputBorder.none,
              ),
              onTap: () {
                widget.onTap();
              },
              onChanged: (t) {
                widget.onChanged(t);
              },
              onSubmitted: (t) {
                widget.onSubmitted(t);
              },
            ),
          ),
        ],
      ),
    );
  }
}