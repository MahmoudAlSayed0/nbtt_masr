

import 'package:flutter/material.dart';

enum Gender { Male , Female }
enum IsMissingBefore { Yes  , No , DoNotKnow }
enum IsRecordBefore { Yes  , No , DoNotKnow }
enum IsContactBefore { Yes , No}
enum SupportForHow { Mother , Kid}
enum HealthStat  { good , patient , disability}
enum IsHavePaper { Yes , No}


const String kReporterNameNullError = "ادخل الاسم";
const String kNationalIdNullError = "اادخل الرقم القومي";
const String kPhoneNumberNullError = "ادخل رقم التليفون";
const String kGoverNullError = "اختر المحافظة";
const String kDistrictNullError = "اختر المركز";
const String kAddressNullError = "ادخل العنوان";
const String kRelativeRelationNullError = "ادخل صلة القرابة";

const String kKidNameNullError = "ادخل اسم الطفل";
const String kGenderNullError = "ادخل جنس الطفل";
const String kHealthCaseNullError = "اختر الحالة الصحية للطفل";
const String kKidAgeNullError = "ادخل سن الطفل";
const String kTypeOfMissingNullError = "اختر الحالة الصحية للطفل";
const String kMissingDateNullError = "ادخل تاريخ الفقد";
const String kMissingInGoverNullError = "اختر المحافظة";
const String kMissingInDistrictNullError = "اختر المركز";
const String kMissingInAddressNullError = "ادخل العنوان";

const String kKidBodyDescriptionNullError = "ادخل مواصفات جسد الطفل";
const String kKidClothesDescriptionNullError = "ادخل ملابسات فقد الطفل";
const String kRecordLostNullError = "ادخل ملابسات فقد الطفل";

const kPrimaryColor = Color(0xFF231F20);
const kTextColor = Color(0xFF707070);
const kBorderColor = Color(0xFFD8D8D8);
const kGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEA1B22), Color(0xFFAF161A)]
);
const kGreenColor = Color(0xFF67B667);
const kRedColor = Color(0xFFEA1B22);

final RegExp mobileValidatorRegExp =
RegExp(r"^01[0-2]{1}[0-9]{8}");





