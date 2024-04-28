import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nbtt_masr/models/SupportModel.dart';
import 'package:nbtt_masr/models/api_response.dart';

class SupportService{
  static const API ='http://nccm.gov.eg/api/api/Main/';
  static const headers= {
    'Content-Type': 'application/json'
  };
  Future<ApiResponse> createSupport(SupportModel model){
    var test = model.toJson();
    return http.post(Uri.parse(API + '/AskForSupport') ,body: json.encode(model.toJson()),headers: headers).then((data) {
      if (data.statusCode == 200) {
        print(data.body.toString());
        var obj = json.decode(data.body);
        return ApiResponse.fromJson(obj["Data"]);
      }
      var jsonBody = data.body;
      var jsonData = json.decode(jsonBody);
      var errorObj = jsonData["Data"];
      return ApiResponse(fieldID: errorObj["FieldID"],validFieldID: errorObj["ValidFieldID"],
      isValid: errorObj["IsValid"],step: errorObj["Step"],message: errorObj["Message"]);
    })
        .catchError((e) => ApiResponse(fieldID: "",validFieldID: "", isValid: false , step: 1 ,message: e.toString()));
  }

}