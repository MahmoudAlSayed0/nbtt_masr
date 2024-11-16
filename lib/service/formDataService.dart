import 'dart:convert';
import 'package:nbtt_masr/models/GoverModel.dart';
import 'package:nbtt_masr/models/DistrictModel.dart';
import 'package:http/http.dart' as http;
import 'package:nbtt_masr/models/LastUpdateModel.dart';
class FormDataService{

  Future<List<GoverModel>> getGovers() async{
    try{
      http.Response response = await http.get(Uri.parse("http://nccm.gov.eg/api/api/Main/GetFormData"));
      if(response.statusCode == 200){
        String data = response.body;
        var jsonData = jsonDecode(data);
        Govers govers = Govers.fromJson(jsonData);
        List<GoverModel> goversList = govers.goversList.map((e) => GoverModel.fromJson(e)).toList();
        return goversList;
      }else{
        print('status code = ${response.statusCode}');
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }
  }
  Future<List<DistrictModel>> getDistrict() async{
    try{
      http.Response response = await http.get(Uri.parse("http://nccm.gov.eg/api/api/Main/GetFormData"));
      if(response.statusCode == 200){
        String data = response.body;
        var jsonData = jsonDecode(data);
        Districts districts = Districts.fromJson(jsonData);
        List<DistrictModel> districtsList = districts.districtsList.map((e) => DistrictModel.fromJson(e)).toList();
        return districtsList;
      }else{
        print('status code = ${response.statusCode}');
        return [];
      }
    }
    catch(e){
      print(e);
      return [];
    }
  }

  Future<LastUpdateModel> getLastUpdate() async{
    try{
      http.Response response = await http.get(Uri.parse("http://nccm.gov.eg/api/api/Main/GetLastUpdate"));
      if(response.statusCode == 200){
        String data = response.body;
        var jsonData = jsonDecode(data);
        LastUpdateModel lastUpdate = LastUpdateModel.fromJson(jsonData);
        return lastUpdate;
      }else{
        print('status code = ${response.statusCode}');
        return LastUpdateModel(id: '',updateTime: '');
      }
    }
    catch(e){
      print(e);
      return LastUpdateModel(id: '',updateTime: '');
    }
  }


}
