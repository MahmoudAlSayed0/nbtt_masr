import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/Pages/success_screen.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/models/ViolationModel.dart';
import 'package:nbtt_masr/models/multiImageModel.dart';
import 'package:nbtt_masr/service/violation_service.dart';
import 'package:location/location.dart';

import 'AbuseConfirmationPage.dart';
import 'components/logoRow.dart';
import 'components/mainDrawer.dart';

class ReportViolationPage extends StatefulWidget {
  @override
  _ReportViolationPageState createState() => _ReportViolationPageState();
}

class _ReportViolationPageState extends State<ReportViolationPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _kidNameController = TextEditingController();
  TextEditingController _kidAgeController = TextEditingController();
  TextEditingController _kidPlaceController = TextEditingController();
  TextEditingController _briefDescription = TextEditingController();
  TextEditingController _fileNo = TextEditingController();
  TextEditingController _paperName = TextEditingController();
  bool isSwitched = false;
  ViolationService get violationService => GetIt.instance<ViolationService>();

  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;
  IsContactBefore _character = IsContactBefore.No;
  IsContactBefore _havePaper = IsContactBefore.No;

  int pc = 2;
  int pp =2;

  bool _visible = false;
  bool _visibleImage = false;
  bool _visibleImageName = false;
  bool _visibleUP = false;
  bool _visibleDown = true;
  bool _visibledoc = false;
  bool _visibleMoreDoc = false;

  var listOfObjects = <MultiImageModel>[];
  List<String> attachmentName = <String>[];
  List<String> attachmentDoc = <String>[];
  File? _paperImage;
  int imageIndex = 0;
  Future getPaperImage()  async{
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _paperImage = File(pickedFile!.path);
    });
  }

/*  addPaper(){
    setState(() {
      listOfObjects.add(MultiImageModel(imageName: _paperName.text,imageFile: _paperImage,imageIndex : imageIndex));
      imageIndex ++;
      _paperName.clear();
      _paperImage = null;
    });
  }*/
  removePaper(int index){
    var temp = <MultiImageModel>[];
    for(int i = 0 ; i<listOfObjects.length ; i++){
      if(listOfObjects[i].imageIndex != index){
        temp.add(MultiImageModel(imageName: listOfObjects[i].imageName,imageFile: listOfObjects[i].imageFile,
            imageIndex: listOfObjects[i].imageIndex));
      }
    }

    /*List<MultiImageModel> name = listOfObjects.where((element) => element.imageIndex == index);
    attachmentName.remove(name[0].imageName);
    attachmentDoc.remove(name[0].imageFile);*/

    setState(() {
      //listOfObjects.clear();
      listOfObjects = temp;
    });
  }
  Location location = new Location();
  ScrollController? _scrollController;

  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  String? lat,long;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
   /* _scrollController.addListener(() {
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
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();

  }

  @override
  void dispose() {
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
    _scrollController!.dispose();

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
                child: Icon(FontAwesomeIcons.question,color: kRedColor,
                  size: screenWidth * 0.1,),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context){
                        return Stack(
                          //alignment: Alignment.center,
                          children: [
                            Image.asset("assets/images/iPhone 6, 7, 8 – 52.png",
                                width: double.infinity,height: screenHeight,
                                fit: BoxFit.fill),
                            Transform.translate(
                              offset: Offset(screenWidth * 0.04, screenHeight * 0.1),
                              child: RaisedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios,
                                      size: screenWidth * 0.04,color: Colors.white,),
                                    Text("تخطى",style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        color: Colors.white
                                    ),),
                                  ],
                                ),
                                color: Colors.transparent,
                                elevation: 0,
                              ),
                            ),
                          ],
                        );
                      }
                  ));
                },
              ),
            ),
          ),
        ],
      ) ,
      /*floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.08),
            child: Column(
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
            ),
          ),
        ],
      ),*/
      endDrawer:  MainDrawer(screenHeight: screenHeight, screenWidth: screenWidth) ,
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
      body: isLoading ? WillPopScope(
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
      ) : SingleChildScrollView(
        //controller: _scrollController,
        child: Column(
          children: [
            LogoRow(screenHeight: screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('طفل في خطر',style: TextStyle(
                  color: kTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01,bottom: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('جميع البيانات المقدمة من خلال الاستمارة تحظى بالسرية التامة',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: screenWidth * 0.04,

                    ),)
                ],
              ),
            ),
            Form(
              key: _formKey,
              //autovalidate: true,
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth * 0.08,
                            left: screenWidth * 0.08,
                            top: screenWidth * 0.02),
                        child: Text('بيانات الطفل',style: TextStyle(
                          fontSize: 22,color: kRedColor,fontWeight: FontWeight.w900,
                        ),),
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
                        controller: _kidNameController,
                        focusNode: pin3FocusNode,
                        maxLines: 1,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "اسم الطفل",
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'من فضلك ادخل اسم الطفل';
                          }
                          else{
                            return null;
                          }
                        },
                 /*       onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/
                        //keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(pin4FocusNode);
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
                        controller: _kidAgeController,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                        focusNode: pin4FocusNode,
                        maxLines: 1,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "عمر الطفل",
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'من فضلك ادخل عمر الطفل';
                          }else if(int.parse(value) > 18){
                            return 'يجب عمر الطفل لا يتعدى ال ١٨ سنة';
                          }
                          else{
                            return null;
                          }
                        },
                      /*  onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(pin1FocusNode);
                        },
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
                            top: screenWidth * 0.02,
                            bottom: screenHeight * 0.02),
                        child: Text('بيانات المبلغ',style: TextStyle(
                          fontSize: 22,color: kRedColor,fontWeight: FontWeight.w900,
                        ),),
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
                        focusNode: pin1FocusNode,
                        maxLines: 1,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "اسم المبلغ",
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        /* validator: (value) {
                          if(value.isEmpty){
                            return 'من فضلك ادخل اسم طالب الدعم';
                          }else{
                            return null;
                          }
                        },*/
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
                        focusNode: pin2FocusNode,
                        maxLines: 1,
                        maxLength: 11,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "رقم تليفون المبلغ",
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        /* validator: (value) {
                          if(value.isEmpty){
                            return 'من فضلك ادخل رقم تليفون ';
                          }else if(value.length != 11){
                            return 'من فضلك ادخل رقم تليفون صحيح';
                          }*//*else if (mobileValidatorRegExp.hasMatch(value)){
                            return 'من فضلك ادخل رقم تليفون صحيح';
                          }*//*else{
                            return null;
                          }
                        },*/
                        /* onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(pin5FocusNode);
                        },
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
                        child: Text('بيانات الشكوى',style: TextStyle(
                          fontSize: 22,color: kRedColor,fontWeight: FontWeight.w900,
                        ),),
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
                        controller: _kidPlaceController,
                        focusNode: pin5FocusNode,
                        maxLines: 2,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "مكان تواجد الطفل تفصيلا",
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'من فضلك ادخل مكان تواجد الطفل تفصيلا';
                          }
                          else{
                            return null;
                          }
                        },
                      /*  onChanged: (value) {
                          if(value.isNotEmpty)
                            _formKey.currentState.validate();
                        },*/
                        //keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(pin6FocusNode);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth * 0.08,
                        left: screenWidth * 0.08,
                        top: screenWidth * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('GPS',style: TextStyle(
                          fontSize: screenWidth * 0.04,color: kTextColor,
                        ),),
                        Text('تحديد مكان تواجد الطفل عن طريق ',style: TextStyle(
                          fontSize: screenWidth * 0.04,color: kTextColor,
                        ),),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) async {
                            _serviceEnabled = await location.serviceEnabled();
                            if (!_serviceEnabled) {
                              _serviceEnabled = await location.requestService();
                              if (!_serviceEnabled) {
                                return;
                              }
                            }

                            _permissionGranted = await location.hasPermission();
                            if (_permissionGranted == PermissionStatus.denied) {
                              _permissionGranted = await location.requestPermission();
                              if (_permissionGranted != PermissionStatus.granted) {
                                return;
                              }
                            }
                            _locationData = await location.getLocation();
                            setState(() {
                              isSwitched = value;
                              lat = _locationData!.latitude.toString();
                              long = _locationData!.longitude.toString();
                              //print(isSwitched);
                            });
                          },
                         activeColor: kGreenColor,
                        ),
                      ],
                    )
                  ),
                  /*Visibility(
                    visible: isSwitched,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.1,
                              left: screenWidth * 0.08,
                              top: screenWidth * 0.02),
                          child:Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth * 0.1,
                                    left: screenWidth * 0.08,
                                    top: screenWidth * 0.02),
                                child: Text(lat == null ? '......' : lat,style: TextStyle(
                                  fontSize: 20,color: kTextColor,
                                ),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth * 0.1,
                                    left: screenWidth * 0.08,
                                    top: screenWidth * 0.02),
                                child: Text(long == null ? '......' : long,style: TextStyle(
                                  fontSize: 20,color: kTextColor,
                                ),),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth * 0.08,
                        left: screenWidth * 0.08,
                        top: screenWidth * 0.02),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: _briefDescription,
                        focusNode: pin6FocusNode,
                        maxLines: 3,
                        maxLength: 250,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "توصيف مختصر للشكوى",
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kRedColor.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: kBorderColor
                              )
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'من فضلك ادخل توصيف مختصر للشكوى';
                          }
                          else{
                            return null;
                          }
                        },
                      /*  onChanged: (value) {
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
                        child: Text('هل تم التواصل سابقا مع المجلس',style: TextStyle(
                          fontSize: 20,color: kTextColor,
                        ),),
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
                              pc = 1;
                              _visible = true;
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
                              pc = 2;
                              _visible = false;
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
                          top: screenWidth * 0.02),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _fileNo,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: "رقم الملف",
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kRedColor.withOpacity(0.5)
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kBorderColor
                                )
                            ),
                            focusedErrorBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kRedColor.withOpacity(0.5)
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kBorderColor
                                )
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                         /* validator: pc == 1 ? (value) {
                            if(value.isEmpty){
                              return 'من فضلك ادخل رقم الملف';
                            }
                            else{
                              return null;
                            }
                          } : null,*/
                         /* onChanged: (value) {
                            if(value.isNotEmpty)
                              _formKey.currentState.validate();
                          },*/
                        ),
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
                        child: Text('هل لديك مرفقات تساهم في توثيق الانتهاك',style: TextStyle(
                          fontSize: 20,color: kTextColor,
                        ),),
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
                          groupValue: _havePaper,
                          onChanged: (IsContactBefore? value) {
                            setState(() {
                              _havePaper = value!;
                              pp = 1;
                              _visibleImage = true;
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
                          groupValue: _havePaper,
                          onChanged: (IsContactBefore? value) {
                            setState(() {
                              _havePaper = value!;
                              pp = 2;
                              _visibleImage = false;
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
                    visible: _visibleImage,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: screenWidth * 0.08,
                          left: screenWidth * 0.08,
                          top: screenWidth * 0.02),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _paperName,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: "اسم المرفق",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kBorderColor
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kBorderColor
                                )
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _visibleImage,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: screenWidth * 0.08,
                          left: screenWidth * 0.08,
                          top: screenWidth * 0.02),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          //controller: _fileNo,
                          onTap: getPaperImage,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: "مرفقات تساهم في توثيق الانتهاك",
                            prefixIcon: Icon(Icons.file_upload),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kBorderColor
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: kBorderColor
                                )
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_visibledoc && pp == 1) ? true : false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: screenWidth * 0.12,
                          top: screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'من فضلك ادخل المرفقات',
                            style: TextStyle(fontSize: 14, color: kRedColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_visibleMoreDoc && pp == 1) ? true : false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: screenWidth * 0.12,
                          top: screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'لا يمكن ادخال اكثر من مرفقين',
                            style: TextStyle(fontSize: 14, color: kRedColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _paperImage == null ? Text('',
                        style: TextStyle(fontSize: 20),) :
                      Container(child: Image.file(_paperImage!,),
                        height: screenHeight * 0.1,width: screenWidth * 0.7,),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01,),
                  Visibility(
                    visible: _visibleImage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _paperName.text != "" ? Text(_paperName.text,style: TextStyle(fontSize: 20),)
                        : Text('')
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _visibleImage,
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.45,
                            height: screenHeight * 0.07,
                            child: FlatButton(onPressed: () {
                              if(listOfObjects.length >= 2){
                                setState(() {
                                  _visibleMoreDoc = true;
                                });
                                return;
                              }else{
                                setState(() {
                                  _visibleMoreDoc = false;
                                });
                              }
                              if(_paperName.text == "" || _paperImage == null){
                                setState(() {
                                  _visibledoc = true;
                                });
                              }else{
                                _visibledoc = false;
                                setState(() {
                                  listOfObjects.add(MultiImageModel(imageName: _paperName.text,
                                      imageFile: _paperImage!,
                                      imageIndex : imageIndex));
                                  /* attachmentName.add(_paperName.text);
                                List<int> imageBytes =  _paperImage.readAsBytesSync();
                                attachmentDoc.add(base64Encode(imageBytes));*/

                                  imageIndex ++;
                                  _paperName.clear();
                                  _paperImage = null;
                                });
                              }

                            },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("أضف مرفق",style: TextStyle(color: kGreenColor,fontSize: 20,
                                      fontWeight: FontWeight.bold),),
                                  Icon(Icons.add_circle_outline_sharp,color: kGreenColor,size: 25,),
                                ],
                              ),

                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: kGreenColor
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _visibleImage,
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context){
                                return Stack(
                                  //alignment: Alignment.center,
                                  children: [
                                    Image.asset("assets/images/iPhone 6, 7, 8 – 47.png",
                                        width: double.infinity,height: screenHeight,
                                        fit: BoxFit.fill),
                                    Transform.translate(
                                      offset: Offset(screenWidth * 0.04, screenHeight * 0.1),
                                      child: RaisedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                              size: screenWidth * 0.04,color: Colors.white,),
                                            Text("تخطى",style: TextStyle(
                                                fontSize: screenWidth * 0.06,
                                                color: Colors.white
                                            ),),
                                          ],
                                        ),
                                        color: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    ),
                                  ],
                                );
                              }
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('كيفية إضافة مرفق',style: TextStyle(
                              color: kGreenColor,
                              fontSize: 18,
                            ),),
                        SizedBox(width: 5,),
                        Icon(FontAwesomeIcons.questionCircle,color: kGreenColor)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: listOfObjects.length != 0 ? true : false,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DataTable(
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: listOfObjects.map((e) =>
                              DataRow(cells: <DataCell>[
                            DataCell(e.imageFile == null ?
                            Text('',
                              style: TextStyle(fontSize: 20),) :
                            Container(child: Image.file(e.imageFile,),
                              height: screenHeight * 0.1,width: screenWidth * 0.3,),),
                            DataCell(Text(e.imageName)),

                            DataCell(
                             IconButton(
                               icon: Icon(Icons.delete,size: 20,color: kRedColor,),
                               onPressed: () => removePaper(e.imageIndex),
                             )
                            )
                          ]
                          )).toList() ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.05, bottom: screenHeight *0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth * 0.55,
                          height: screenHeight * 0.07,
                          child: FlatButton(onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              for(int i=0;i< listOfObjects.length; i++){
                                attachmentName.add(listOfObjects[i].imageName);
                                List<int> imageBytes =  listOfObjects[i].imageFile.readAsBytesSync();
                                attachmentDoc.add(base64Encode(imageBytes));
                              }
                              final model = ViolationModel(
                                  reporterName: _nameController.text,
                                  phoneNumber: _mobileController.text,
                                  kidName: _kidNameController.text,
                                  kidAge: int.parse(_kidAgeController.text),
                                  place: _kidPlaceController.text,
                                  complaint: _briefDescription.text,
                                  pc: pc,
                                  fileNo: _fileNo.text,
                                  pp: pp,
                                  attachmentName: attachmentName,
                                  attachmentDoc: attachmentDoc,
                                  lat : lat!,
                                  long : long!
                              );
                               Navigator.push(context, MaterialPageRoute(builder: (context)
                             => AbuseConfirmationPage(model: model,listOfObjects:listOfObjects),));

                              /*setState(() {
                                isLoading = true;
                              });
                              try{
                                final result= await violationService.createMissingKid(model);
                                setState(() {
                                  isLoading = true;
                                });
                                print(result.isValid);
                                if(result.isValid){
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
                                }*/

                                /*   showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(title),
                                  content: Text(text),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                              ).then((data) {
                                if(result.data){
                                  Navigator.of(context).pop();
                                }
                              });*/
                            /*  }catch(e){
                                print(e);
                              }*/
                            }

                            /*Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => SuccessScreen()));*/
                          }    , //=> Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                                SizedBox(width: 5,),
                                Text("ارسال",style: TextStyle(color: Colors.white,fontSize: 25,
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
