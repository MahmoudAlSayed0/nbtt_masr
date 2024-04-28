
class DailyTipsModel{
  int? tipId;
  late final String tip;
  late final String tipImage;
  late final String from;
  late final String to;

  DailyTipsModel({this.tipId,required this.tip,required this.tipImage,required this.from,required this.to});
  DailyTipsModel.fromJson(Map<String, dynamic> map){
    this.tip = map['Tip'];
    this.tipImage = map['TipImg'];
    this.from = map['From'];
    this.to = map['To'];
  }

  DailyTipsModel.fromLocalDatabaseJson(Map<String, dynamic> map){
    this.tip = map['Tip'];
    this.tipImage = map['TipImg'];
    this.from = map['DateFrom'];
    this.to = map['DateTo'];
  }

  Map<String,dynamic> toMap()=> { 'Tip' : tip, 'TipImg': tipImage, 'From': from, 'To': to};

}
