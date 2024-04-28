
class DisabilityModel{
  late final int id;
  late final String name;
  DisabilityModel({required this.id,required this.name});

  DisabilityModel.fromJson(Map<String, dynamic> map){
    this.id = map["ID"];
    this.name = map["Name"];
  }
  Map<String,dynamic> toMap()=> {'ID' : id , 'Name' : name};
}