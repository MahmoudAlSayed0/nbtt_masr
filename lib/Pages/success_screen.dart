import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/helpers/constants.dart';

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    var pageWidth = MediaQuery.of(context).size.width;
 /*   Timer(
        Duration(seconds: 1),
            () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StartPage(),))
    );*/
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assets/images/Group 22.svg",
            height: pageHeight*0.4,width: pageWidth,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('لقد تم الارسال بنجاح',style: TextStyle(
                  color: kRedColor,
                  fontSize: 35,
                  fontWeight: FontWeight.w900
              ),),

            ],
          ),
          Container(
            height: pageHeight * 0.22,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: pageWidth * 0.6,
                      height: pageHeight * 0.07,
                      child: FlatButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage(firstTime: false,))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.arrow_back,color: Colors.white,size: 40,),
                            SizedBox(width: 5,),
                            Text("الرئيسية",style: TextStyle(color: Colors.white,fontSize: 30,
                                fontWeight: FontWeight.bold),),
                          ],
                        ),

                      ),
                      decoration: BoxDecoration(
                        gradient: kGradientColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ],
                ),
                /*     SizedBox(height: screenHeight*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      InkWell(
                        child: Text("الدخول لحسابى",style: TextStyle(
                          fontSize: 20,color: kGreenColor,
                        ),),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage())),
                      ),
                      SizedBox(width: 20,),
                      Icon(Icons.person_rounded,color: kGreenColor,size: 25,)
                    ],)
                  ],
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
