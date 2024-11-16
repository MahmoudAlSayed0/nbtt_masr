import 'package:flutter/material.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/logoRow.dart';
import 'components/mainDrawer.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final progtamsPragraph = '''
    البرنامج القومي لمناهضة ختان الإناث -
    البرنامج القومي لحماية النشء من المخدرات -
    برنامج مناهضة عمل الأطفال بمنطقة منشأة -
      ناصر
    برنامج مناهضة عمل الأطفال بمحافظات( المنيا -
      ( الفيوم – الشرقية – دمياط – القليوبية
    برنامج التنمية الاجتماعية والمجتمع المدني -
    أطفال في خطر
    برنامج صحة الأسرة ودعم خدمات الصحة -
      الإنجابية بالتعاون مع الهلال الأحمر المصري
    برنامج التوعية العامة للارتقاء بالبيئة في المنطقة  
      الشمالية بمحافظة القاهرة
    برنامج محو الأمية وتمكين البنات -
    برنامج تنمية الطفولة المبكرة -
    برنامج عدالة الأسرة -
    برنامج أفلاطون المصري -
    فكر مرتين برنامج الإعلام الاجتماعي -
    ''';

    final aboutUsPragraph = '''
    أنشئ المجلس فى عام 1988 بموجب القرار 
     الجمهوري رقم 54 لسنة 1988 ليصبح ركيزة
     أساسية للعناية بالطفولة والأمومة ممثلا كيان
     المجتمع ومستقبله، وقد عهد المشرع إلى
     المجلس مسؤولية وضع السياسات ، والتخطيط
     والتنسيق، والرصد والتقييم من أجل الأنشطة ذات
     الصلة بمجالات حماية الأطفال والأمهات وتطويرها
     فى مصر، وذلك من خلال التعاون مع عدد من
     المنظمات غير الحكومية، ويؤدى المجلس دورا
     رئيسيا فى المهام المتعلقة برسم السياسة
     الخاصة بالطفولة والرصد والتنسيق لصالح الأطفال
     .على المستويات الوطنية والمحلية
    ''';
    _launchHealthURL(url) async {
      //const url = 'http://shorturl.at/kqsFO';
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }
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
                /*Container(
                  //margin: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Icon(Icons.person_outline,size: 30,)
                ),*/
                Transform.translate(
                  offset: Offset(0.0, -screenHeight * 0.04),
                  child: Container(
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.12,
                     // margin: EdgeInsets.only(bottom: screenHeight *0.04),
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
                Text('نبذة عن المجلس',style: TextStyle(
                  color: kTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
            Container(
              //color: Color(0xFFF8F8FF),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('المجلس القومي للطفوله والأمومه',style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                      ),),
                      Image.asset("assets/images/0-45.png",height: screenHeight*0.12,),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.04,left: screenWidth * 0.06,bottom: screenWidth * 0.04),
                    child: Text('أنشئ المجلس فى عام 1988 بموجب القرار الجمهوري رقم 54 لسنة 1988 ليصبح ركيزة أساسية للعناية بالطفولة والأمومة ممثلا كيان المجتمع ومستقبله، وقد عهد المشرع إلى المجلس مسؤولية وضع السياسات ، والتخطيط والتنسيق، والرصد والتقييم من   أجل الأنشطة ذات الصلة بمجالات حماية الأطفال والأمهات وتطويرها فى مصر، وذلك من خلال التعاون مع عدد من المنظمات غير الحكومية، ويؤدى المجلس دورا رئيسيا فى المهام المتعلقة برسم السياسة الخاصة بالطفولة والرصد والتنسيق لصالح الأطفال .على المستويات الوطنية والمحلية',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 18,
                        height: 1.5
                      ),
                      textAlign: TextAlign.right,
                 /*     overflow: TextOverflow.ellipsis,
                      maxLines: 20,*/
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('البرامج السابقة',style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  ),
                 Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.04),
                    child: Text(progtamsPragraph,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 20,
                      ),
                    textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 20,
                    ),
                  ),
                /*  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Text('البرنامج القومي لمناهضة ختان الإناث',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 20,
                        ),
                        onTap: ()=> _launchHealthURL('http://nccm.acs-egypt.com/%D8%B5%D9%81%D8%AD%D8%A7%D8%AA-%D8%A7%D9%84%D9%85%D9%88%D9%82%D8%B9/%D8%A7%D9%84%D8%A8%D8%B1%D9%86%D8%A7%D9%85%D8%AC-%D8%A7%D9%84%D9%82%D9%88%D9%85%D9%8A-%D9%84%D9%85%D9%86%D8%A7%D9%87%D8%B6%D8%A9-%D8%AE%D8%AA%D8%A7%D9%86-%D8%A7%D9%84%D8%A5%D9%86%D8%A7%D8%AB'),
                      ),
                    ],
                  )*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
