class DistrictModel{
  late final String districtId;
  late final String districtName;
  late final String goverId;

  DistrictModel({required this.districtId,required this.districtName,required this.goverId});
  DistrictModel.fromJson(Map<String, dynamic> map){
    this.districtId = map['ID'].toString();
    this.districtName = map['Name'];
    this.goverId = map['GoverID'].toString();
  }
  Map<String,dynamic> toMap()=> {'ID' : districtId , 'Name' : districtName, 'GoverID': goverId};
}

class Districts{
  final List<dynamic> districtsList;

  Districts({required this.districtsList});

  factory Districts.fromJson(Map<String,dynamic> map){
    return Districts(districtsList : map['Districts']);
  }
}