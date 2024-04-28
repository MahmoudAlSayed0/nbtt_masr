
class FoundKidModel{
  late final String reporterName;
  String? nationalId;
  late final String phoneNumber;
  int? goverId;
  int? districtId;
  String? address;
  late final String kidName;
  int? kidNameSource;
  String kidImage;
  late final String kidGender;
  List<int> healthStat;
  List<int> typeofDisability;
  DateTime? kidBirthDate;
  late final int kidAge;
  int? knownType;
  late final int foundGoverID;
  late final int foundDistrictID;
  late final String foundAddress;
  late final int existGoverID ;
  late final int existDistrictID ;
  late final String existAddress ;
  int? isKnown ;
  String clothesDes ;
  String specialClo ;
  int reportBit;
  String? reportNo;
  String? policeStation ;
  DateTime? reportDate ;
  String? reportImage ;
  int pp ;
  List<String> attachmentName;
  List<String> attachmentDoc ;

  FoundKidModel({required this.reporterName,this.nationalId,required this.phoneNumber,this.goverId,this.districtId,this.address,
    required this.kidName,this.kidNameSource,required this.kidImage,required this.kidGender,
    required this.healthStat,required this.typeofDisability,this.kidBirthDate,required this.kidAge,
    this.knownType,required this.foundGoverID,required this.foundDistrictID,required this.foundAddress,
    required this.existGoverID,required this.existDistrictID,required this.existAddress,
    this.isKnown,required this.clothesDes,required this.specialClo, required this.reportBit,
    this.reportNo,this.policeStation,this.reportDate,required this.reportImage,
    required this.pp,required this.attachmentName,
    required this.attachmentDoc
  });
  Map<String, dynamic> toJson(){
    return {
      'PersonName' : reporterName,
      'NationalID' : nationalId,
      'PhonNo' : phoneNumber,
      'GoverID' : goverId,
      'DistrictID' : districtId,
      'Address' : address,
      'ChildName' : kidName,
      'ChildNameSource' : kidNameSource,
      'ChildImage' : kidImage,
      'Gender' : kidGender,
      'HealthStat' : healthStat,
      'DisTypeID' : typeofDisability,
      'Birthdate' : kidBirthDate.toString(),
      'Age' : kidAge,
      'KnowType' : knownType,
      'FoundGoverID' : foundGoverID,
      'FoundDistrictID' : foundDistrictID,
      'FoundAddress' : foundAddress,
      'ExistGoverID' : existGoverID,
      'ExistDistrictID' : existDistrictID,
      'ExistAddress' : existAddress,
      'IsKnown' : isKnown,
      'ClothesDes' : clothesDes,
      'SpecialClo' : specialClo,
      'ReportBit' : reportBit,
      'ReportNo' : reportNo,
      'PoliceStation' : policeStation,
      'ReportDate' : reportDate.toString(),
      'ReportImage' : reportImage,
      'PP' : pp,
      'AttachmentName' : attachmentName,
      'AttachmentDoc' : attachmentDoc,
    };
  }
}