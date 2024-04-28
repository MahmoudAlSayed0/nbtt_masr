
class NameSourcesModel{
  late final int id;
  late final String name;

  NameSourcesModel({required this.id,required this.name});

  NameSourcesModel.fromJson(Map<String, dynamic> map){
    this.id = map["ID"];
    this.name = map["Name"];
  }
  Map<String,dynamic> toMap()=> {'ID' : id , 'Name' : name};
}