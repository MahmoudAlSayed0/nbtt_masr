import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nbtt_masr/Pages/success_screen.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/models/SupportModel.dart';
import 'package:nbtt_masr/service/support_service.dart';

import 'components/logoRow.dart';


class AdviceConfirmationPage extends StatefulWidget {
  final SupportModel model;

  const AdviceConfirmationPage({Key? key, required this.model}) : super(key: key);
  @override
  _AdviceConfirmationPageState createState() => _AdviceConfirmationPageState();
}

class _AdviceConfirmationPageState extends State<AdviceConfirmationPage> {
  bool isLoading = false;
  SupportService get supportService => GetIt.instance<SupportService>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return  Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: screenHeight * 0.05),
        color: Colors.white,
        child: isLoading
            ? WillPopScope(
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
        )
            : SingleChildScrollView(
              child: Column(
          children: [
              LogoRow(
                  screenHeight: screenHeight),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    'الدعم والمشورة',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize:
                      screenWidth * 0.07,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    bottom:
                    screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      'جميع البيانات المقدمة من خلال الاستمارة تحظى بالسرية التامة',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize:
                        screenWidth * 0.04,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right:
                        screenWidth * 0.08,
                        left:
                        screenWidth * 0.08,
                        top: screenWidth * 0.02,
                        bottom: screenHeight *
                            0.02),
                    child: Text(
                      'بيانات طالب الدعم',
                      style: TextStyle(
                        fontSize: 22,
                        color: kRedColor,
                        fontWeight:
                        FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              Directionality(
                textDirection:
                TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.08,
                      left: screenWidth * 0.08,
                      top: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        "الاسم",
                        style: TextStyle(
                            fontSize: 18),
                      ),
                      SizedBox(
                        width:
                        screenWidth * 0.04,
                      ),
                      Text(
                        widget.model.name,
                        style: TextStyle(
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Directionality(
                textDirection:
                TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.08,
                      left: screenWidth * 0.08,
                      top: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        "العنوان",
                        style: TextStyle(
                            fontSize: 18),
                      ),
                      SizedBox(
                        width:
                        screenWidth * 0.04,
                      ),
                      Text(
                        widget.model.address,
                        style: TextStyle(
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Directionality(
                textDirection:
                TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.08,
                      left: screenWidth * 0.08,
                      top: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        "الموبيل",
                        style: TextStyle(
                            fontSize: 18),
                      ),
                      SizedBox(
                        width:
                        screenWidth * 0.04,
                      ),
                      Text(
                        widget.model.phoneNumber,
                        style: TextStyle(
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right:
                        screenWidth * 0.08,
                        left:
                        screenWidth * 0.08,
                        top:
                        screenWidth * 0.02),
                    child: Text(
                      'بيانات الدعم والمشورة',
                      style: TextStyle(
                        fontSize: 22,
                        color: kRedColor,
                        fontWeight:
                        FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Directionality(
                textDirection:
                TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.08,
                      left: screenWidth * 0.08,
                      top: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        "المستفيد من الخدمات المطلوبة",
                        style: TextStyle(
                            fontSize: 18),
                      ),
                      SizedBox(
                        width:
                        screenWidth * 0.04,
                      ),
                      Text(
                        widget.model.type ?? '',
                        style: TextStyle(
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Directionality(
                textDirection:
                TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.08,
                      left: screenWidth * 0.08,
                      top: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        "توصيف مختصر للدعم والمشورة المطلوبة",
                        style: TextStyle(
                            fontSize: 18),
                      ),
                      SizedBox(
                        width:
                        screenWidth * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Directionality(
                textDirection:
                TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.08,
                      left: screenWidth * 0.08,
                      top: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.description,
                        style: TextStyle(
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Directionality(
                textDirection:
                TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.08,
                      left: screenWidth * 0.08,
                      top: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        "هل تم التواصل سابقا مع المجلس",
                        style: TextStyle(
                            fontSize: 18),
                      ),
                      SizedBox(
                        width:
                        screenWidth * 0.04,
                      ),
                      Text(
                        widget.model.pc == 1
                            ? 'نعم'
                            : 'لا',
                        style: TextStyle(
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Visibility(
                visible:
                widget.model.pc == 1 ? true : false,
                child: Directionality(
                  textDirection:
                  TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth * 0.08,
                        left: screenWidth * 0.08,
                        top: screenWidth * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "رقم الملف",
                          style: TextStyle(
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: screenWidth *
                              0.04,
                        ),
                        Text(
                          widget.model.fileNo ?? '',
                          style: TextStyle(
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.06,
                      child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.arrow_back, color: kPrimaryColor, size: 30,
                            ),
                            SizedBox(width: 5,),
                            Text("تعديل",
                              style: TextStyle(color: kPrimaryColor, fontSize: 25,
                                  fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: kPrimaryColor)),
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height:
                      screenHeight * 0.06,
                      child: FlatButton(
                        onPressed: () async {
                          //if (_formKey.currentState.validate()) {
                          try {
                            /*final model = SupportModel(
                                name: widget.model.name,
                                address: widget.model.address,
                                phoneNumber: ,
                                type:
                                typeValue,
                                pc: pcValue,
                                description:
                                _briefDescription
                                    .text,
                                fileNo: _fileNo
                                    .text);*/
                            setState(() {
                              isLoading = true;
                            });
                            final result = await supportService.createSupport(widget.model);
                            setState(() {
                              isLoading = true;
                            });

                            print(result.isValid);
                            if (result.isValid == true) {
                              Navigator.of(
                                  context).pushReplacement(MaterialPageRoute(builder: (_) => SuccessScreen()));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                      content:
                                      SingleChildScrollView(
                                        child:
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            Center(
                                              child: Text(
                                                result.message,
                                                style: TextStyle(color: kTextColor, fontSize: 18, height: 1.5),
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
                                  });
                            }
                          } catch (e) {
                            showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                    content:
                                    SingleChildScrollView(
                                      child:
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          Center(
                                            child: Text(
                                              e.toString(),
                                              style: TextStyle(color: kTextColor, fontSize: 18, height: 1.5),
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
                                });
                          }
                          //}
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white, size: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "تأكيد",
                              style: TextStyle(color: Colors.white, fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(25),
                        gradient:
                        kGradientColor,
                      ),
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
