import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nbtt_masr/Pages/report_violation.dart';
import 'package:nbtt_masr/Pages/suport_and_advice.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/models/dailyTipsModel.dart';
import 'package:nbtt_masr/service/sqlite_service/dbhelper.dart';
import 'components/customDrawer.dart';
import 'components/logoRow.dart';
import 'founded_kid.dart';
import 'missing_kid_wizard.dart';

class StartPage extends StatefulWidget {
  final bool? firstTime;

  const StartPage({Key? key, this.firstTime}) : super(key: key);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  //final bool firstTime = true;
  late DBHelper helper;
  late Future<void> _initForm;
  List<DailyTipsModel> dailyTipsList = <DailyTipsModel>[];
  List<DailyTipsModel> dailyTipsByPeriodList = <DailyTipsModel>[];

  Future<void> _initStateAsync() async {
    dailyTipsList.addAll(await helper.allTipOfDay());
    for (int i = 0; i < dailyTipsList.length; i++) {
      var check = await isCurrentDateInRange(
          DateTime.parse(dailyTipsList[i].from),
          DateTime.parse(dailyTipsList[i].to));
      if (check) {
        dailyTipsByPeriodList.add(dailyTipsList[i]);
        //print('true12222');
      } else {
        dailyTipsByPeriodList.add(dailyTipsList.last);
        //print('false');
      }
    }
  }

  Future<bool> isCurrentDateInRange(
      DateTime startDate, DateTime endDate) async {
    final currentDate = DateTime.now();
    return await currentDate.isAfter(startDate) &&
        currentDate.isBefore(endDate);
  }

  @override
  void initState() {
    super.initState();
    helper = new DBHelper();
    _initForm = _initStateAsync();
    if (widget.firstTime == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(Duration(milliseconds: 200));
        setState(() {
          createAlertDialog(context);
        });
      });
    }
    //checkTipOfDay();
  }

  createAlertDialog(BuildContext context) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: _initForm,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: Center(
                      child: Card(
                        child: Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  );
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else {
                    var temp = base64Decode(dailyTipsByPeriodList[0].tipImage);
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 40,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'معلومة اليوم',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: kRedColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            /* SvgPicture.network(dailyTipsList[r].tipImage.replaceAll(r"\", "/"),
                          height: screenHeight * 0.2,),*/
                            SvgPicture.memory(
                              temp,
                              height: screenHeight * 0.2,
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Center(
                              child: Text(
                                dailyTipsByPeriodList[0].tip,
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 18,
                                    height: 1.5),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                //overflow: TextOverflow.ellipsis,
                                //maxLines: 10,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              }
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customBottomNavBar(
          screenHeight: screenHeight, screenWidth: screenWidth),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/Scroll Group 1.png"),
            fit: BoxFit.cover,
            //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.darken),
          )),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.08),
                child: LogoRow(screenHeight: screenHeight),
              ),
              //FlatButton(onPressed: () =>  createAlertDialog(context), child: Text('')),
              Container(
                height: screenHeight * 0.7,
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.1,
                              bottom: screenHeight * 0.01),
                          child: Container(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.35,
                            // margin: EdgeInsets.only(bottom: screenHeight *0.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SupportAndAdvicePage(),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/Group 8674.svg",
                                          height: screenHeight * 0.18,
                                          width: screenWidth * 0.35),
                                      /*     Image.asset("assets/images/Component 11 – 1.png",
                                        height: screenHeight*0.2,width: screenWidth * 0.35,),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.002,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "الدعم والمشورة",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                            color: kTextColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.1,
                              bottom: screenHeight * 0.01),
                          child: Container(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.35,
                            // margin: EdgeInsets.only(bottom: screenHeight *0.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportViolationPage(),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/Group 8675.svg",
                                          height: screenHeight * 0.18,
                                          width: screenWidth * 0.35),
                                      /*   Image.asset("assets/images/Component 12 – 1.png",
                                        height: screenHeight*0.2,width: screenWidth * 0.35,),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.002,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "طفل في خطر",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                            color: kTextColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  /* Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: screenWidth *0.3,
                                          child: Text("طفل في خطر",
                                            style: TextStyle(fontSize: 18,color: kTextColor,fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          ))
                                    ],
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.1,
                              bottom: screenHeight * 0.01),
                          child: Container(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.35,
                            // margin: EdgeInsets.only(bottom: screenHeight *0.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoundedKidPage(),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/Group 8676.svg",
                                          height: screenHeight * 0.18,
                                          width: screenWidth * 0.35),
                                      /* Image.asset("assets/images/Component 10 – 1.png",
                                        height: screenHeight*0.2,width: screenWidth * 0.35,),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.002,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "العثور على طفل",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                            color: kTextColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.1,
                              bottom: screenHeight * 0.01),
                          child: Container(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.35,
                            //margin: EdgeInsets.only(bottom: screenHeight *0.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WizardForm(),
                                    ));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/Group 8677.svg",
                                          height: screenHeight * 0.18,
                                          width: screenWidth * 0.35),
                                      /* Image.asset("assets/images/Component 13 – 1.png",
                                        height: screenHeight*0.2,width: screenWidth * 0.35,),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.002,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "طفل مفقود",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                            color: kTextColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
