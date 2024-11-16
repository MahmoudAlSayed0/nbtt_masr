import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoRow extends StatelessWidget {
  const LogoRow({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
/*        SvgPicture.asset("assets/icons/nbttmsrLogo2.svg",
          height: screenHeight*0.17,),*/
        Image.asset("assets/images/nbttMasrLogo2.png",height: screenHeight*0.12,)
      ],);
  }
}