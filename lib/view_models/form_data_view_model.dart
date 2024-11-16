import 'package:nbtt_masr/models/DistrictModel.dart';
import 'package:nbtt_masr/models/GoverModel.dart';
import 'package:nbtt_masr/service/formDataService.dart';

class FormDataViewModel{
  List<GoverModel> goverList = [];
  List<DistrictModel> ditrictLisList= [];

  fetchGovers () async {
    goverList = await FormDataService().getGovers();
  }

  fetchDitrictS() async {
    ditrictLisList = await FormDataService().getDistrict();
  }
}