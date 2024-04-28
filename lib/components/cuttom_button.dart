import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key, required this.text,required this.press,required this.screenHeight,
    required this.screenWidth,required this.buttonColor,
  }) : super(key: key);
  final String text;
  final VoidCallback? press;
  final double screenHeight;
  final double screenWidth;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.6,
      height: screenHeight * 0.07,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        onPressed: press,
        child: Text(text,
          style: TextStyle(
              fontSize: screenWidth* 0.06,
              color: Colors.white,
          ),
         textDirection: TextDirection.rtl,),
        color: buttonColor,),
    );
  }
}