class ApiResponse{
  late final String fieldID;
  late final String validFieldID;
  late final bool isValid;
  int? step;
  late final String message;
  ApiResponse({required this.fieldID,required this.validFieldID,required this.isValid,this.step,required this.message});

  ApiResponse.fromJson(Map<String, dynamic> map){
    this.fieldID = map["FieldID"];
    this.validFieldID = map["ValidFieldID"];
    this.isValid = map["IsValid"];
    this.step = map["Step"];
    this.message = map["Message"];
  }
  Map<String,dynamic> toMap()=> {'FieldID' : fieldID, 'ValidFieldID' : validFieldID,
  'IsValid' : isValid , 'Step' : step, 'Message' :message};
}