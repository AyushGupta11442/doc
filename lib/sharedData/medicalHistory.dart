import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctor/provider/shared_pref_helper.dart';


const List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

class medicalRecord {
  late int id;
  late String title, type, date, record_for;
  late String dateDay, dateMonth;
  medicalRecord(
      int ID, String TITLE, String TYPE, String DATE, String Record_for) {
    id = ID;
    title = TITLE;
    type = TYPE;
    date = DATE;
    record_for = Record_for;

    List<String> arr = date.split('-');
    dateDay = arr[2];
    dateMonth = months[int.parse(arr[1]) - 1];
  }
}

Future<List<medicalRecord>> getMedicalRecords() async {
  final token = SharedPreferencesHelper.getAuthToken();
  // final response = await DioClinetToken.instance.dio!.get('https://api.doctrro.com/api/medical_record/');
  var data = await http.get(
      Uri.parse('https://api.doctrro.com/api/medical_record/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  dynamic res = jsonDecode(data.body);
  res = res['data']['medical_records'];
  List<medicalRecord> arr = <medicalRecord>[];
  for (dynamic a in res) {
    arr.add(medicalRecord(a['id'], a['title'].trim(), a['type'],
        a['record_date'], a['record_for']));
  }
  return arr;
}

Future<bool> deleteRecord(int id) async {
  final token = SharedPreferencesHelper.getAuthToken();
  var data = await http.get(
      Uri.parse('https://api.doctrro.com/api/medical_record/$id/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  var res = jsonDecode(data.body);
  print(res);
  return (data.statusCode == 200);
}
