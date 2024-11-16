import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/logoRow.dart';
import 'components/mainDrawer.dart';

class ContactUs extends StatefulWidget {

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  _launchYouTube() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'https://www.youtube.com/channel/UC0Q-bhJZ4Dr0SfmEx_HOXcQ/featured?view_as=subscriber')) {
        await launch(
            'https://www.youtube.com/channel/UC0Q-bhJZ4Dr0SfmEx_HOXcQ/featured?view_as=subscriber',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/channel/UC0Q-bhJZ4Dr0SfmEx_HOXcQ/featured?view_as=subscriber')) {
          await launch(
              'https://www.youtube.com/channel/UC0Q-bhJZ4Dr0SfmEx_HOXcQ/featured?view_as=subscriber');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      const url = 'https://www.youtube.com/channel/UC0Q-bhJZ4Dr0SfmEx_HOXcQ/featured?view_as=subscriber';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _launchFacebook() async {

   /* try {
      bool launched =
      await launch('https://www.facebook.com/NCCMEgypt/', forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch('https://www.facebook.com/NCCMEgypt/', forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch('https://www.facebook.com/NCCMEgypt/', forceSafariVC: false, forceWebView: false);
    }*/

    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/110005449172244';
    } else {
      fbProtocolUrl = 'fb://page/110005449172244';
    }

    String fallbackUrl = 'https://www.facebook.com/NCCMEgypt/';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
    /*if (Platform.isIOS) {
      if (await canLaunch(
          'https://www.facebook.com/NCCMEgypt/')) {
        await launch(
            'https://www.facebook.com/NCCMEgypt/',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.facebook.com/NCCMEgypt/')) {
          await launch(
              'https://www.facebook.com/NCCMEgypt/');
        } else {
          throw 'Could not launch https://www.facebook.com/NCCMEgypt/';
        }
      }
    } else {
      const url = 'https://www.facebook.com/NCCMEgypt/';
      if (await canLaunch(url)) {
        await launch(url,forceWebView: false);
      } else {
        throw 'Could not launch $url';
      }
    }*/
  }

  /*_launchFacebook() async {
    const url = 'https://www.facebook.com/NCCMEgypt/';
    if (await canLaunch(url)) {
      await launch(url,
        forceSafariVC: false,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  /*_launchYouTube() async {
    const url = 'https://www.youtube.com/channel/UC0Q-bhJZ4Dr0SfmEx_HOXcQ/featured?view_as=subscriber';
    if (await canLaunch(url)) {
      await launch(url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  _launchTwitter() async {
    const url = 'https://twitter.com/NCCMEgypt';
    if (await canLaunch(url)) {
      await launch(url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@nccm.gov.eg',
      queryParameters: {
        'subject': 'نبتة مصر'
      }
  );

  String _phone1 = '0225240288';

  String _phone2 = '0225240408';

  String _phone3 = '16000' ;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer:  MainDrawer(screenHeight: screenHeight, screenWidth: screenWidth) ,
      bottomNavigationBar: Container(
        height: screenHeight*0.1,
        decoration: BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, -10),
                  blurRadius: 20,
                  color: Color(0xFFDADADA)//.withOpacity(0.15)
              )
            ]
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               /* Container(
                  //margin: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Icon(Icons.person_outline,size: 30,)
                ),*/
                Transform.translate(
                  offset: Offset(0.0, -screenHeight * 0.04),
                  child: Container(
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.12,
                      //margin: EdgeInsets.only(bottom: screenHeight *0.04),
                      decoration: BoxDecoration(
                        color: kRedColor,
                        shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 20.0),
                                blurRadius: 20,
                                color: kTextColor
                            )
                          ]
                        // borderRadius: BorderRadius.circular(screenWidth * 0.14),
                      ),
                      child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage(),))
                          ,icon: Icon(Icons.home_outlined,size: 35,color: Colors.white,)
                      )),
                ),
                /*Container(
                  //margin: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Icon(Icons.notifications_outlined,size: 30,)
                )*/
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage(firstTime: false,))),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogoRow(screenHeight: screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('اتصل بنا',style: TextStyle(
                  color: kTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
            Container(
              color: Color(0xFFF8F8FF),
              height: screenHeight * 0.65,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight *0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: screenHeight*0.04),
                                child: Row(
                                  children: [
                                    Text('المجلس القومي للطفوله والأمومه',style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: screenHeight * 0.15,
                                    width: screenWidth * 0.6,
                                    child: Text('أول كورنيش المعادي – القاهرة – مصر ص.ب 11 مصر القديمة',
                                      style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                    maxLines: 2,
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),
                        Image.asset("assets/images/0-45.png",height: screenHeight*0.17,width: screenWidth * 0.25,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.08,bottom: screenHeight * 0.02,
                        left: screenWidth*0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text('0225240288',style: TextStyle(
                              fontSize: 18,color: kTextColor
                          ),   textAlign: TextAlign.right,),
                          onTap: () => _makePhoneCall('tel:$_phone1'),
                        ),
                        SizedBox(width: screenWidth * 0.007,),
                        Text('-',style: TextStyle(
                            fontSize: 18,color: kTextColor
                        ),   textAlign: TextAlign.right,),
                        SizedBox(width: screenWidth * 0.007,),
                        InkWell(
                          child: Text('0225240408',style: TextStyle(
                              fontSize: 18,color: kTextColor
                          ),   textAlign: TextAlign.right,),
                          onTap: () => _makePhoneCall('tel:$_phone2'),
                        ),
                        SizedBox(width: screenWidth * 0.15,),
                        Text('تليفون',style: TextStyle(
                          fontSize: 20,color: kTextColor,
                        ),   textAlign: TextAlign.right, textDirection: TextDirection.rtl,),
                        SizedBox(width: screenWidth * 0.007,),
                        Icon(
                          Icons.call,size: 25,color: kTextColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.08,bottom: screenHeight * 0.02,
                        left: screenWidth*0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('0225240638',style: TextStyle(
                            fontSize: 18,color: kTextColor
                        ),   textAlign: TextAlign.right,),
                        SizedBox(width: screenWidth * 0.007,),
                        Text('-',style: TextStyle(
                            fontSize: 18,color: kTextColor
                        ),   textAlign: TextAlign.right,),
                        SizedBox(width: screenWidth * 0.007,),
                        Text('0225240122',style: TextStyle(
                            fontSize: 18,color: kTextColor
                        ),   textAlign: TextAlign.right,),
                        SizedBox(width: screenWidth * 0.17,),
                        Text('فاكس',style: TextStyle(
                          fontSize: 20,color: kTextColor,
                        ),   textAlign: TextAlign.right,),
                        SizedBox(width: screenWidth * 0.007,),
                        Icon(
                          Icons.local_printshop_outlined,size: 25,color: kTextColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.08,bottom: screenHeight * 0.02,
                    left: screenWidth*0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text('info@nccm.gov.eg',style: TextStyle(
                              fontSize: 18,color: kTextColor
                          ),   textAlign: TextAlign.right,),
                          onTap: () => launch(_emailLaunchUri.toString()),
                        ),
                        SizedBox(width: screenWidth * 0.12,),
                        Text('البريد الالكترونى',style: TextStyle(
                          fontSize: 20,color: kTextColor,
                        ),   textAlign: TextAlign.right,),
                        SizedBox(width: screenWidth * 0.007,),
                        Icon(
                          Icons.email,size: 25,color: kTextColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.08,top: screenHeight*0.02,
                        left: screenWidth*0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => _makePhoneCall('tel:$_phone3'),
                          child: Text('16000',style: TextStyle(
                            fontSize: 20,color: kRedColor,fontWeight: FontWeight.bold
                          ),   textAlign: TextAlign.right,),
                        ),
                        SizedBox(width: 6,),
                        Text('خط نجدة الطفل',style: TextStyle(
                          fontSize: 20,color: kRedColor,
                        ),   textAlign: TextAlign.right,),
                        SizedBox(width: 4,),
                        Icon(Icons.headset_mic,color: kRedColor,size: 25,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.08,top: screenHeight*0.02,
                        left: screenWidth*0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(icon: Icon(FontAwesomeIcons.facebookF,color: Color(0xFF4267B2),size: 25), onPressed: _launchFacebook),
                        SizedBox(width: screenWidth * 0.002,),
                        IconButton(icon: Icon(FontAwesomeIcons.twitter,color: Color(0xFF1DA1F2),size: 25),onPressed: _launchTwitter,),
                        SizedBox(width: screenWidth * 0.002,),
                        IconButton(icon: Icon(FontAwesomeIcons.youtube,color: kRedColor,size: 25,),onPressed: _launchYouTube,),
                        SizedBox(width: screenWidth * 0.04,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
