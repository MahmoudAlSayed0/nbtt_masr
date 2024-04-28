
class GoverModel{
  late final String goverId;
  late final String goverName;

  GoverModel({required this.goverId,required this.goverName});

  GoverModel.fromJson(Map<String, dynamic> map){
    this.goverId = map["ID"].toString();
    this.goverName = map["Name"];
  }
  Map<String,dynamic> toMap()=> {'ID' : goverId , 'Name' : goverName};
}

class Govers{
  final List<dynamic> goversList ;

  Govers({required this.goversList});

  factory Govers.fromJson(Map<String, dynamic> map){
    return Govers( goversList : map['Governorates']);
  }
}