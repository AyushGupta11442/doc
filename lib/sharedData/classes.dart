import 'dart:convert';
import 'package:doctor/main.dart';
import 'package:http/http.dart' as http;

import '../healthQ&A/models/NewAnsmodel.dart';

class question {
  String title = "", body = "", createdDate = "";
  int id = 0;
  question(String x, String y, String z, int a) {
    title = x;
    body = y;
    createdDate = z;
    id = a;
  }
}

class doctor {
  String name = "";
  int id = 0, experience = 0;
  late List<String> specialities;
  doctor(String x, List<String>? s, int? e, int z) {
    name = x;
    if (s != null) {
      specialities = s;
    }
    if (e != null) {
      experience = e;
    }
    id = z;
  }
}

class answer {
  String? description = "", doNext = "", tips = "";
  int? id = 0;
  bool? isHelpful;
  String? report = '';
  late doctor? d;
  answer(String? x, String? y, String? z, doctor D, int f, bool? isUseful,
      String Report) {
    if (x != null) description = x;
    if (y != null) doNext = y;
    if (z != null) tips = z;
    id = f;
    d = D;
    isHelpful = isUseful;
    report = Report;
  }
  String getAnswer() {
    return description! + "\n" + doNext! + "\n" + tips!;
  }
}

List<String> dynamicToString(dynamic list) {
  List<String> arr = <String>[];
  for (dynamic i in list) {
    arr.add(i.toString());
  }
  return arr;
}

Future<List<NewAnswers>> getAnswers(int id) async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  var data = await http.get(
      Uri.parse('https://api.doctrro.com/api/all_answers/${id.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      });
  dynamic response = jsonDecode(data.body);
  var res = response['data']['questions'][0]['answers'];
  late NewAnsModel newans;
  List<NewAnswers> arr = [];
  if (data.statusCode == 200) {
    newans = NewAnsModel.fromJson(response);
  }
  arr = newans.data!.questions![0].answers!;
  // for (dynamic a in res) {

  //   // arr.add(answer(

  //   //     a['description'].trim(),
  //   //     a['do_next'].trim(),
  //   //     a['tips'].trim(),
  //   //     doctor(a['doctor']['name'], [], a['doctor']['experience'],
  //   //         a['doctor']['id']),
  //   //     a['id'],
  //   //     (a['customers'][0]['pivot']['helpful'] == 0 &&
  //   //             a['customers'][0]['pivot']['no_helpful'] == 0)
  //   //         ? null
  //   //         : (a['customers'][0]['pivot']['helpful'] == 1),
  //   //     (a['customers'][0]['pivot']['report_remarks'] == null)
  //   //         ? ''
  //   //         : a['customers'][0]['pivot']['report_remarks']
  //   //         ));
  // }

  return arr;
}

Future<List<question>> getQuestions() async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  var data = await http.get(Uri.parse('https://api.doctrro.com/api/question'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      });
  dynamic res = jsonDecode(data.body);
  res = res['data']['questions'];
  List<question> arr = <question>[];
  for (dynamic q in res) {
    arr.add(question(q['title'].trim(), q['description'].trim(),
        q['created_at'].substring(0, 10), q['id']));
  }
  return arr;
}

Future<List<question>> getMyQuestions() async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  var data = await http.get(
      Uri.parse('https://api.doctrro.com/api/my_questions'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      });
  dynamic res = jsonDecode(data.body);
  res = res['data']['questions'];
  List<question> arr = <question>[];
  for (dynamic q in res) {
    arr.add(question(q['title'].trim(), q['description'].trim(),
        q['created_at'].substring(0, 10), q['id']));
  }
  return arr;
}

Future<dynamic> YesOrNo(bool x, int id) async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  dynamic jsonData = {};
  if (x) {
    var data = await http.get(
        Uri.parse('https://api.doctrro.com/api/helpful/${id.toString()}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $myToken'
        });
    jsonData = jsonDecode(data.body);
  } else {
    var data = await http.get(
        Uri.parse('https://api.doctrro.com/api/no_helpful/${id.toString()}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $myToken'
        });
    jsonData = jsonDecode(data.body);
  }
  return jsonData;
}

Future<dynamic> Report(String report, int id) async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  dynamic jsonData = {};
  var data = await http.put(
      Uri.parse('https://api.doctrro.com/api/report_rise/${id.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      },
      body: jsonEncode({'report_remarks': report}));
  jsonData = jsonDecode(data.body);
  return jsonData;
}

class sp {
  late int id;
  late String data;
  sp(int x, String y) {
    id = x;
    data = y;
  }
}

Future<List<sp>> getSP() async {
  dynamic jsonData = {};
  var data =
      await http.get(Uri.parse('https://api.doctrro.com/api/specialities'));
  jsonData = jsonDecode(data.body);
  jsonData = jsonData['data']['specialities'];
  List<sp> t = <sp>[];
  for (dynamic s in jsonData) {
    t.add(sp(s['id'], s['name']));
  }
  return t;
}

Future<http.Response> submitQuestion(
    String title, String body, String problem) async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  return http.post(Uri.parse('https://api.doctrro.com/api/question'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      },
      body: jsonEncode(<String, String>{
        'speciality_id': problem,
        'title': title,
        'description': body
      }));
}

Future<List<question>> getQuestionsID(String id) async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  var data = await http.get(
      Uri.parse(
          'https://api.doctrro.com/api/filter_question_by_speciality/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      });
  dynamic res = jsonDecode(data.body);
  res = res['data']['questions'];
  List<question> arr = <question>[];
  for (dynamic q in res) {
    arr.add(question(q['title'].trim(), q['description'].trim(),
        q['created_at'].substring(0, 10), q['id']));
  }
  return arr;
}

Future<List<question>> searchQuestion(String term) async {
  // final token = await SharedPreferencesHelper().getAuthToken();
  var data =
      await http.post(Uri.parse('https://api.doctrro.com/api/search_questions'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken'
          },
          body: jsonEncode(<String, String>{'keyphrase': term}));
  dynamic res = jsonDecode(data.body);
  res = res['data']['questions'];
  List<question> arr = <question>[];
  for (dynamic q in res) {
    arr.add(question(q['title'].trim(), q['description'].trim(),
        q['created_at'].substring(0, 10), q['id']));
  }
  return arr;
}
