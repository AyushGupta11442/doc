import 'dart:io';
import 'package:doctor/main.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../client/DioClientToken/DioClient_Token.dart';
import '../provider/shared_pref_helper.dart';

String? name = SharedPreferencesHelper.getUserName();
Future<dynamic> ImageUpload(List<File> x, String uname, String title,
    String rType, String rDate) async {
  //final authToken = await SharedPreferencesHelper().getAuthToken();
  final request = http.MultipartRequest(
    "POST",
    Uri.parse('https://api.doctrro.com/api/medical_record'),
  );

  // Headers
  request.headers['Authorization'] = 'Bearer $myToken';

  // Body
  request.fields['title'] = title;
  request.fields['record_date'] = rDate;
  request.fields['type'] = rType;
  request.fields['record_for'] = name!;

  for (int i = 0; i < x.length; i++) {
    request.files.add(await http.MultipartFile.fromPath(
        'record_files[$i][file]', x[i].path,
        contentType: MediaType('image', p.extension(x[i].path))));
  }
  return request.send();
}

Future<dynamic> updateRecord(List<File> x, String uname, String title,
    String rType, String rDate, int id) async {
  // print(id);
  //try {
  final response = await DioClinetToken.instance.dio!.put('/medical_record/$id',
      data: {
        'title': title,
        "record_date": rDate,
        "type": rType,
        "record_for": uname
      });
  return response;
  // } catch (e) {}

  //final authToken = await SharedPreferencesHelper().getAuthToken();
  // final request = http.MultipartRequest(
  //   "POST",
  //   Uri.parse('https://api.doctrro.com/api/medical_record/$id'),
  // );

  // // Headers
  // request.headers['Authorization'] =
  //     'Bearer ${SharedPreferencesHelper.getAuthToken()}';

  // // Body
  // request.fields['_method'] = 'PUT';
  // request.fields['title'] = title;
  // request.fields['record_date'] = rDate;
  // request.fields['type'] = rType;
  // request.fields['record_for'] = uname;

  // for (int i = 0; i < x.length; i++) {
  //   request.files.add(await http.MultipartFile.fromPath(
  //       'record_files[$i][file]', x[i].path,
  //       contentType: MediaType('image', p.extension(x[i].path))));
  // }
  // return request.send();
}

Future getImage(bool isCamera) async {
  final image = await ImagePicker()
      .pickImage(source: (isCamera) ? ImageSource.camera : ImageSource.gallery);
  if (image == null) return;
  return File(image.path);
}

Future<bool> deleteFile(int id) async {
  var data = await http.get(
      Uri.parse('https://api.doctrro.com/api/medical_record_file/$id/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      });
  return (data.statusCode == 200);
}
