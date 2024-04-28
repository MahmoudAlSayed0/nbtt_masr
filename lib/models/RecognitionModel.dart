
class RecognitionModel{
  late final int id;
  late final String name;

  RecognitionModel({required this.id,required this.name});

  RecognitionModel.fromJson(Map<String, dynamic> map){
    this.id = map["ID"];
    this.name = map["Name"];
  }
  Map<String,dynamic> toMap()=> {'ID' : id , 'Name' : name};
}