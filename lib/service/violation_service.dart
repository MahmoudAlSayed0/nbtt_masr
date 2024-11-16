import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nbtt_masr/models/ViolationModel.dart';
import 'package:nbtt_masr/models/api_response.dart';

class ViolationService{
  static const API = 'http://nccm.gov.eg/api/api/Main/';
  static const headers = {
    'Content-Type': 'application/json'
    //'content-type': 'multipart/form-data'
  };

  Future<ApiResponse> createMissingKid(ViolationModel model) async {
    var test = model.toJson();
    return await http.post(
        Uri.parse(API + '/SaveReport'), body: json.encode(model.toJson()),
        headers: headers).then((data) {
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
        .catchError((e) =>
        ApiResponse(fieldID: "",validFieldID: "", isValid: false , step: 1 ,message: e.toString()));

  }
}