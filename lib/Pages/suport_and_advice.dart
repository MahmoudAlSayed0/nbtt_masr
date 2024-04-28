import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/Pages/success_screen.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/models/MenuItemsModel.dart';
import 'package:nbtt_masr/models/SupportModel.dart';
import 'package:nbtt_masr/service/sqlite_service/dbhelper.dart';
import 'package:nbtt_masr/service/support_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AdviceConfirmationPage.dart';
import 'components/logoRow.dart';
import 'components/mainDrawer.dart';

class SupportAndAdvicePage extends StatefulWidget {
  @override
  _SupportAndAdvicePageState createState() => _SupportAndAdvicePageState();
}

class _SupportAndAdvicePageState extends State<SupportAndAdvicePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _briefDescription = TextEditingController();
  TextEditingController _fileNo = TextEditingController();
  TextEditingController _kidName = TextEditingController();
  TextEditingController _kidAge = TextEditingController();
  SupportService get supportService => GetIt.instance<SupportService>();
  ScrollController? _scrollController;

  SupportModel? model;
  bool mother = false;
  bool kid = false;
  bool kidVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  IsContactBefore _character = IsContactBefore.No;
  SupportForHow _supportForHow = SupportForHow.Mother;
  bool _visible = false;
  bool _visibleUP = false;
  bool _visibleDown = true;
  int pcValue = 2;
  String typeValue = 'الام';
  late DBHelper helper;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    helper = new DBHelper();
    _scrollController = ScrollController();
    /*_scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
         // title = "reached the bottom";
          _visibleDown = false;
          _visibleUP = true;
        });
      }else if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          //title = "reached the top";
          _visibleDown = true;
          _visibleUP = false;
        });
      } else {
        setState(() {
          //title = prevTitle;
          print('error');
        });
      }
    });*/
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    //_initStateAsync();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.08),
            child: Container(
              width: screenWidth * 0.15,
              height: screenHeight * 0.14,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.question,
                  color: kRedColor,
                  size: screenWidth * 0.1,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return Stack(
                      //alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/iPhone 6, 7, 8 – 52.png",
                            width: screenWidth,
                            height: screenHeight,
                            fit: BoxFit.fill),
                        Transform.translate(
                          offset:
                              Offset(screenWidth * 0.04, screenHeight * 0.1),
                          child: RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: screenWidth * 0.04,
                                  color: Colors.white,
                                ),
                                Text(
                                  "تخطى",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.06,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            color: Colors.transparent,
                            elevation: 0,
                          ),
                        ),
                      ],
                    );
                  }));
                },
              ),
            ),
          ),
        ],
      ),
      /*Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         Visibility(
            visible: _visibleUP,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.08),
                  child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Icon(Icons.arrow_circle_up,color: kRedColor,size: 40,),
                      onPressed: () {
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: Duration(milliseconds: 400),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _visibleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.08),
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Icon(Icons.arrow_circle_down,color: kRedColor,size: 40,),
                      onPressed: () {
                        _scrollController.animateTo(
                          screenHeight,
                          curve: Curves.easeOut,
                          duration: Duration(milliseconds: 400),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),

        ],
      ),*/
      //endDrawer:  MainDrawer(screenHeight: screenHeight, screenWidth: screenWidth) ,
      endDrawer:
          MainDrawer(screenHeight: screenHeight, screenWidth: screenWidth),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StartPage(
                        firstTime: false,
                      ))),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
      ),
      body:  SingleChildScrollView(
              /*controller: _scrollController,*/
              child: Column(
                children: [
                  LogoRow(screenHeight: screenHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'الدعم والمشورة',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01, bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'جميع البيانات المقدمة من خلال الاستمارة تحظى بالسرية التامة',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: screenWidth * 0.04,
                          ),
                        )
                      ],
                    ),
                  ),
                  /*   Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Text('To Top'),
                  onPressed: () {
                    _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn);
                  },),
                RaisedButton(
                  child: Text('To Bottom'),
                  onPressed: () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn);
                  },),
              ],),*/
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.08,
                                  left: screenWidth * 0.08,
                                  top: screenWidth * 0.02,
                                  bottom: screenHeight * 0.02),
                              child: Text(
                                'بيانات طالب الدعم',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: kRedColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: _nameController,
                              maxLines: 1,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                labelText: "الاسم",
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: kBorderColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: kBorderColor)),
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك ادخل اسم طالب الدعم';
                                } else {
                                  return null;
                                }
                              },
                              /*onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/
                              //keyboardType: TextInputType.number,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(pin2FocusNode);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: _mobileController,
                              maxLines: 1,
                              focusNode: pin2FocusNode,
                              maxLength: 11,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                labelText: "التليفون",
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                    BorderSide(color: kBorderColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                    BorderSide(color: kBorderColor)),
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك ادخل رقم تليفون ';
                                } else if (value.length != 11) {
                                  return 'من فضلك ادخل رقم تليفون صحيح';
                                } /*else if (mobileValidatorRegExp.hasMatch(value)){
                         return 'من فضلك ادخل رقم تليفون صحيح';
                       }*/
                                else {
                                  return null;
                                }
                              },
                              /* onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(pin3FocusNode);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: _addressController,
                              maxLines: 1,
                              focusNode: pin3FocusNode,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                labelText: "العنوان",
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: kBorderColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: kBorderColor)),
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك ادخل عنوان طالب الدعم';
                                } else {
                                  return null;
                                }
                              },
                              /* onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/

                              //keyboardType: TextInputType.number,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.08,
                                  left: screenWidth * 0.08,
                                  top: screenWidth * 0.02),
                              child: Text(
                                'بيانات الدعم والمشورة',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: kRedColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.1,
                                  left: screenWidth * 0.08,
                                  top: screenWidth * 0.02),
                              child: Text(
                                'المستفيد من الخدمات المطلوبة',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Radio(
                                activeColor: kGreenColor,
                                value: SupportForHow.Kid,
                                groupValue: _supportForHow,
                                onChanged: (SupportForHow? value) {
                                  setState(() {
                                    _supportForHow = value!;
                                    typeValue = 'الطفل';
                                    kidVisible = true;
                                  });
                                },
                              ),
                              Text(
                                'الطفل',
                                style:
                                    TextStyle(fontSize: 20, color: kTextColor),
                              ),
                              Radio(
                                value: SupportForHow.Mother,
                                activeColor: kGreenColor,
                                groupValue: _supportForHow,
                                onChanged: (SupportForHow? value) {
                                  setState(() {
                                    _supportForHow = value!;
                                    typeValue = 'الام';
                                    kidVisible = false;
                                  });
                                },
                              ),
                              Text(
                                'الام',
                                style:
                                TextStyle(fontSize: 20, color: kTextColor),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: kidVisible,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                controller: _kidName,
                                maxLines: 1,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  labelText: "اسم الطفل",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                      BorderSide(color: kBorderColor)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: kRedColor.withOpacity(0.5))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                      BorderSide(color: kBorderColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: kRedColor.withOpacity(0.5))),
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                //keyboardType: TextInputType.number,
                                validator: kidVisible ? (value) {
                            if(value!.isEmpty){
                              return 'من فضلك ادخل اسم الطفل';
                            }else{
                              return null;
                            }
                          } : null,
                          onChanged: (value) {
                            if(value.isNotEmpty)
                              _formKey.currentState!.validate();
                          },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: kidVisible,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                controller: _kidAge,
                                maxLines: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  labelText: "عمر الطفل",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                      BorderSide(color: kBorderColor)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: kRedColor.withOpacity(0.5))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                      BorderSide(color: kBorderColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: kRedColor.withOpacity(0.5))),
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                validator: kidVisible ? (value) {
                            if(value!.isEmpty){
                              return 'من فضلك ادخل عمر الطفل';
                            } else if(int.parse(value) > 18){
                              return 'يجب سن الطفل لا يتعدى ال ١٨ سنة';
                            }else{
                              return null;
                            }
                          } : null,
                          onChanged: (value) {
                            if(value.isNotEmpty)
                              _formKey.currentState!.validate();
                          },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: _briefDescription,
                              maxLines: 2,
                              maxLength: 250,
                              focusNode: pin4FocusNode,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                labelText:
                                    "توصيف مختصر للدعم والمشورة المطلوبة",
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: kRedColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: kBorderColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: kBorderColor)),
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك ادخل توصيف مختصر للدعم والمشورة المطلوبة';
                                } else {
                                  return null;
                                }
                              },
                              /* onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/
                              //keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.1,
                                  left: screenWidth * 0.08,
                                  top: screenWidth * 0.02),
                              child: Text(
                                'هل تم التواصل سابقا مع المجلس',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Radio(
                                activeColor: kGreenColor,
                                value: IsContactBefore.Yes,
                                groupValue: _character,
                                onChanged: (IsContactBefore? value) {
                                  setState(() {
                                    _character = value!;
                                    _visible = true;
                                    pcValue = 1;
                                  });
                                },
                              ),
                              Text(
                                'نعم',
                                style: new TextStyle(fontSize: 20.0),
                              ),
                              Radio(
                                value: IsContactBefore.No,
                                activeColor: kGreenColor,
                                groupValue: _character,
                                onChanged: (IsContactBefore? value) {
                                  setState(() {
                                    _character = value!;
                                    _visible = false;
                                    pcValue = 2;
                                  });
                                },
                              ),
                              Text(
                                'لا',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _visible,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenWidth * 0.08,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                controller: _fileNo,
                                maxLines: 1,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  labelText: "رقم الملف",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: kBorderColor)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: kRedColor.withOpacity(0.5))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: kBorderColor)),
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                /*validator: pcValue == 1 ? (value) {
                            if(value.isEmpty){
                              return 'من فضلك ادخل رقم الملف';
                            }else{
                              return null;
                            }
                          } : null,
                          onChanged: (value) {
                            if(value.isNotEmpty)
                              _formKey.currentState.validate();
                          },*/
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.05,
                              bottom: screenHeight * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: screenWidth * 0.55,
                                height: screenHeight * 0.07,
                                child: FlatButton(
                                  onPressed: () async {
                                    if(_formKey.currentState!.validate()){
                                      final model = SupportModel(
                                          name: _nameController.text,
                                          address: _addressController.text,
                                          phoneNumber: _mobileController.text,
                                          type: typeValue,
                                          kidName: _kidName.text,
                                          kidAge: _kidAge.text,
                                          pc: pcValue,
                                          description: _briefDescription.text,
                                          fileNo: _fileNo.text
                                      );
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdviceConfirmationPage(model: model,),));

                                    }

                                    /*if(_formKey.currentState.validate()){
                              try{
                                final model =SupportModel(
                                    name: _nameController.text,
                                    address: _addressController.text,
                                    phoneNumber: _mobileController.text,
                                    type: typeValue,
                                    pc: pcValue,
                                    description: _briefDescription.text,
                                    fileNo: _fileNo.text
                                );
                                setState(() {
                                  isLoading = true;
                                });
                                final result= await supportService.createSupport(model);
                                setState(() {
                                  isLoading = true;
                                });

                                print(result.isValid);
                                if(result.isValid == true){
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) => SuccessScreen()));
                                }else{
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showDialog(context: context,builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                IconButton(icon: Icon(Icons.close, size: 40,),
                                                  onPressed: () => Navigator.of(context).pop(),),
                                              ],
                                            ),
                                            Center(
                                              child: Text(result.message,
                                                style: TextStyle(
                                                    color: kTextColor,
                                                    fontSize: 18,
                                                    height: 1.5
                                                ),
                                                textDirection: TextDirection.rtl,
                                                textAlign: TextAlign.center,
                                                //overflow: TextOverflow.ellipsis,
                                                //maxLines: 10,
                                              ),
                                            ),
                                            SizedBox(height: screenHeight * 0.01,),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                }

                              }catch(e){
                                showDialog(context: context,builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              IconButton(icon: Icon(Icons.close, size: 40,),
                                                onPressed: () => Navigator.of(context).pop(),),
                                            ],
                                          ),
                                          Center(
                                            child: Text(e.toString(),
                                              style: TextStyle(
                                                  color: kTextColor,
                                                  fontSize: 18,
                                                  height: 1.5
                                              ),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              //overflow: TextOverflow.ellipsis,
                                              //maxLines: 10,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01,),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              }

                            }*/
                                  },
                                  //=> Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessScreen())),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "ارسال",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key!),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
