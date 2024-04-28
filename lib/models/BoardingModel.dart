
class BoardingModel{
  int? id;
  late final String name;
  BoardingModel({this.id,required this.name});

  BoardingModel.fromJson(Map<String, dynamic> map){
    this.id = map["ID"];
    this.name = map["Name"];
  }

  Map<String,dynamic> toMap()=> {'ID' : id , 'Name' : name};

}