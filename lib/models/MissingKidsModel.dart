import 'package:nbtt_masr/view_models/form_data_view_model.dart';

import 'DisabilityModel.dart';
import 'GoverModel.dart';
import 'HealthCaseModel.dart';
import 'MissingTypeModel.dart';

class MissingKidsModel{
  final String reporterName;
  String? nationalId;
  final String phoneNumber;
  String? relativeRelation;
  int? goverId;
  int? districtId;
  String? address;
  final String kidName;
  String kidImage;
  final String kidGender;
  List<int> healthStat;
  List<int> typeofDisability;
  DateTime? kidBirthDate;
  final int kidAge;
  int typeOfMissing;
  final DateTime kidMissingDate;
  int isMissingBefore;
  int missingInGover;
  int missingInDistrict;
  final String missingAddress;
  String? howFound;
  String? shirtDescription;
  String? kidClothesDescription;
  int? recordLost;
  String? noRecordLost;
  String? policeStation;
  DateTime? recordDate;
  String? recordImage;
  final int havePaper;
  final List<String> attachmentName;
  final List<String> attachmentDoc;

  MissingKidsModel({required this.reporterName,this.nationalId,required this.phoneNumber,
    this.relativeRelation,this.goverId, this.districtId,this.address,required this.kidName,
    required this.kidImage,required this.kidGender,required this.healthStat,required this.typeofDisability, this.kidBirthDate,required this.kidAge,required this.typeOfMissing,
    required this.kidMissingDate, required this.missingInGover,required this.missingInDistrict,
    required this.missingAddress,required this.isMissingBefore,this.shirtDescription,
    this.kidClothesDescription, this.recordLost,this.noRecordLost,this.policeStation,
    this.recordDate,this.recordImage,required this.havePaper
    ,required this.attachmentName,required this.attachmentDoc});

  Map<String, dynamic> toJson(){
    return {
      'PersonName' : reporterName,
      'NationalID' : nationalId,
      'PhonNo' : phoneNumber,
      'RelativeRel' : relativeRelation,
      'GoverID' : goverId,
      'DistrictID' : districtId,
      'Address' : address,
      'ChildName' : kidName,
      'ChildImage' : kidImage,
      'Gender' : kidGender,
      'HealthStat' : healthStat,
      'DisTypeID' : typeofDisability,
      'Birthdate' : kidBirthDate.toString(),
      'Age' : kidAge,

      'LossDate' : kidMissingDate.toString(),
      'LossClass' : typeOfMissing,
      'LossBit' : isMissingBefore,
      'LossGoverID' : missingInGover,
      'LossDistrictID' : missingInDistrict,
      'LossAddress' : missingAddress,
      'ClothesDes' : shirtDescription,
      'SpecialClo' : kidClothesDescription,
      'ReportBit' : recordLost,
      'ReportNo' : noRecordLost,
      'PoliceStation' : policeStation,
      'ReportDate' : recordDate.toString(),
      'ReportImage' : recordImage,
      'PP' : havePaper,
      'AttachmentName' : attachmentName,
      'AttachmentDoc' : attachmentDoc,
    };
  }
}
FormDataViewModel vm = FormDataViewModel();
List<GoverModel> goverList = vm.goverList;
/* <GoverModel> [
   GoverModel(
    goverId: 1,
    goverName: "القاهرة"
  ),
  GoverModel(
      goverId: 2,
      goverName: "الجيزة"
  ),
  GoverModel(
      goverId: 3,
      goverName: "اسكندرية"
  ),
];
*/
/*List<DistrictModel> districtList = <DistrictModel> [
  DistrictModel(
    districtId: 1,
    districtName: "عجوزة",
    goverId: 2
  ),
  DistrictModel(
      districtId: 1,
      districtName: "عين شمس",
      goverId: 1
  ),
  DistrictModel(
      districtId: 1,
      districtName: "ميامى",
      goverId: 3
  ),
];*/

List<HealthCaseModel> healthCaseList = <HealthCaseModel>[
  HealthCaseModel(
    id: 1,
    name: "سليم"
  ),
  HealthCaseModel(
      id: 2,
      name: "مريض بمرض مزمن"
  ),
  HealthCaseModel(
      id: 3,
      name: "ذوي اعاقة"
  ),
];

List<DisabilityModel> disabilityList = <DisabilityModel>[
  DisabilityModel(
    id: 1,
    name: "ذهنية"
  ),
  DisabilityModel(
      id: 1,
      name: "حركية"
  ),
  DisabilityModel(
      id: 1,
      name: "سمعية"
  ),
  DisabilityModel(
      id: 1,
      name: "بصرية"
  ),
  DisabilityModel(
      id: 1,
      name: "نفسية"
  ),
];

List<MissingTypeModel> missingTypeList = <MissingTypeModel>[
  MissingTypeModel(
    id: 1,
    name: "تائه"
  ),
  MissingTypeModel(
      id: 2,
      name: "هارب"
  ),
  MissingTypeModel(
      id: 3,
      name: "مخطوف"
  ),
  MissingTypeModel(
      id: 4,
      name: "لا يعرف"
  ),
];