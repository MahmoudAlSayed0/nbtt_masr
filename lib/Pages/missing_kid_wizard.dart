import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/Pages/success_screen.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/helpers/dateFormake.dart';
import 'package:nbtt_masr/models/DisabilityModel.dart';
import 'package:nbtt_masr/models/DistrictModel.dart';
import 'package:nbtt_masr/models/GoverModel.dart';
import 'package:nbtt_masr/models/MissingKidsModel.dart';
import 'package:get_it/get_it.dart';

import 'package:nbtt_masr/models/MissingTypeModel.dart';
import 'package:nbtt_masr/models/multiImageModel.dart';
import 'package:nbtt_masr/service/missingKid_service.dart';
import 'package:nbtt_masr/service/sqlite_service/dbhelper.dart';

import 'components/logoRow.dart';
import 'components/mainDrawer.dart';


String? message;

class WizardFormBloc extends FormBloc<String, String> {
  final reporterName = TextFieldBloc();
  Future<String?> validateReporterName(String reporterName) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (reporterName.isEmpty) {
      return 'من فضلك ادخل اسم المبلغ';
    }
    return null;
  }
  final nationalId = TextFieldBloc();
  Future<String?> validateNationalId(String nationalId) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (nationalId.isEmpty) {
      return 'من فضلك ادخل الرقم قومي';
    }else if(nationalId.length != 14){
      return 'من فضلك ادخل رقم قومي صحيح';
    }
    return null;
  }
  final mobile = TextFieldBloc();
  Future<String?> validateMobile(String mobile) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (mobile.isEmpty) {
      return 'من فضلك ادخل رقم تليفون ';
    }else if(mobile.length != 11){
      return 'من فضلك ادخل رقم تليفون صحيح';
    }
    return null;
  }
  final address = TextFieldBloc();

  final relativeRelation = TextFieldBloc();

  int? govers;
  String? goversName;
  bool validateGove = false;
  int? districts;
  String? districtsName;
  bool validateDistrict = false;

  final kidName = TextFieldBloc();
  Future<String?> validateKidName(String kidName) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (kidName.isEmpty) {
      return 'من فضلك ادخل اسم الطفل';
    }
    return null;
  }
  String? kidImage ;
  String gender = 'ذكر';

  var goodValue;
  var patientValue;
  var disabilityValue;
  final kidBirthdate = InputFieldBloc<DateTime, Object>(initialValue: DateTime.now());

  final kidAge = TextFieldBloc();
  Future<String?> validatekidAge(String kidAge) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (kidAge.isEmpty) {
      return 'من فضلك ادخل عمر الطفل';
    }
    if(int.parse(kidAge) > 18 ){
      return 'يجب سن الطفل لا يتعدى ال ١٨ سنة';
    }
    return null;
  }
  int? missingType;
  final missingKidDate = InputFieldBloc<DateTime, Object>(initialValue: DateTime.now());
  Future<String?> validateMissingKidDate(DateTime? missingKidDate) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (missingKidDate == null) {
      return 'من فضلك ادخل تاريخ فقد الطفل';
    }
    return null;
  }
  final missingAddress = TextFieldBloc();
  Future<String?> validateMissingAddress(String missingAddress) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (missingAddress.isEmpty) {
      return 'من فضلك ادخل عنوان فقد الطفل';
    }
    return null;
  }
  int? missingKidGover;
  bool validateMissingKidGover = false;
  int? missingKidDistrict;
  bool validateMissingKidDistrict = false;
  final isMissingBefore = SelectFieldBloc(
    items: ['لا', 'نعم', 'لا يعرف'],
  );
  final howFound = TextFieldBloc();
  List<int> disabilityMultiSelect = <int>[];
  List<String> disabilityName = <String>[];

  final testText = TextFieldBloc();
  final clothesDescription = TextFieldBloc();

  final circumstances = TextFieldBloc();

  String? noRecordLost;
  String? policeStation ;
/*
  DateTime recordDate ;
*/
  String? recordImage ;
  //int kidHavePaper = 1;
  String? paperName ;
  final paperImage = TextFieldBloc();
  List<int> healthStat = <int>[];
  List<String> healthStatName = <String>[];
  List<String> attachment = <String>[];
  List<String> doc = <String>[];
  int _isMissingValue = 2;
  String _isMissingText = 'لا';
  int _isRecordBefore = 2;
  String _isRecordBeforeText = 'لا';
  var listOfDocs = <MultiImageModel>[];
  bool isMissingTybeValid = false;

  DateTime? recordDate ;
  Future<String?> validaterecordDate(DateTime? recordDate) async{
    await Future.delayed(Duration(milliseconds: 200));
    if (recordDate == null && _isRecordBeforeText == 'نعم') {
      return 'من فضلك ادخل تاريخ ميلاد الطفل';
    }
    return null;
  }
  WizardFormBloc() {
    reporterName.addAsyncValidators([validateReporterName]);
    nationalId.addAsyncValidators([validateNationalId]);
    mobile.addAsyncValidators([validateMobile]);
    //address.addAsyncValidators([validateAddress]);
    //relativeRelation.addAsyncValidators([validateRelativeRelation]);
    kidName.addAsyncValidators([validateKidName]);
    kidAge.addAsyncValidators([validatekidAge]);
    //kidBirthdate.addAsyncValidators([validateKidBirthdate]);
    missingKidDate.addAsyncValidators([validateMissingKidDate]);
    missingAddress.addAsyncValidators([validateMissingAddress]);
    //clothesDescription.addAsyncValidators([validateClothesDescription]);
    //circumstances.addAsyncValidators([validateCircumstances]);
   // recordDate.addAsyncValidators([validaterecordDate]);
    addFieldBlocs(
      step: 0,
      fieldBlocs: [kidName, /*healthCase, kidBirthdate,*/kidAge,missingKidDate,
        missingAddress, isMissingBefore, clothesDescription, circumstances,//recordDate
      ],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [reporterName, nationalId, mobile, address, relativeRelation],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [paperImage],
    );
    addFieldBlocs(
      step: 3,
      fieldBlocs: [testText],
    );
  }

  //bool _showEmailTakenError = true;
  MissingKidService get missingKidService => GetIt.instance<MissingKidService>();

  @override
  void onSubmitting() async {
    print('kidName  ' + kidName.value);
     if (state.currentStep == 0) {
      await Future.delayed(const Duration(milliseconds: 500));

      if(missingKidGover == null){
        validateMissingKidGover = true;
        emitFailure();
      }else if (missingKidDistrict == null){
        validateMissingKidDistrict = true;
        emitFailure();
      }/*else if (kidImage.isEmpty){
        emitFailure();
      } */else if(missingType == null){
        isMissingTybeValid = true;
        emitFailure();
      } else if (_isRecordBefore == 1 && noRecordLost == null){
        emitFailure();
      } else if (_isRecordBefore == 1 && policeStation == null){
        emitFailure();
      } else if (_isRecordBefore == 1 && recordDate == null){
        emitFailure();
      }else{
        validateMissingKidGover = false;
        validateMissingKidDistrict = false;
        emitSuccess();
      }
    }
     else if (state.currentStep == 1) {
       emitSuccess(canSubmitAgain: true);
     }
     else if(state.currentStep == 2) {

      emitSuccess();
    }
    else if (state.currentStep == 3) {
      await Future.delayed(Duration(milliseconds: 500));
      for(int i=0;i< listOfDocs.length; i++){
        attachment.add(listOfDocs[i].imageName);
        List<int> imageBytes =  listOfDocs[i].imageFile.readAsBytesSync();
        doc.add(base64Encode(imageBytes));
      }
      //emitSuccess();
      final model = MissingKidsModel(
        reporterName: reporterName.value,
        nationalId: nationalId.value,
        phoneNumber: mobile.value,
        relativeRelation: relativeRelation.value,
        goverId: govers,
        districtId: districts,
        address: address.value,
        kidName: kidName.value,
        kidImage: kidImage!,
        kidGender: gender,
        healthStat: healthStat,
        typeofDisability: disabilityMultiSelect,
        //kidBirthDate: kidBirthdate.value,
        kidAge: kidAge.valueToInt!,
        typeOfMissing: missingType!,
        kidMissingDate: missingKidDate.value,
        missingInGover: missingKidGover!,
        missingInDistrict: missingKidDistrict!,
        missingAddress: missingAddress.value,
        isMissingBefore: _isMissingValue,
        shirtDescription: clothesDescription.value,
        kidClothesDescription: circumstances.value,
        recordLost: _isRecordBefore,
        noRecordLost: noRecordLost,
        policeStation: policeStation,
        recordDate: recordDate,
        recordImage: recordImage,
        havePaper: 1,
        attachmentName : attachment,
        attachmentDoc : doc,
      );

     /* Navigator.push(context, MaterialPageRoute(builder:
          (context) => MissingConfirmationPage(model: model),));*/
      //print(model.toJson());
      //try{

        final result = await missingKidService.createMissingKid(model);
      message = result.message;
      print(result.message);
        if(result.isValid){
          emitSuccess(canSubmitAgain: true);
        }else{
          emitFailure();
        }


    /*  }catch(e){
        print(e);
      }*/
      /*  print(govers);
      print(districts);*/
    }
  }
}

class WizardForm extends StatefulWidget {
  const WizardForm({Key? key}) : super(key: key);
  @override
  _WizardFormState createState() => _WizardFormState();
}

class _WizardFormState extends State<WizardForm> {
  var _type = StepperType.horizontal;
  bool good = false;
  bool patient = false;
  bool disability = false;
  bool _visibleButton = false;
  bool _visible = false;
  bool _visibleRecord = false;
  bool _visibledoc = false;
  bool _visibleMoreDoc = false;
  IsHavePaper _knowSaver = IsHavePaper.No;
  IsMissingBefore _isMissingBefore = IsMissingBefore.No;
  IsRecordBefore _isRecordBefore = IsRecordBefore.No;
  IsHavePaper _isHavePaper = IsHavePaper.Yes;
  TextEditingController recordNo = TextEditingController();
  TextEditingController _paperName = TextEditingController();
  TextEditingController policeStation = TextEditingController();

  File? _recordImage;


  File? _paperImage;

  Future getPaperImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _paperImage = File(pickedFile!.path);
    });
  }

  File? _kidImage;

  int imageIndex = 0;
  List<String> attachmentName = <String>[];
  List<String> attachmentDoc = <String>[];

  final ScrollController _scrollController = ScrollController();

  late Future<void> _initForm;
  final _stateList = <GoverModel>[];
  final _cityList = <DistrictModel>[];

  final _stateSecondList = <GoverModel>[];
  final _citySecondList = <DistrictModel>[];

  final _missingTypeList = <MissingTypeModel>[];
  final _disabilityList = <DisabilityModel>[];

  GoverModel? selectedState;
  DistrictModel? selectedCity;

  GoverModel? selectedSecondState;
  DistrictModel? selectedSecondCity;

  GoverModel? selectedThirdState;
  DistrictModel? selectedThirdCity;

  MissingTypeModel? selectedLossType;
  DisabilityModel? selectedDisability;

  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;
  FocusNode? pin7FocusNode;
  FocusNode? pin8FocusNode;
  FocusNode? pin9FocusNode;
  FocusNode? pin10FocusNode;
  FocusNode? pin11FocusNode;
  FocusNode? pin12FocusNode;
  FocusNode? pin13FocusNode;
  FocusNode? pin14FocusNode;
  FocusNode? pin15FocusNode;
  FocusNode? pin16FocusNode;
  FocusNode? pin17FocusNode;
  FocusNode? pin18FocusNode;
  FocusNode? pin19FocusNode;
  FocusNode? pin20FocusNode;
  FocusNode? pin21FocusNode;
  FocusNode? pin22FocusNode;

  late DBHelper helper;

  @override
  void initState() {
    super.initState();
    helper= new DBHelper();
    _initForm = _initStateAsync();

    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    pin7FocusNode = FocusNode();
    pin8FocusNode = FocusNode();
    pin9FocusNode = FocusNode();
    pin10FocusNode = FocusNode();
    pin11FocusNode = FocusNode();
    pin12FocusNode = FocusNode();
    pin13FocusNode = FocusNode();
    pin14FocusNode = FocusNode();
    pin15FocusNode = FocusNode();
    pin16FocusNode = FocusNode();
    pin17FocusNode = FocusNode();
    pin18FocusNode = FocusNode();
    pin19FocusNode = FocusNode();
    pin20FocusNode = FocusNode();
    pin21FocusNode = FocusNode();
    pin22FocusNode = FocusNode();
  }

  Future<void> _initStateAsync() async {
    _stateList.clear();
    _stateList.addAll(await helper.allGovers());
    _stateSecondList.addAll(await helper.allGovers());
    _missingTypeList.addAll(await helper.allLossTypes());
    _disabilityList.addAll(await helper.allDisability());
  }

  Future<List<DistrictModel>> _fetchCityList(String id) async {
    await Future.delayed(Duration(milliseconds: 200));

    final _newCityList = <DistrictModel>[];
    List<DistrictModel> data = <DistrictModel>[];
    data.addAll(await helper.allDistricts());
    for (int i = 0;i< data.length; i++){
      if(data[i].goverId == id){
        _newCityList.add(DistrictModel(districtId: data[i].districtId.toString(),districtName: data[i].districtName
            ,goverId: data[i].goverId));
      }
    }
    return _newCityList.toList();
  }


  void _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CupertinoActivityIndicator(animating: true),
          ),
        );
      },
    );
  }

  var listOfObjects = <MultiImageModel>[];
  removePaper(int index){
    var temp = <MultiImageModel>[];
    for(int i = 0 ; i<listOfObjects.length ; i++){
      if(listOfObjects[i].imageIndex != index){
        temp.add(MultiImageModel(imageName: listOfObjects[i].imageName,imageFile: listOfObjects[i].imageFile,
            imageIndex: listOfObjects[i].imageIndex));
      }
    }
    setState(() {
      listOfObjects = temp;
    });
  }
  TextEditingController recordDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _visibleDateValidation  = true;


  @override
  void dispose() {
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
    pin7FocusNode!.dispose();
    pin8FocusNode!.dispose();
    pin9FocusNode!.dispose();
    pin10FocusNode!.dispose();
    pin11FocusNode!.dispose();
    pin12FocusNode!.dispose();
    pin13FocusNode!.dispose();
    pin14FocusNode!.dispose();
    pin15FocusNode!.dispose();
    pin16FocusNode!.dispose();
    pin17FocusNode!.dispose();
    pin18FocusNode!.dispose();
    pin19FocusNode!.dispose();
    pin20FocusNode!.dispose();
    pin21FocusNode!.dispose();
    pin22FocusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    var pageWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => WizardFormBloc(),
      child: Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              endDrawer:
                  MainDrawer(screenHeight: pageHeight, screenWidth: pageWidth),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: pageWidth * 0.08),
                    child: Container(
                      width: pageWidth * 0.15,
                      height: pageHeight * 0.14,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(FontAwesomeIcons.question,color: kRedColor,size: pageWidth * 0.1,),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context){
                                return Stack(
                                  //alignment: Alignment.center,
                                  children: [
                                    Image.asset("assets/images/iPhone 6, 7, 8 – 52.png",
                                        width: double.infinity,height: pageHeight,
                                        fit: BoxFit.fill),
                                    Transform.translate(
                                      offset: Offset(pageWidth * 0.04, pageHeight * 0.1),
                                      child: RaisedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                              size: pageWidth * 0.04,color: Colors.white,),
                                            Text("تخطى",style: TextStyle(
                                                fontSize: pageWidth * 0.06,
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

                actions: <Widget>[
                  /*IconButton(
                    padding: EdgeInsets.only(bottom: pageHeight * 0.1),
                      icon: Icon(_type == StepperType.horizontal
                          ? Icons.swap_vert
                          : Icons.swap_horiz),
                      onPressed: _toggleType)*/
                ],
              ),
              body: FutureBuilder(
                future: _initForm,
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        LogoRow(screenHeight: pageHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'الإبلاغ عن طفل مفقود',
                              style: TextStyle(
                                color: Color(0xFFFEDA90),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('جميع البيانات المقدمة من خلال الاستمارة تحظى بالسرية التامة',
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: pageWidth * 0.04,
                              ),)
                          ],
                        ),
                        Container(
                          height: pageHeight * 0.7,
                          child: FormBlocListener<WizardFormBloc, String, String>(
                            onSubmitting: (context, state) => LoadingDialog.show(context),
                            onSubmissionFailed: (context, state) => LoadingDialog.hide(context),
                            onSuccess: (context, state) {
                              LoadingDialog.hide(context);

                              if (state.stepCompleted == state.lastStep) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => SuccessScreen()));
                              }
                            },
                            onFailure: (context, state) {
                              LoadingDialog.hide(context);
                              showDialog(context: context,builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: pageHeight * 0.04,),
                                        Center(
                                          child: Text(message ?? 'من فضلك قم اكمل البيانات',
                                            style: TextStyle(
                                                color: kTextColor,
                                                fontSize: 18,
                                                height: 1
                                            ),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            //overflow: TextOverflow.ellipsis,
                                            //maxLines: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });

                            },
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: StepperFormBlocBuilder<WizardFormBloc>(
                                formBloc: context.read<WizardFormBloc>(),
                                type: _type,
                                physics: ClampingScrollPhysics(),
                                controlsBuilder: (context, onStepContinue,
                                    onStepCancel, step, formBloc) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: pageHeight * 0.02),
                                        child: Container(
                                          width: pageWidth * 0.40,
                                          height: pageHeight * 0.07,
                                          child: FlatButton(
                                            onPressed: onStepCancel,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  Icons.arrow_back_rounded,
                                                  color:  step == 0 ? Color(0xFFe4e4e4) : kTextColor,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'السابق',
                                                  style:  TextStyle(
                                                      color:  step == 0 ? Color(0xFFe4e4e4) : kTextColor,
                                                      fontSize: 25,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),

                                            color: step == 0 ? Color(0xFFe4e4e4) : Colors.transparent,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: Colors.grey
                                              )
                                          ),
                                        ),
                                      ),
                                      new Padding(
                                        padding: new EdgeInsets.all(10),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(top: pageHeight * 0.02),
                                        child: Container(
                                          width: pageWidth * 0.40,
                                          height: pageHeight * 0.07,
                                          child: FlatButton(
                                            onPressed: () {
                                              onStepContinue!();
                                              setState(() {
                                                _visibleButton = false;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  step == 3 ? "تأكيد" : "التالى",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: kGradientColor,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),

                                    ],
                                  );
                                },
                                stepsBuilder: (formBloc) {
                                  return [
                                    _personalStep(
                                        formBloc!, pageWidth, pageHeight),
                                    _accountStep(
                                        formBloc, pageWidth, pageHeight),
                                    _socialStep(
                                        formBloc, pageWidth, pageHeight),
                                    _confirmation(
                                        formBloc, pageWidth, pageHeight),
                                  ];
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
  FormBlocStep _personalStep(
      WizardFormBloc wizardFormBloc, var pageWidth, var pageHeight) {
    return FormBlocStep(
      title: Text(''),
      content: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'بيانات الطفل',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'بيانات الطفل',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.kidName,
            keyboardType: TextInputType.text,
            textDirection: TextDirection.rtl,
            //nextFocusNode: pin8FocusNode,
            decoration: InputDecoration(
              labelText: 'اسم الطفل',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: pageWidth * 0.02),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onTap: () async{
                  final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

                  setState(() {
                    _kidImage = File(pickedFile!.path);
                    List<int> imageBytes = _kidImage!.readAsBytesSync();
                    //String base64Image = base64.encode(imageBytes);
                    wizardFormBloc.kidImage = base64.encode(imageBytes);
                  });
                },
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "صورة الطفل",
                  prefixIcon: Icon(Icons.upload_rounded),
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
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if(_kidImage == null){
                    return 'من فضلك قم بتحميل صورة الطفل';
                  }else{
                    return null;
                  }
                },
                textDirection: TextDirection.rtl,
                readOnly: true,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kidImage == null
                  ? Text(
                '',
                style: TextStyle(fontSize: 20),
              )
                  : Container(
                child: Image.file(
                  _kidImage!,
                ),
                height: pageHeight * 0.1,
                width: pageWidth * 0.7,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('نوع الطفل',style:
              TextStyle(color: kTextColor,fontSize: pageWidth * 0.045),),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: pageWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'ذكر',
                  style: TextStyle(fontSize: 20.0),
                ),
                Radio(
                  value: IsHavePaper.No,
                  activeColor: kGreenColor,
                  groupValue: _knowSaver,
                  onChanged: (IsHavePaper? value) {
                    setState(() {
                      _knowSaver = value!;
                      wizardFormBloc.gender = 'ذكر';
                    });
                  },
                ),
                Text(
                  'انثى',
                  style: new TextStyle(fontSize: 20.0),
                ),
                Radio(
                  activeColor: kGreenColor,
                  value: IsHavePaper.Yes,
                  groupValue: _knowSaver,
                  onChanged: (IsHavePaper? value) {
                    setState(() {
                      _knowSaver = value!;
                      wizardFormBloc.gender = 'انثى';
                    });
                  },
                ),

              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'الحالة الصحية للطفل',
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                right: pageWidth * 0.02,
                // left: pageWidth * 0.04,
                top: pageWidth * 0.02),
            child: Row(
              children: [
                Text(
                  'سليم',
                  style: TextStyle(fontSize: 18, color: kTextColor),
                ),
                Checkbox(
                  value: good,
                  activeColor: kGreenColor,
                  onChanged: (value) {
                    setState(() {
                      good = value!;
                      disability = false;
                      patient = false;
                      _visible = false;
                      if (value == true) {
                        wizardFormBloc.healthStat.add(1);
                        wizardFormBloc.healthStatName.add('سليم');
                        for(int i=0;i<wizardFormBloc.healthStat.length;i++){
                          if(wizardFormBloc.healthStat[i] != 1)
                            wizardFormBloc.healthStat.removeAt(i);
                        }
                        wizardFormBloc.healthStat = wizardFormBloc.healthStat.toSet().toList();
                        if(wizardFormBloc.disabilityMultiSelect.length != 0){
                          wizardFormBloc.disabilityMultiSelect.clear();
                          wizardFormBloc.disabilityName.clear();
                        }

                        for(int i=0;i<wizardFormBloc.healthStatName.length;i++){
                          if(wizardFormBloc.healthStatName[i] != 'سليم')
                            wizardFormBloc.healthStatName.removeAt(i);
                        }
                        wizardFormBloc.healthStatName = wizardFormBloc.healthStatName.toSet().toList();

                      } else {
                        wizardFormBloc.healthStat.remove(1);
                        wizardFormBloc.healthStatName.remove('سليم');
                      }
                      //typeValue = 'الطفل';
                    });
                  },
                ),

                SizedBox(
                  width: pageWidth * 0.18,
                ),
                Text(
                  'مريض بمرض مزمن',
                  style: TextStyle(fontSize: 18, color: kTextColor),
                ),
                Checkbox(
                  value: patient,
                  activeColor: kGreenColor,
                  onChanged: (value) {
                    setState(() {
                      patient = value!;
                      good = false;
                      if (value == true) {
                        wizardFormBloc.healthStat.add(2);
                        wizardFormBloc.healthStatName.add('مريض بمرض مزمن');
                        for(int i=0;i<wizardFormBloc.healthStat.length;i++){
                          if(wizardFormBloc.healthStat[i] == 1)
                            wizardFormBloc.healthStat.removeAt(i);
                        }
                        wizardFormBloc.healthStat = wizardFormBloc.healthStat.toSet().toList();

                        for(int i=0;i<wizardFormBloc.healthStatName.length;i++){
                          if(wizardFormBloc.healthStatName[i] != 'مريض بمرض مزمن')
                            wizardFormBloc.healthStatName.removeAt(i);
                        }
                        wizardFormBloc.healthStatName = wizardFormBloc.healthStatName.toSet().toList();

                      } else {
                        wizardFormBloc.healthStat.remove(2);
                        wizardFormBloc.healthStatName.remove('مريض بمرض مزمن');
                      }
                      //typeValue = 'الام';
                    });
                  },
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: pageWidth * 0.02,
                //left: pageWidth * 0.08,
                top: pageWidth * 0.02),
            child: Row(
              children: [
                Text(
                  'ذوى اعاقة',
                  style: TextStyle(fontSize: 18, color: kTextColor),
                ),
                Checkbox(
                  value: disability,
                  activeColor: kGreenColor,
                  onChanged: (value) {
                    setState(() {
                      disability = value!;
                      good = false;
                      if (value == true) {
                        _visible = true;
                        wizardFormBloc.healthStat.add(3);
                        wizardFormBloc.healthStatName.add('ذوى اعاقة');
                        for(int i=0;i<wizardFormBloc.healthStat.length;i++){
                          if(wizardFormBloc.healthStat[i] == 1)
                            wizardFormBloc.healthStat.removeAt(i);
                        }
                        wizardFormBloc.healthStat = wizardFormBloc.healthStat.toSet().toList();
                        for(int i=0;i<wizardFormBloc.healthStatName.length;i++){
                          if(wizardFormBloc.healthStatName[i] != 'ذوى اعاقة')
                            wizardFormBloc.healthStatName.removeAt(i);
                        }
                        wizardFormBloc.healthStatName = wizardFormBloc.healthStatName.toSet().toList();

                      } else {
                        _visible = false;
                        wizardFormBloc.healthStat.remove(3);
                        wizardFormBloc.healthStatName.remove('ذوى اعاقة');
                      }
                      //typeValue = 'الام';
                    });
                  },
                ),

              ],
            ),
          ),
          Visibility(
            visible: wizardFormBloc.healthStat.length == 0 ? true : false,
            child: Row(
              children: [
                Text(
                  'من فضلك اختر الحالة الصحية للطفل',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _visible,
            child: Padding(
              padding: EdgeInsets.only(top: pageHeight * 0.02,bottom: pageHeight *0.015),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButtonFormField<DisabilityModel>(
                  decoration: InputDecoration(
                    labelText: "نوع الاعاقة",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  validator: wizardFormBloc.healthStat.contains(3) ?  (value) {
                    if(value == null){
                      return 'من فضلك اختر نوع الاعاقة';
                    }
                    else{
                      return null;
                    }
                  } : null,
                  items: _disabilityList
                      .map((itm) => DropdownMenuItem(
                    child: Container(
                      child: Text(itm.name, textAlign: TextAlign.right),
                      alignment: Alignment.centerRight,
                    ),
                    value: itm,
                  ))
                      .toList(),
                  value: selectedDisability,
                  onChanged: (value) {
                    setState(() {
                      this.selectedDisability = value!;
                      wizardFormBloc.disabilityMultiSelect.add(value.id);
                      wizardFormBloc.disabilityName.add(value.name);
                    });
                  },
                ),
              ),
            ),
          ),
          /*DateTimeFieldBlocBuilder(
            textDirection: TextDirection.rtl,
            dateTimeFieldBloc: wizardFormBloc.kidBirthdate,
            nextFocusNode: pin8FocusNode,
            pickerBuilder: (context, child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.green,
                      primaryColorDark: Colors.green,
                      accentColor: Colors.green,
                    ),
                    dialogBackgroundColor:Colors.white,
                  ),
                  child: child
              );
            },
            firstDate: DateTime(1995),
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
            format: DateFormat('yyyy-MM-dd'),
            decoration: InputDecoration(
              labelText: 'تاريخ ميلاد الطفل:',
              prefixIcon: Icon(Icons.cake),
            ),
          ),*/
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.kidAge,
            keyboardType: TextInputType.number,
            maxLength: 2,
            textDirection: TextDirection.rtl,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            //focusNode: pin8FocusNode,
            decoration: InputDecoration(
              labelText: 'عمر الطفل',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.02,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'تفاصيل فقد الطفل',
                  style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          DateTimeFieldBlocBuilder(
            textDirection: TextDirection.rtl,
            dateTimeFieldBloc: wizardFormBloc.missingKidDate,
            focusNode: pin10FocusNode,
            // nextFocusNode: pin11FocusNode,
            pickerBuilder: (context, child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.green,
                      primaryColorDark: Colors.green,
                      accentColor: Colors.green,
                    ),
                    dialogBackgroundColor:Colors.white,
                  ),
                  child: child!
              );
            },
            firstDate: DateTime(1995),
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
            format: DateFormat('yyyy-MM-dd'),
            decoration: InputDecoration(
              labelText: 'تاريخ فقد الطفل:',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.02,bottom: pageHeight * 0.015),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<MissingTypeModel>(
                decoration: InputDecoration(
                  labelText: "تصنيف فقد الطفل",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                ),
                /* autovalidate: true,
                validator: (value) {
                  if(value == null){
                    return 'من فضلك اختر تصنيف فقد الطفل';
                  }
                  else{
                    return null;
                  }
                },*/
                items: _missingTypeList
                    .map((itm) => DropdownMenuItem(
                  child: Container(
                    child: Text(itm.name, textAlign: TextAlign.right),
                    alignment: Alignment.centerRight,
                  ),
                  value: itm,
                ))
                    .toList(),
                value: selectedLossType,
                onChanged: (value) {
                  setState(() {
                    this.selectedLossType = value!;
                    wizardFormBloc.missingType = value.id;
                  });
                },
              ),
            ),
          ),
          Visibility(
            visible: wizardFormBloc.missingType != null ? false : true,
            child: Row(
              children: [
                Text(
                  'من فضلك اختر تصنيف فقد الطفل',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'هل سبق فقد الطفل ؟',
                  style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: pageWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'لا',
                  style: TextStyle(fontSize: 20.0),
                ),
                Radio(
                  value: IsMissingBefore.No,
                  activeColor: kGreenColor,
                  groupValue: _isMissingBefore,
                  onChanged: (IsMissingBefore? value) {
                    setState(() {
                      _isMissingBefore = value!;
                      wizardFormBloc._isMissingValue = 2;
                      wizardFormBloc._isMissingText = 'لا';
                    });
                  },
                ),
                Text(
                  'نعم',
                  style: new TextStyle(fontSize: 20.0),
                ),
                Radio(
                  activeColor: kGreenColor,
                  value: IsMissingBefore.Yes,
                  groupValue: _isMissingBefore,
                  onChanged: (IsMissingBefore? value) {
                    setState(() {
                      _isMissingBefore = value!;
                      wizardFormBloc._isMissingValue = 1;
                      wizardFormBloc._isMissingText = 'نعم';
                    });
                  },
                ),
                Text(
                  'لا اعرف',
                  style: new TextStyle(fontSize: 20.0),
                ),
                Radio(
                  activeColor: kGreenColor,
                  value: IsMissingBefore.DoNotKnow,
                  groupValue: _isMissingBefore,
                  onChanged: (IsMissingBefore? value) {
                    setState(() {
                      _isMissingBefore = value!;
                      wizardFormBloc._isMissingValue = 3;
                      wizardFormBloc._isMissingText = 'لا اعرف';
                    });
                  },
                ),

              ],
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.howFound,
            keyboardType: TextInputType.text,
            maxLines: 2,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'كيف تم العثور عليه ؟',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.015,bottom: pageHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'مكان فقد الطفل',
                  style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.02),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<GoverModel>(
                decoration: InputDecoration(
                  labelText: "اختر المحافظة",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                ),
                items: _stateSecondList
                    .map((itm) => DropdownMenuItem(
                  child: Container(
                    child: Text(itm.goverName, textAlign: TextAlign.right),
                    alignment: Alignment.centerRight,
                  ),
                  value: itm,
                ))
                    .toList(),
                value: selectedSecondState,
                onChanged: (value) async {
                  _showLoadingDialog();
                  final cityList = await _fetchCityList(value!.goverId);
                  setState(() {
                    this.selectedSecondState = value;
                    wizardFormBloc.missingKidGover = int.parse(value.goverId);
                    selectedSecondCity = null;
                    _citySecondList.clear();
                    _citySecondList.addAll(cityList);
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Visibility(
            visible: wizardFormBloc.missingKidGover != null ? false : true,
            child: Row(
              children: [
                Text(
                  'من فضلك اختر المحافظة التي فقد فيها الطفل',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.02),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<DistrictModel>(
                decoration: InputDecoration(
                  labelText: "اختر المركز",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                ),
                /*autovalidate: true,
                validator: (value) {
                  if(value == null){
                    return 'من فضلك اختر المركز الذي فقد فيها الطفل';
                  }
                  else{
                    return null;
                  }
                },*/
                items: _citySecondList
                    .map((itm) => DropdownMenuItem(
                  child: Container(
                    child: Text(itm.districtName, textAlign: TextAlign.right),
                    alignment: Alignment.centerRight,
                  ),
                  value: itm,
                ))
                    .toList(),
                value: selectedSecondCity,
                onChanged: (value) {
                  setState(() {
                    this.selectedSecondCity = value;
                    wizardFormBloc.missingKidDistrict =
                        int.parse(value!.districtId);
                  });
                },
              ),
            ),
          ),
          Visibility(
            visible: wizardFormBloc.missingKidDistrict != null ? false : true,
            child: Row(
              children: [
                Text(
                  'من فضلك اختر المركز التي فقد فيها الطفل',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.missingAddress,
            keyboardType: TextInputType.text,
            maxLines: 2,
            textDirection: TextDirection.rtl,
            focusNode: pin13FocusNode,
            decoration: InputDecoration(
              labelText: 'عنوان فقد الطفل',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.015,bottom: pageHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'مواصفات ملابس الطفل وعلامات مميزة له',
                  style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.clothesDescription,
            keyboardType: TextInputType.text,
            maxLines: 2,
            textDirection: TextDirection.rtl,
            focusNode: pin15FocusNode,
            nextFocusNode: pin16FocusNode,
            decoration: InputDecoration(
              labelText: 'مواصفات ملابس الطفل',
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.circumstances,
            keyboardType: TextInputType.text,
            maxLines: 2,
            textDirection: TextDirection.rtl,
            focusNode: pin16FocusNode,
            /*   onTap: () {
              setState(() {
                _visibleButton = true;
              });
            },
            onSubmitted: (value) {
              setState(() {
                _visibleButton = false;
              });
            },*/
            decoration: InputDecoration(
              labelText: 'ملابسات فقد الطفل',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.015,bottom: pageHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'بيانات المحضر',
                  style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'هل تم عمل محضر فقد للطفل ؟',
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: pageWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'لا',
                  style: TextStyle(fontSize: 20.0),
                ),
                Radio(
                  value: IsRecordBefore.No,
                  activeColor: kGreenColor,
                  groupValue: _isRecordBefore,
                  onChanged: (IsRecordBefore? value) {
                    setState(() {
                      _isRecordBefore = value!;
                      wizardFormBloc._isRecordBefore = 2;
                      wizardFormBloc._isRecordBeforeText = 'لا';
                      _visibleRecord = false;
                    });
                  },
                ),
                Text(
                  'نعم',
                  style: new TextStyle(fontSize: 20.0),
                ),
                Radio(
                  activeColor: kGreenColor,
                  value: IsRecordBefore.Yes,
                  groupValue: _isRecordBefore,
                  onChanged: (IsRecordBefore? value) {
                    setState(() {
                      _isRecordBefore = value!;
                      wizardFormBloc._isRecordBefore = 1;
                      wizardFormBloc._isRecordBeforeText = 'نعم';
                      _visibleRecord = true;
                    });
                  },
                ),
                Text(
                  'لا اعرف',
                  style: new TextStyle(fontSize: 20.0),
                ),
                Radio(
                  activeColor: kGreenColor,
                  value: IsRecordBefore.DoNotKnow,
                  groupValue: _isRecordBefore,
                  onChanged: (IsRecordBefore? value) {
                    setState(() {
                      _isRecordBefore = value!;
                      wizardFormBloc._isRecordBefore = 3;
                      wizardFormBloc._isRecordBeforeText = 'لا اعرف';
                      _visibleRecord = false;
                    });
                  },
                ),

              ],
            ),
          ),
          Visibility(
            visible: _visibleRecord,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageWidth * 0.02),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: recordNo,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "رقم المحضر",
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
                 /* autovalidate: true,
                  validator:  wizardFormBloc._isRecordBefore == 1 ? (value) {
                    if(value.isEmpty){
                      return 'من فضلك ادخل رقم المحضر';
                    }
                    else{
                      return null;
                    }
                  } : null,*/
                  onChanged: (value) {
                    setState(() {
                      wizardFormBloc.noRecordLost = value;
                    });
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visibleRecord && wizardFormBloc.noRecordLost == null,
            child: Row(
              children: [
                Text(
                  'من فضلك ادخل رقم المحضر',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _visibleRecord,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageWidth * 0.02),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: policeStation,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "قسم الشرطة",
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
               /*   autovalidate: true,
                  validator:  wizardFormBloc._isRecordBefore == 1 ? (value) {
                    if(value.isEmpty){
                      return 'من فضلك ادخل قسم الشرطة';
                    }
                    else{
                      return null;
                    }
                  } : null,*/
                  //keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      wizardFormBloc.policeStation = policeStation.text;
                    });
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visibleRecord && wizardFormBloc.policeStation == null,
            child: Row(
              children: [
                Text(
                  'من فضلك ادخل قسم الشرطة',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _visibleRecord,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageWidth * 0.02),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  onTap: () async{

                    final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                    setState(() {
                      _recordImage = File(pickedFile!.path);
                      List<int> imageBytes = _recordImage!.readAsBytesSync();
                      wizardFormBloc.recordImage = base64.encode(imageBytes);
                    });
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "صورة المحضر",
                    prefixIcon: Icon(Icons.upload_rounded),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _recordImage == null
                  ? Text(
                '',
                style: TextStyle(fontSize: 20),
              )
                  : Container(
                child: Image.file(
                  _recordImage!,
                ),
                height: pageHeight * 0.1,
                width: pageWidth * 0.7,
              ),
            ],
          ),
          /*Visibility(
            visible: _visibleRecord,
            child: DateTimeFieldBlocBuilder(
              textDirection: TextDirection.rtl,
              dateTimeFieldBloc: wizardFormBloc.recordDate,
              pickerBuilder: (context, child) {
                return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.green,
                        primaryColorDark: Colors.green,
                        accentColor: Colors.green,
                      ),
                      dialogBackgroundColor:Colors.white,
                    ),
                    child: child
                );
              },
              //nextFocusNode: pin8FocusNode,
              firstDate: DateTime(1995),
              initialDate: DateTime.now(),
              lastDate: DateTime.now(),
              format: DateFormat('yyyy-MM-dd'),
              decoration: InputDecoration(
                labelText: 'تاريخه',
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),
          ),*/
          Visibility(
            visible: _visibleRecord,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02, bottom: pageHeight * 0.02,),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: recordDateController,
                  onTap: (){
                    showDatePicker(
                        context: context,
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.fromSwatch(
                                primarySwatch: Colors.green,
                                primaryColorDark: Colors.green,
                                accentColor: Colors.green,
                              ),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child!,
                          );
                        },
                        initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
                        firstDate: DateTime(1995),
                        lastDate: DateTime.now())
                       .then((value) {
                      if (value == null) {
                        _visibleDateValidation = true;
                        return null;
                      }
                      setState(() {
                        _visibleDateValidation = false;
                        _selectedDate = value;
                        recordDateController.text = dateFormat(_selectedDate);
                        wizardFormBloc.recordDate = _selectedDate;
                        print(wizardFormBloc.recordDate);
                      });
                    });
                  },
                  style: TextStyle(fontSize: 20,color: kTextColor),
                  decoration: InputDecoration(
                    labelText: 'تاريخه',
                    labelStyle: TextStyle(color: kTextColor),
                    prefixIcon: Icon(Icons.calendar_today_outlined,color: kTextColor,),
                    hintText: dateFormat(_selectedDate),
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
            visible: _visibleDateValidation && _visibleRecord,
            child: Row(
              children: [
                Text(
                  'من فضلك ادخل تاريخ المحضر',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _accountStep(
      WizardFormBloc wizardFormBloc, var pageWidth, var pageHeight) {
    return FormBlocStep(
      title: Text(''),
      content: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'بيانات المبلغ',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'بيانات المبلغ',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
    /*      TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.reporterName,
            keyboardType: TextInputType.text,
            //enableOnlyWhenFormBlocCanSubmit: true,
            textDirection: TextDirection.rtl,
            focusNode: pin17FocusNode,
            nextFocusNode: pin18FocusNode,
            decoration: InputDecoration(
              labelText: 'اسم المبلغ',
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.mobile,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.rtl,
            maxLength: 11,
            focusNode: pin18FocusNode,
            nextFocusNode: pin19FocusNode,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            decoration: InputDecoration(
              labelText: 'رقم التليفون',
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.nationalId,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.rtl,
            maxLength: 14,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            focusNode: pin19FocusNode,
            nextFocusNode: pin20FocusNode,
            decoration: InputDecoration(
              labelText: 'الرقم القومي',
            ),
          ),*/
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.reporterName,
            keyboardType: TextInputType.text,
            //enableOnlyWhenFormBlocCanSubmit: true,
            textDirection: TextDirection.rtl,
            focusNode: pin1FocusNode,
            nextFocusNode: pin2FocusNode,
            decoration: InputDecoration(
              labelText: 'اسم المبلغ',
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.nationalId,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.rtl,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            maxLength: 14,
            focusNode: pin2FocusNode,
            nextFocusNode: pin3FocusNode,
            decoration: InputDecoration(
              labelText: 'الرقم القومي',
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.mobile,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.rtl,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            maxLength: 11,
            focusNode: pin3FocusNode,
            decoration: InputDecoration(
              labelText: 'رقم تليفون المبلغ',
            ),
          ),

          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.relativeRelation,
            keyboardType: TextInputType.text,
            textDirection: TextDirection.rtl,
            focusNode: pin4FocusNode,
            decoration: InputDecoration(
              labelText: 'صلة القرابة بالطفل',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight*0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'عنوان المبلغ',
                  style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.02),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<GoverModel>(
                decoration: InputDecoration(
                  labelText: "اختر المحافظة",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                ),
             /*   autovalidate: true,
                validator: (value) {
                  if(value == null){
                    return 'من فضلك اختر محافظة المبلغ';
                  }
                  else{
                    return null;
                  }
                },*/
                items: _stateList
                    .map((itm) => DropdownMenuItem(
                          child: Container(
                            child: Text(itm.goverName, textAlign: TextAlign.right),
                            alignment: Alignment.centerRight,
                          ),
                          value: itm,
                        ))
                    .toList(),
                value: selectedState,
                onChanged: (value) async {
                  _showLoadingDialog();
                  final cityList = await _fetchCityList(value!.goverId);
                  setState(() {
                    this.selectedState = value;
                    wizardFormBloc.govers = int.parse(value.goverId);
                    wizardFormBloc.goversName = value.goverName;
                    selectedCity = null;
                    _cityList.clear();
                    _cityList.addAll(cityList);
                  });
                  Navigator.pop(context);
                },

              ),
            ),
          ),
         /* Visibility(
            visible: wizardFormBloc.govers != null ? false : true,
            child: Row(
              children: [
                Text(
                  'من فضلك اختر محافظة المبلغ',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),*/
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.02,bottom: pageHeight * 0.01),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<DistrictModel>(
                hint: Text("اختر المركز"),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                ),
               /* autovalidate: true,
                validator: (value) {
                  if(value == null){
                    return 'من فضلك اختر مركز المبلغ';
                  }
                  else{
                    return null;
                  }
                },*/
                items: _cityList
                    .map((itm) => DropdownMenuItem(
                          child: Container(
                            child: Text(itm.districtName, textAlign: TextAlign.right),
                            alignment: Alignment.centerRight,
                          ),
                          value: itm,
                        ))
                    .toList(),
                value: selectedCity,
                onChanged: (value) {
                  setState(() {
                    this.selectedCity = value!;
                    wizardFormBloc.districts = int.parse(value.districtId);
                    wizardFormBloc.districtsName = value.districtName;
                    FocusScope.of(context)
                        .requestFocus(pin6FocusNode);
                    _visibleButton = true;
                  });
                },
              ),
            ),
          ),
       /*   Visibility(
            visible: wizardFormBloc.districts != null ? false : true,
            child: Row(
              children: [
                Text(
                  'من فضلك اختر مركز المبلغ',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),*/
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.address,
            keyboardType: TextInputType.text,
            textDirection: TextDirection.rtl,
            focusNode: pin6FocusNode,
            onTap: () {
              setState(() {
                _visibleButton = true;
              });
            },
            onSubmitted: (value) {
              setState(() {
                _visibleButton = false;
              });
            },
            decoration: InputDecoration(
              labelText: 'العنوان',
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _socialStep(
      WizardFormBloc wizardFormBloc, var pageWidth, var pageHeight) {
    return FormBlocStep(
      title: Text(''),
      content: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'مرفقات للتعرف على الطفل',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
        /*  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'هل لدى الطفل اى أوراق تساعد في الوصول لاهله',
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: pageWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'لا',
                  style: TextStyle(fontSize: 20.0),
                ),
                Radio(
                  value: IsHavePaper.No,
                  activeColor: kGreenColor,
                  groupValue: _isHavePaper,
                  onChanged: (IsHavePaper value) {
                    setState(() {
                      _isHavePaper = value;
                      wizardFormBloc.kidHavePaper = 2;
                    });
                  },
                ),
                Text(
                  'نعم',
                  style: new TextStyle(fontSize: 20.0),
                ),
                Radio(
                  activeColor: kGreenColor,
                  value: IsHavePaper.Yes,
                  groupValue: _isHavePaper,
                  onChanged: (IsHavePaper value) {
                    setState(() {
                      _isHavePaper = value;
                      wizardFormBloc.kidHavePaper = 1;
                    });
                  },
                ),

              ],
            ),
          ),*/
          Padding(
            padding: EdgeInsets.only(
                top: pageWidth * 0.02),
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
                onFieldSubmitted: (value) {
                  wizardFormBloc.paperName = value;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: pageWidth * 0.02),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                //controller: _fileNo,
                onTap: getPaperImage,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "ملف المرفق لتحميلها",
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
          Visibility(
            visible: (_visibledoc /*&& wizardFormBloc.kidHavePaper == 1*/) ? true : false,
            child: Row(
              children: [
                Text(
                  'من فضلك ادخل المرفقات',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          Visibility(
            visible: (_visibleMoreDoc /*&& wizardFormBloc.kidHavePaper == 1*/) ? true : false,
            child: Row(
              children: [
                Text(
                  'لا يمكن ادخال اكثر من مرفقين',
                  style: TextStyle(fontSize: 14, color: kRedColor),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paperImage == null ? Text('',
                style: TextStyle(fontSize: 20),) :
              Container(child: Image.file(_paperImage!,),
                height: pageHeight * 0.1,width: pageWidth * 0.7,),
            ],
          ),
          SizedBox(height: pageHeight * 0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paperName.text != "" ? Text(_paperName.text,style: TextStyle(fontSize: 20),)
                  : Text('')
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: pageWidth * 0.45,
                  height: pageHeight * 0.07,
                  child: FlatButton(onPressed:/* wizardFormBloc.kidHavePaper == 1 ?*/ () {
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
                      setState(() {
                        _visibledoc = false;
                        listOfObjects.add(MultiImageModel(imageName: _paperName.text,imageFile:
                        _paperImage!,imageIndex : imageIndex));
                        attachmentName.add(_paperName.text);
                       /* List<int> imageBytes = _paperImage.readAsBytesSync();
                        attachmentDoc.add(base64Encode(imageBytes));
                        wizardFormBloc.attachment = attachmentName;
                        wizardFormBloc.doc = attachmentDoc;*/
                        wizardFormBloc.listOfDocs = listOfObjects;
                        imageIndex ++;
                        _paperName.clear();
                        _paperImage = null;
                      });
                    }
                  } /*: null*/,
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
          Padding(
            padding: EdgeInsets.only(top: pageHeight * 0.02),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context){
                      return Stack(
                        //alignment: Alignment.center,
                        children: [
                          Image.asset("assets/images/iPhone 6, 7, 8 – 47.png",
                              width: double.infinity,height: pageHeight,
                              fit: BoxFit.fill),
                          Transform.translate(
                            offset: Offset(pageWidth * 0.04, pageHeight * 0.1),
                            child: RaisedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back_ios,
                                    size: pageWidth * 0.04,color: Colors.white,),
                                  Text("تخطى",style: TextStyle(
                                      fontSize: pageWidth * 0.06,
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
          Visibility(
            visible: listOfObjects.length != 0 ? true : false,
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
                        height: pageHeight * 0.1,width: pageWidth * 0.3,),),
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
        ],
      ),
    );
  }

  FormBlocStep _confirmation(WizardFormBloc wizardFormBloc, var pageWidth, var pageHeight){
    return FormBlocStep(
      title: Text(''),
      content: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تأكيد البيانات',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'بيانات المبلغ',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "اسم المبلغ", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.reporterName.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "الرقم القومى", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.nationalId.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "رقم التليفون", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.mobile.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "صلة القرابة", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.relativeRelation.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'عنوان المبلغ',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "المحافظة", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.goversName == null ? '' : wizardFormBloc.goversName! ,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "المركز", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.districtsName == null ? '' : wizardFormBloc.districtsName! ,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "عنوان المبلغ",
                    style: TextStyle(
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: pageWidth * 0.04,
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    wizardFormBloc.address.value ,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'بيانات الطفل',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "اسم الطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.kidName.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02,
              bottom: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "صورة الطفل", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kidImage == null
                  ? Text(
                '',
                style: TextStyle(fontSize: 20),
              )
                  : Container(
                child: Image.file(
                  _kidImage!,
                ),
                height: pageHeight * 0.1,
                width: pageWidth * 0.4,
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "نوع الطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.gender,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "الحالة الصحية للطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  ...List.generate(wizardFormBloc.healthStatName.length, (index) =>
                      Column(
                        children: [
                          Text(
                            wizardFormBloc.healthStatName[index].toString(),
                            style: TextStyle(
                                fontSize: 18),
                          ),
                        ],
                      ),)

                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "نوع الاعاقة", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  ...List.generate(wizardFormBloc.disabilityName.length, (index) =>
                      Column(
                        children: [
                          Text(
                            wizardFormBloc.disabilityName[index],
                            style: TextStyle(
                                fontSize: 18),
                          ),
                        ],
                      ),)
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02,
                  bottom: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "عمر الطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.kidAge.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'تفاصيل فقد الطفل',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "تاريخ فقد الطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.missingKidDate.value == null ? '' :
                    dateFormat(wizardFormBloc.missingKidDate.value),
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "تصنيف فقد الطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    selectedLossType == null ? '' : selectedLossType!.name,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02,
              bottom: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "هل سبق فقد الطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc._isMissingText,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'مكان فقد الطفل',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "المحافظة", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    selectedSecondState == null ? '' : selectedSecondState!.goverName,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "المركز", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    selectedSecondCity == null ? '' : selectedSecondCity!.districtName,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "عنوان المبلغ", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    wizardFormBloc.missingAddress.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "مواصفات ملابس الطفل وعلامات مميزة له", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    wizardFormBloc.clothesDescription.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "ملابسات خاصة بفقد الطفل او العثور عليه", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    wizardFormBloc.circumstances.value,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'بيانات المحضر',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02,
                  bottom: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "هل تم عمل محضر فقد للطفل", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc._isRecordBeforeText,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "رقم المحضر", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.noRecordLost == null ? '' : wizardFormBloc.noRecordLost!,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "قسم الشرطة", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.policeStation == null ? '' : wizardFormBloc.policeStation!,
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "صورة المحضر", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _recordImage == null
                  ? Text(
                '',
                style: TextStyle(fontSize: 20),
              )
                  : Container(
                child: Image.file(
                  _recordImage!,
                ),
                height: pageHeight * 0.1,
                width: pageWidth * 0.4,
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  top: pageHeight * 0.02),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text(
                    "تاريخه", style: TextStyle(fontSize: 18),),
                  SizedBox(width: pageWidth * 0.04,),
                  Text(
                    wizardFormBloc.recordDate == null ? '' :
                    dateFormat(wizardFormBloc.recordDate!),
                    style: TextStyle(
                        fontSize: 18),
                  ),
                ],
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
                  ],
                  rows: listOfObjects.map((e) =>
                      DataRow(cells: <DataCell>[
                        DataCell(e.imageFile == null ?
                        Text('',
                          style: TextStyle(fontSize: 20),) :
                        Container(child: Image.file(e.imageFile,),
                          height: pageHeight * 0.1,width: pageWidth * 0.3,),),
                        DataCell(Text(e.imageName)),

                      ]
                      )).toList() ),
            ),
          ),
        ],
      ),
    );
  }
}
class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
