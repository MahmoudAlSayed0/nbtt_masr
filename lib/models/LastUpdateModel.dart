class LastUpdateModel{
  late final String id;
  late final String updateTime;
  LastUpdateModel({required this.id,required this.updateTime});

  LastUpdateModel.fromJson(Map<String, dynamic> map){
    this.id = map['ID'].toString();
    this.updateTime = map['UpdateTime'];
  }

  Map<String,dynamic> toMap()=> {'ID': this.id ,'UpdateTime' : this.updateTime};
}