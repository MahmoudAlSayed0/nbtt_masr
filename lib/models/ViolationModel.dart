
class ViolationModel{
  String? reporterName;
  String? phoneNumber;
  final String kidName;
  final int kidAge;
  final String place;
  final String complaint;
  int pc;
  String? fileNo ;
  final int pp ;
  String? lat;
  String? long;
  final List<String> attachmentName;
  final List<String> attachmentDoc ;

  ViolationModel({this.reporterName,this.phoneNumber,required this.kidName,required this.kidAge,
    required this.place,required this.complaint,required this.pc,
    this.fileNo,required this.pp,required this.attachmentName,required this.attachmentDoc,this.lat,this.long
  });

  Map<String, dynamic> toJson(){
    return {
      'PersonName' : reporterName,
      'PhonNo' : phoneNumber,
      'ChildName' : kidName,
      'Age' : kidAge,
      'Place' : place,
      'Complaint' :complaint,
      'PC' : pc,
      'FileNo' : fileNo,
      'PP' : pp,
      'AttachmentName' : attachmentName,
      'AttachmentDoc' : attachmentDoc,
      'Lat' : lat,
      'Long' : long
    };
  }
}