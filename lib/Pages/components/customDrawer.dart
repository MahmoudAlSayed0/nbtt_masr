
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nbtt_masr/Pages/aboutUs.dart';
import 'package:nbtt_masr/Pages/contactUs.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/models/MenuItemsModel.dart';
import 'package:nbtt_masr/service/sqlite_service/dbhelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../howToUse.dart';
import '../importantFiles_page.dart';
import '../onBoarding.dart';

class customBottomNavBar extends StatefulWidget {
   customBottomNavBar({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  _customBottomNavBarState createState() => _customBottomNavBarState();
}

class _customBottomNavBarState extends State<customBottomNavBar> {
  late DBHelper helper;
  late Future<void> _initForm;


  final _menuList = <MenuItemsModel>[];

  Future<void> _initStateAsync() async {
    _menuList.addAll(await helper.allMenuItems());
  }

  @override
  void initState() {
    super.initState();
    helper= new DBHelper();
    _initForm = _initStateAsync();
  }
  _launchLowInfoURL(String menuURL) async {
    if (!await launchUrl(Uri.parse(menuURL),
      mode: LaunchMode.externalApplication,)) {
      throw 'Could not launch $menuURL';
    }
/*    if (await canLaunch(menuURL)) {
      await launch(
        menuURL,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $menuURL';
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.1,
      decoration: BoxDecoration(color: Colors.white,
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
                offset: Offset(0.0, -widget.screenHeight * 0.04),
                child: Container(
                  width: widget.screenWidth * 0.15,
                  height: widget.screenHeight * 0.12,
                  //margin: EdgeInsets.only(bottom: screenHeight *0.04),
                  decoration: BoxDecoration(
                      color: kRedColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20.0),
                            blurRadius: 20,
                            color: kTextColor)
                      ]
                      // borderRadius: BorderRadius.circular(screenWidth * 0.14),
                      ),
                  child: IconButton(
                    icon: Icon(
                      Icons.list_outlined,
                      size: widget.screenWidth * 0.12,
                      color: Colors.white,
                    ),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Drawer(
                        child: ListView(
                          // Important: Remove any padding from the ListView.
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            DrawerHeader(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 40,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/nbttmsrLogo2.svg",
                                    height: widget.screenHeight * 0.1,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                                title: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "نبذة عن المجلس",
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                              fontSize: widget.screenWidth * 0.05),
                                            ),
                                            SizedBox(
                                              width: widget.screenWidth * 0.03,
                                            ),
                                            Icon(
                                              Icons.info_outline,
                                              size: 22,
                                              color: kPrimaryColor,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 22,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AboutUs()))),
                            ListTile(
                                title: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "للاتصال بنا",
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: widget.screenWidth * 0.05),
                                            ),

                                            Icon(
                                              Icons.call,
                                              size: 22,
                                              color: kPrimaryColor,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 22,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContactUs()))
                                //_launchContactUsURL,
                                ),
                            /*   ListTile(
                                title: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("التنبيهات",style: TextStyle(color: kPrimaryColor),),
                                            SizedBox(width: screenWidth * 0.03,),
                                            Icon(Icons.notifications_outlined,size: 22,color: kPrimaryColor,),
                                          ],
                                        )
                                      ],
                                    ),
                                    Icon(Icons.arrow_back_ios_rounded,size: 22,color: kPrimaryColor,),
                                  ],
                                ),
                                onTap: () {},
                              ),*/
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: ExpansionTile(
                                tilePadding:
                                    EdgeInsets.only(left: widget.screenWidth * 0.04),
                                title: ListTile(
                                  title: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.info,
                                                size: 22,
                                                color: kPrimaryColor,
                                              ),
                                              SizedBox(
                                                width: widget.screenWidth * 0.02,
                                              ),
                                              Text(
                                                "معلومات تهمك",
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: widget.screenWidth * 0.05),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                children: [
                                  FutureBuilder(
                                      future: _initForm,
                                      builder: (context, snapshot){
                                        return Column(
                                          children: [
                                            ...List.generate(
                                                _menuList.length, (index) => buildMenu(_menuList[index].menuName,
                                                _menuList[index].menuURL))
                                          ],
                                        );
                                      }
                                  ),
                                ],/*[
                                   buildMenu(),
                                  Divider(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.08,
                                        left: screenWidth * 0.08),
                                    child: InkWell(
                                      onTap: () => _launchHowURL(),
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ImportantInfoPage())),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "ازاى نربى أولادنا صح",
                                            style: TextStyle(color: kTextColor),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                            color: kTextColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.08,
                                        left: screenWidth * 0.08),
                                    child: InkWell(
                                      onTap: () => _launchLowInfoURL(),
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ImportantInfoPage())),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "معلومات قانونية",
                                            style: TextStyle(color: kTextColor),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                            color: kTextColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.08,
                                        left: screenWidth * 0.08,
                                        bottom: screenHeight * 0.08),
                                    child: InkWell(
                                      onTap: () => _launchCronaURL(),
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ImportantInfoPage())),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "عيلتنا والكورونا",
                                            style: TextStyle(color: kTextColor),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                            color: kTextColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],*/
                              ),
                            ),
                            ListTile(
                                title: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "كيفية استخدام البرنامج",
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: widget.screenWidth * 0.05),
                                            ),
                                            SizedBox(
                                              width: widget.screenWidth * 0.03,
                                            ),
                                            Icon(FontAwesomeIcons.question,color: kPrimaryColor,
                                              ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 22,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HowToUsePage()))),
                            /* ListTile(
                                title: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("حسابى",style: TextStyle(color: kPrimaryColor),),
                                            SizedBox(width: screenWidth * 0.03,),
                                            Icon(Icons.perm_identity,size: 22,color: kPrimaryColor,),
                                          ],
                                        )
                                      ],
                                    ),
                                    Icon(Icons.arrow_back_ios_rounded,size: 22,color: kPrimaryColor,),
                                  ],
                                ),
                                onTap: () {},
                              ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /*     Container(
                //margin: EdgeInsets.only(top: screenHeight * 0.03),
                  child: Icon(Icons.notifications_outlined,size: 30,)
              )*/
            ],
          )
        ],
      ),
    );
  }

   Widget buildMenu(String menuName,String menuUrl) {

    return Padding(
      padding:
      EdgeInsets.only(right: widget.screenWidth * 0.08, left: widget.screenWidth * 0.08,
      bottom: widget.screenHeight * 0.015),
      child: InkWell(
        onTap: () => _launchLowInfoURL(menuUrl),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              menuName,
              style: TextStyle(color: kTextColor,fontSize: widget.screenWidth * 0.04),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: kTextColor,
            ),

          ],
        ),
      ),
    );
  }
}
