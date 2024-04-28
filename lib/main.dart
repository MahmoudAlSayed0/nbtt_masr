import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:nbtt_masr/models/DistrictModel.dart';
import 'package:nbtt_masr/models/NameSourcesModel.dart';
import 'package:nbtt_masr/models/dailyTipsModel.dart';
import 'package:nbtt_masr/service/foundKid_service.dart';
import 'package:nbtt_masr/service/missingKid_service.dart';
import 'package:nbtt_masr/service/sqlite_service/dbhelper.dart';
import 'package:nbtt_masr/service/support_service.dart';
import 'package:nbtt_masr/service/violation_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'Pages/splash.dart';
import 'Pages/test.dart';
import 'helpers/constants.dart';
import 'helpers/dateFormake.dart';
import 'models/DisabilityModel.dart';
import 'models/GoverModel.dart';
import 'models/LastUpdateModel.dart';
import 'models/MenuItemsModel.dart';
import 'models/MissingTypeModel.dart';
import 'models/RecognitionModel.dart';


void setupLocator()
{
  GetIt.instance.registerLazySingleton(() => SupportService());
  GetIt.instance.registerLazySingleton(() => MissingKidService());
  GetIt.instance.registerLazySingleton(() => FoundKidService());
  GetIt.instance.registerLazySingleton(() => ViolationService());

}
List<GoverModel> goverListf = <GoverModel>[];
List<DistrictModel> districtListf = <DistrictModel>[];
List<DisabilityModel> disabilityListf = <DisabilityModel>[];
List<MissingTypeModel> missingListf = <MissingTypeModel>[];
List<RecognitionModel> recognitionList = <RecognitionModel>[];
List<NameSourcesModel> nameSourceList = <NameSourcesModel>[];

Future<void> dbInstallation() async{
  DBHelper helper= new DBHelper();
  final Future<Database> db = helper.createDataBase();
  List<LastUpdateModel> localLastUpdate = await helper.allLastUpdate();


  LastUpdateModel serverLastUpdate = await _fetchLastUpdate();


  await _fetchAllData();
  if(localLastUpdate.length != 0){
    if(localLastUpdate.last.updateTime != serverLastUpdate.updateTime){
      await helper.cleanDatabase();
      List<DailyTipsModel> localDailyTip = await helper.allTipOfDay();


      List<DailyTipsModel> serverDailyTips = await _fetchDailyTipsList();

      List<MenuItemsModel> serverMenuItems = await _fetchMenuItemsList();
      print(goverListf.length);
      print(districtListf.length);

      for(int i = 0; i < goverListf.length ; i++){
        helper.createGovernarate(goverListf[i]);
      }

      for(int i = 0; i < districtListf.length ; i++){
        helper.createDistricts(districtListf[i]);
      }

      for(int i =0; i< serverDailyTips.length ; i++){
        helper.createTipOfDay(serverDailyTips[i]);
      }

      for(int i = 0; i < disabilityListf.length ; i++){
        helper.createDisability(disabilityListf[i]);
      }

      for(int i = 0; i < serverMenuItems.length ; i++){
        helper.createMenuItems(serverMenuItems[i]);
      }

      for(int i = 0; i < recognitionList.length ; i++){
        helper.createRecognition(recognitionList[i]);
      }

      for(int i = 0; i < nameSourceList.length ; i++){
        helper.createNameSources(nameSourceList[i]);
      }

      for(int i = 0; i < missingListf.length ; i++){
        helper.createLossTypes(missingListf[i]);
      }
      var result =  helper.createLastUpdate(serverLastUpdate);
    }

  }
  else{
    List<DailyTipsModel> localDailyTip = await helper.allTipOfDay();
    List<GoverModel> localGoversList = await helper.allGovers();
    List<DistrictModel> localDistrictList = await helper.allDistricts();
    List<DisabilityModel> localDisabilityList = await helper.allDisability();
    List<MissingTypeModel> localMissingType = await helper.allLossTypes();
    List<MenuItemsModel> localMenuItems = await helper.allMenuItems();
    List<RecognitionModel> localRecognition = await helper.allRecognition();
    List<NameSourcesModel> localNameSource = await helper.allNameSources();

    if(localGoversList.length == 0){
      for(int i = 0; i < goverListf.length ; i++){
        helper.createGovernarate(goverListf[i]);
      }
    }
    if(localDistrictList.length == 0){
      for(int i = 0; i < districtListf.length ; i++){
        helper.createDistricts(districtListf[i]);
      }
    }
    if(localDisabilityList.length == 0){
      for(int i = 0; i < disabilityListf.length ; i++){
        helper.createDisability(disabilityListf[i]);
      }
    }
    if(localMissingType.length == 0){
      for(int i = 0; i < missingListf.length ; i++){
        helper.createLossTypes(missingListf[i]);
      }
    }
    if(localRecognition.length == 0){
      for(int i = 0; i < recognitionList.length ; i++){
        helper.createRecognition(recognitionList[i]);
      }
    }
    if(localNameSource.length == 0){
      for(int i = 0; i < nameSourceList.length ; i++){
        helper.createNameSources(nameSourceList[i]);
      }
    }
    if(localMenuItems.length == 0){
      List<MenuItemsModel> serverMenuItems = await _fetchMenuItemsList();
      for(int i = 0; i < serverMenuItems.length ; i++){
        helper.createMenuItems(serverMenuItems[i]);
      }
    }

    if(localDailyTip.length == 0){
      List<DailyTipsModel> serverDailyTips = await _fetchDailyTipsList();
      for(int i =0; i< serverDailyTips.length ; i++){
        helper.createTipOfDay(serverDailyTips[i]);
      }
    }
    var result =  helper.createLastUpdate(serverLastUpdate);

  }

}
Future<void> _fetchAllData() async {
  //await Future.delayed(Duration(milliseconds: 500));
  http.Response response =
  await http.get(Uri.parse("http://nccm.gov.eg/api/api/Main/GetFormData"));
  var jsonBody = response.body;
  var jsonData = json.decode(jsonBody);
  var goverData = jsonData['Governorates'];
  var districtData = jsonData['Districts'];
  var lossingData = jsonData['LossTypes'];
  var disabilityData = jsonData['Types'];
  var recognitionData = jsonData['RecognitionMethods'];
  var nameSourceData = jsonData['NameSources'];

  for (var i in goverData) {
    goverListf
        .add(GoverModel(goverId: i['ID'].toString(), goverName: i['Name']));
  }
  for (var i in districtData) {
    districtListf.add(DistrictModel(districtId: i['ID'].toString(),
        districtName: i['Name'],goverId: i['GoverID'].toString()));
  }
  for(var i in disabilityData){
    disabilityListf.add(DisabilityModel(id: i['ID'], name: i['Name']));
  }
  for(var i in lossingData){
    missingListf.add(MissingTypeModel(id: i['ID'], name: i['Name']));
  }
  for(var i in recognitionData){
    recognitionList.add(RecognitionModel(id: i['ID'], name: i['Name']));
  }
  for(var i in nameSourceData){
    nameSourceList.add(NameSourcesModel(id: i['ID'], name: i['Name']));
  }
  //return _newStateList.toList();
}
Future<LastUpdateModel> _fetchLastUpdate() async {
  //await Future.delayed(Duration(milliseconds: 200));
  http.Response response = await http.get(
      Uri.parse("http://nccm.gov.eg/api/api/Main/GetLastUpdate"));
  var jsonBody = response.body;
  var jsonData = json.decode(jsonBody);
  //final _lastUpdate = <LastUpdateModel>[];
  final LastUpdateModel lastUpdateModel = LastUpdateModel(
      id: jsonData['ID'].toString(),
      updateTime: '${DateTime.parse(jsonData['UpdateTime']).year.toString()}' +
          '-' + '${DateTime.parse(jsonData['UpdateTime']).month.toString()}' +
          '-' + '${DateTime.parse(jsonData['UpdateTime']).day.toString()}' +
          ':' + '${DateTime.parse(jsonData['UpdateTime']).hour.toString()}' +
          ':' + '${DateTime.parse(jsonData['UpdateTime']).minute.toString()}'
  );
  return lastUpdateModel;
}
Future<List<MenuItemsModel>> _fetchMenuItemsList() async {
  http.Response response =
  await http.get(Uri.parse("http://nccm.gov.eg/api/api/Main/GetMenuItems"));
  var jsonBody = response.body;
  var jsonData = json.decode(jsonBody);
  //print(jsonData);
  final _newMenu = <MenuItemsModel>[];
  for (var i in jsonData) {
    _newMenu.add(MenuItemsModel(
        id: i['ID'],
        menuName: i['MenuName'],
        menuShortName: i['MenuShortText'],
        menuURL: i['MenuURL']));
  }
  return _newMenu.toList();
}
Future<List<DailyTipsModel>> _fetchDailyTipsList() async {
  http.Response response =
  await http.get(Uri.parse("http://nccm.gov.eg/api/api/Main/GetNewDailyTips"));
  var jsonBody = response.body;
  var jsonData = json.decode(jsonBody);
  var data = jsonData['Data'];
  final _newStateList = <DailyTipsModel>[];
  for (var i in data) {
    _newStateList
        .add(DailyTipsModel(tip: i['Tip'].toString(), tipImage: i['TipImg'],
    from: dateDashFormat(DateTime.parse(i['From'])),
    to: dateDashFormat(DateTime.parse(i['To'])),));
  }
  //print(_newStateList.length);
  return _newStateList.toList();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await dbInstallation();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نبتة مصر',
      theme: ThemeData(
        primaryColor: kGreenColor,
        fontFamily: 'Adelle Sans ARA',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}