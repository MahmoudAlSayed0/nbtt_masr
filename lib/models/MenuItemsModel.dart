

class MenuItemsModel{
  late final int id;
  late final String menuName;
  String? menuShortName;
  late final String menuURL;

  MenuItemsModel({required this.id,required this.menuName,required this.menuShortName,required this.menuURL});

  MenuItemsModel.fromJson(Map<String, dynamic> map){
    this.id = map["ID"];
    this.menuName = map["MenuName"];
    this.menuShortName = map["MenuShortText"];
    this.menuURL = map["MenuURL"];
  }

  Map<String,dynamic> toMap()=> {
    'ID' : id,
    'MenuName' : menuName,
    'MenuShortText' : menuShortName,
    'MenuURL' : menuURL
  };
}