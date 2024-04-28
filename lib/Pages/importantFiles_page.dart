import 'package:flutter/material.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/helpers/constants.dart';

import 'components/logoRow.dart';
import 'components/mainDrawer.dart';

class ImportantInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer:
          MainDrawer(screenHeight: screenHeight, screenWidth: screenWidth),
      bottomNavigationBar: Container(
        height: screenHeight * 0.12,
        decoration: BoxDecoration(
            color: Colors.white,
          /*  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),*/
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, -10),
                  blurRadius: 20,
                  color: Color(0xFFDADADA) //.withOpacity(0.15)
                  )
            ]),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0.0, -screenHeight * 0.04),
                  child: Container(
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.14,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.04),
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
                      child: IconButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StartPage(),
                              )),
                          icon: Icon(
                            Icons.home_outlined,
                            size: 30,
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage())),
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
                Text('معلومات قانونية',style: TextStyle(
                  color: kTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_back, size: 30),
                    title: Text('س : ما هو المقصود بالطفل ؟',textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_back, size: 30),
                    title: Text('س : من هم الأشخاص المكلفون بالتبليغ عن الولادة ؟',textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_back, size: 30),
                    title: Text('س : ما هي المواعيد المقررة للإبلاغ عن واقعة الميلاد ؟',textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_back, size: 30),
                    title: Text('س : ما هي المواعيد المقررة للإبلاغ عن واقعة الميلاد ؟',textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_back, size: 30),
                    title: Text('س: ما هى البيانات الواجب توافرها عند التبليغ عن ولادة الطفل ؟',textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_back, size: 30),
                    title: Text('س :ما هو المعيار عند إختيار اسماً للطفل ؟',textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_back, size: 30),
                    title: Text('س : ما هي عقوبة الإدلاء ببيان غير صحيح عند التبليغ عن المولود؟',textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 20
                      ),
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
