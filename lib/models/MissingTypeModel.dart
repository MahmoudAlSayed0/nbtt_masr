
class MissingTypeModel{
  late final int id;
  late final String name;
  MissingTypeModel({required this.id,required this.name});

  MissingTypeModel.fromJson(Map<String, dynamic> map){
    id = map["ID"];
    name = map["Name"];
  }
  Map<String,dynamic> toMap()=> {'ID' : id , 'Name' : name};
}