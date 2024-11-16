
class SupportModel{
  final String name;
  final String phoneNumber;
  final String address;
  String? type;
  String? kidName;
  String? kidAge;
  final String description;
  int? pc;
  String? fileNo;

  SupportModel({
    required this.name,required this.phoneNumber,required this.address,this.type,this.kidName,this.kidAge,
    required this.description,this.pc,this.fileNo
});

  Map<String, dynamic> toJson(){
    return {
      'PersonName' : name,
      'PhonNo' : phoneNumber,
      'Address' : address,
      'Type' : type,
      'KidName' : kidName,
      'KidAge' : kidAge,
      'Description' : description,
      'PC' : pc,
      'FileNo' : fileNo
    };
  }
}