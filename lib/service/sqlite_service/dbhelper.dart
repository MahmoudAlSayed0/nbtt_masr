import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:nbtt_masr/models/BoardingModel.dart';
import 'package:nbtt_masr/models/DisabilityModel.dart';
import 'package:nbtt_masr/models/DistrictModel.dart';
import 'package:nbtt_masr/models/GoverModel.dart';
import 'package:nbtt_masr/models/LastUpdateModel.dart';
import 'package:nbtt_masr/models/MenuItemsModel.dart';
import 'package:nbtt_masr/models/MissingTypeModel.dart';
import 'package:nbtt_masr/models/NameSourcesModel.dart';
import 'package:nbtt_masr/models/RecognitionModel.dart';
import 'package:nbtt_masr/models/dailyTipsModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();
  static Database? _db;

  Future<Database> createDataBase() async{
    if(_db != null){
      return _db!;
    }
    String path = join(await getDatabasesPath(), 'localDatabase.db');
    _db = await openDatabase(path,version: 12,onCreate: initDB,onUpgrade: _onUpgrade);
    return _db!;
  }
  void _onUpgrade(Database db, int oldVersion, int newVersion) async{
    if (oldVersion < newVersion) {
      //await db.execute('create table LocalMenuItems2(ID integer primary key , MenuName Text , MenuShortText TEXT , MenuURL Text)');
      //await db.execute('create table LocalBoarding(ID integer primary key AutoIncrement, Name Text)');
      //await db.execute('create table LocalNewTipOfDay(ID integer primary key AutoIncrement, Tip Text, TipImg Text, DateFrom Text, DateTo Text)');
      await db.execute('create table LocalRecognition(ID integer primary key, Name Text)');
      await db.execute('create table LocalNameSources(ID integer primary key, Name Text)');

    }
  }

  void initDB (Database db,int v) async{
  await db.execute('create table LocalGovernorates(ID integer primary key, Name Text)');
  await db.execute('create table LocalDistricts(ID integer primary key, Name Text, GoverID integer)');
  await db.execute('create table LocalLossTypes(ID integer primary key, Name Text)');
  await db.execute('create table LocalTypes(ID integer primary key, Name Text)');
  await db.execute('create table LocalLastUpdate(ID integer primary key AutoIncrement, UpdateTime Text)');
  await db.execute('create table LocalUpdate(ID integer primary key AutoIncrement, UpdateTime Text)');
  await db.execute('create table LocalMenuItems2(ID integer primary key , MenuName Text , MenuShortText TEXT , MenuURL Text)');
  await db.execute('create table LocalBoarding(ID integer primary key AutoIncrement, Name Text)');
  await db.execute('create table LocalTipOfDay(ID integer primary key AutoIncrement, Tip Text, TipImg Text)');
  await db.execute('create table LocalNewTipOfDay(ID integer primary key AutoIncrement, Tip Text, TipImg Text, DateFrom Text, DateTo Text)');
  await db.execute('create table LocalRecognition(ID integer primary key, Name Text)');
  await db.execute('create table LocalNameSources(ID integer primary key, Name Text)');

  }

  Future<int> createDisability(DisabilityModel disabilityModel) async{
    Database db = await createDataBase();
    return db.insert('LocalTypes', disabilityModel.toMap());
  }
  Future<List<DisabilityModel>> allDisability() async{
    Database db = await createDataBase();
    List<DisabilityModel> disabilities = <DisabilityModel>[];
    var disabilityList = await db.query('LocalTypes');
    for(int i = 0;i < disabilityList.length; i++){
      disabilities.add(DisabilityModel.fromJson(disabilityList[i]));
    }
    return disabilities;
  }
  Future<int> createRecognition(RecognitionModel recognitionModel) async{
    Database db = await createDataBase();
    return await db.insert('LocalRecognition', recognitionModel.toMap());
  }
  Future<List<RecognitionModel>> allRecognition() async{
    Database db = await createDataBase();
    List<RecognitionModel> recognition = <RecognitionModel>[];
    var recognitionList = await db.query('LocalRecognition');
    for(int i = 0;i < recognitionList.length; i++){
      recognition.add(RecognitionModel.fromJson(recognitionList[i]));
    }
    return recognition;
  }
  Future<int> createNameSources(NameSourcesModel nameSourcesModel) async{
    Database db = await createDataBase();
    return await db.insert('LocalNameSources', nameSourcesModel.toMap());
  }
  Future<List<NameSourcesModel>> allNameSources() async{
    Database db = await createDataBase();
    List<NameSourcesModel> nameSources = <NameSourcesModel>[];
    var nameSourcesList = await db.query('LocalNameSources');
    for(int i = 0;i < nameSourcesList.length; i++){
      nameSources.add(NameSourcesModel.fromJson(nameSourcesList[i]));
    }
    return nameSources;
  }
  Future<int> deleteDisability(int id) async {
    Database db = await createDataBase();
    return await db.delete('LocalTypes', where: 'ID = ?', whereArgs: [id]);
  }

  Future<int> createLossTypes(MissingTypeModel missingTypeModel) async{
    Database db = await createDataBase();
    return db.insert('LocalLossTypes', missingTypeModel.toMap());
  }

  Future<List<MissingTypeModel>> allLossTypes() async{
    Database db = await createDataBase();
    List<MissingTypeModel> missingTypesList = <MissingTypeModel>[];
    var missingTypes = await db.query('LocalLossTypes');
    for(int i = 0;i < missingTypes.length; i++){
      missingTypesList.add(MissingTypeModel.fromJson(missingTypes[i]));
    }
    return missingTypesList;
  }
  Future<int> deleteLossTypes(int id) async {
    Database db = await createDataBase();
    return await db.delete('LocalLossTypes', where: 'ID = ?', whereArgs: [id]);
  }

  Future<void> createGovernarate(GoverModel goverModel) async{
    Database db = await createDataBase();
    Batch batch = db.batch();
    batch.insert('LocalGovernorates', goverModel.toMap());
    batch.commit();
  }
  Future<List<GoverModel>> allGovers() async{
    Database db = await createDataBase();
    List<GoverModel> govers =<GoverModel>[];
    var goversList = await db.query('LocalGovernorates');
  /*  goversList.forEach((element) {
      govers.add(GoverModel.fromJson(element));
    });*/
    for(int i = 0;i < goversList.length; i++){
      govers.add(GoverModel.fromJson(goversList[i]));
    }
    return govers;
  }
  Future<int> deleteGovers(int id) async {
    Database db = await createDataBase();
    return await db.delete('LocalGovernorates', where: 'ID = ?', whereArgs: [id]);
  }

  Future<int> createDistricts(DistrictModel districtModel) async{
    Database db = await createDataBase();
    return db.insert('LocalDistricts', districtModel.toMap());
  }
  Future<List<DistrictModel>> allDistricts() async{
    Database db = await createDataBase();
    List<DistrictModel> districts = <DistrictModel>[];
    var districtsList = await db.query('LocalDistricts');
    for(int i = 0; i < districtsList.length; i++){
      districts.add(DistrictModel.fromJson(districtsList[i]));
    }
    return districts;
  }
  Future<int> deleteDistricts(int id) async {
    Database db = await createDataBase();
    return await db.delete('LocalDistricts', where: 'ID = ?', whereArgs: [id]);
  }

  Future<int> createLastUpdate(LastUpdateModel lastUpdateModel) async{
    Database db = await createDataBase();
    //return db.insert('LocalLastUpdate', lastUpdateModel.updateTime);
    String temp = lastUpdateModel.updateTime;
    print(temp);
    return db.rawInsert('INSERT INTO LocalLastUpdate(UpdateTime) VALUES(?)',[temp]);
    //return db.insert('LocalLastUpdate', lastUpdateModel.toMap());
  }
  Future<List<LastUpdateModel>> allLastUpdate() async{
    Database db = await createDataBase();
   /* var test = await  db.query('LocalLastUpdate',orderBy: "ID DESC",limit: 1);
    print(test[0]);*/
    List<LastUpdateModel> menuItems =<LastUpdateModel>[];
    var itemsList = await db.query('LocalLastUpdate');
    for(int i = 0;i < itemsList.length; i++){
      menuItems.add(LastUpdateModel.fromJson(itemsList[i]));
    }
    /*LastUpdateModel lastUpdateModel = LastUpdateModel(id: test[0]['ID'].toString(),
        updateTime: DateTime.parse(test[0]['UpdateTime'].toString()).toString());*/
    //return test[0]['UpdateTime'].toString();
    return menuItems;
  }

  Future<int> createMenuItems(MenuItemsModel menuModel) async{
    Database db = await createDataBase();
    return db.insert('LocalMenuItems2', menuModel.toMap());
  }

  Future<List<MenuItemsModel>> allMenuItems() async{
    Database db = await createDataBase();
    List<MenuItemsModel> menuItems =<MenuItemsModel>[];
    var itemsList = await db.query('LocalMenuItems2');
    for(int i = 0;i < itemsList.length; i++){
      menuItems.add(MenuItemsModel.fromJson(itemsList[i]));
    }
    return menuItems;
  }
  Future<int> deleteMenuItems(int id) async {
    Database db = await createDataBase();
    return await db.delete('LocalMenuItems2', where: 'ID = ?', whereArgs: [id]);
  }

  Future<int> createBoardingValue(BoardingModel boardingModel) async{
    Database db = await createDataBase();
    return await db.insert('LocalBoarding', boardingModel.toMap());
  }

  Future<List<BoardingModel>> allBoardingValue() async{
    Database db = await createDataBase();
    List<BoardingModel> menuItems =<BoardingModel>[];
    var itemsList = await db.query('LocalBoarding');
    for(int i = 0;i < itemsList.length; i++){
      menuItems.add(BoardingModel.fromJson(itemsList[i]));
    }
    return menuItems;
  }

  Future<int> createTipOfDay(DailyTipsModel dailyTipsModel) async{
    Database db = await createDataBase();
    String tempUrl = dailyTipsModel.tipImage.replaceAll(r"\", "/");
    try{
      final ByteData imageData = await NetworkAssetBundle(Uri.parse(tempUrl)).load("");
      final Uint8List bytes = await imageData.buffer.asUint8List();
      //var temp = Image.memory(bytes);
      //List<int> imageBytes =  bytes.readAsBytesSync();
      String imageBase = base64Encode(bytes);
      DailyTipsModel addDaily = DailyTipsModel(
          tip: dailyTipsModel.tip,tipImage: imageBase,from: dailyTipsModel.from,
          to: dailyTipsModel.to);
      //return await db.insert('LocalNewTipOfDay', addDaily.toMap());
      return db.rawInsert('INSERT INTO LocalNewTipOfDay(Tip,TipImg,DateFrom,DateTo) VALUES(?,?,?,?)'
          ,[addDaily.tip,addDaily.tipImage,addDaily.from,addDaily.to]);
    }catch(e){
      return 0;
    }


  }

  Future<List<DailyTipsModel>> allTipOfDay() async{
    Database db = await createDataBase();
    List<DailyTipsModel> dailyTips =<DailyTipsModel>[];
    var itemsList = await db.query('LocalNewTipOfDay');
    for(int i = 0;i < itemsList.length; i++){
      dailyTips.add(DailyTipsModel.fromLocalDatabaseJson(itemsList[i]));
    }
    return dailyTips;
  }

   Future<void> cleanDatabase() async {
    try{
      Database db = await createDataBase();
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete('LocalTypes');
        batch.delete('LocalLossTypes');
        batch.delete('LocalGovernorates');
        batch.delete('LocalDistricts');
        batch.delete('LocalMenuItems2');
        batch.delete('LocalLastUpdate');
        batch.delete('LocalNewTipOfDay');
        batch.delete('LocalRecognition');
        batch.delete('LocalNameSources');
        //batch.delete('LocalBoarding');
        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
}