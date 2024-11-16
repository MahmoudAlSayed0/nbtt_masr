

import 'package:intl/intl.dart';

String dateFormat(DateTime dateTime){
  return DateFormat('yyy/MM/dd').format(dateTime);
}

String dateDashFormat(DateTime dateTime){
  return DateFormat('yyy-MM-dd').format(dateTime);
}