import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/models/MissingKidsModel.dart';
import 'package:nbtt_masr/models/multiImageModel.dart';
import 'package:nbtt_masr/service/missingKid_service.dart';

import 'components/logoRow.dart';

class MissingConfirmationPage extends StatefulWidget {
  //final MissingKidsModel model;
  //final List<MultiImageModel> listOfObjects ;

  //const MissingConfirmationPage({Key key, this.model}) : super(key: key);
  @override
  _MissingConfirmationPageState createState() => _MissingConfirmationPageState();
}

class _MissingConfirmationPageState extends State<MissingConfirmationPage> {
  bool isLoading = false;
  MissingKidService get missingKidService => GetIt.instance<MissingKidService>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: screenHeight * 0.05),
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
              LogoRow(screenHeight: screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'الإبلاغ عن طفل مفقود',
                    style: TextStyle(
                      color: Color(0xFFFEDA90),
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('جميع البيانات المقدمة من خلال الاستمارة تخظى بالسرية التامة',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: screenWidth * 0.04,
                    ),)
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
