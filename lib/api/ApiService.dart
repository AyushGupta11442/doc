import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../provider/shared_pref_helper.dart';
import 'package:doctor/main.dart';

class HttpService {
  static final _client = http.Client();
  static final _loginUrl =
      Uri.parse('https://api.doctrro.com/api/customer/login');

  static login(email, password, context) async {
    http.Response response = await _client.post(_loginUrl, body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      final data = json['data']['message'];
      //print(json);
      // print(data);
      //String token = json['data']['token'];
      myToken = json['data']['token'];
      //print(token);
      SharedPreferencesHelper.setAuthToken(myToken!);
      SharedPreferencesHelper.setUserName(json['data']['user']['name'].toString());
      SharedPreferencesHelper.setUserMail(json['data']['user']['email'].toString());
      SharedPreferencesHelper.setUserId(json['data']['user']['id']);
      SharedPreferencesHelper.setUserImage(json['data']['user']['image_file']);
      SharedPreferencesHelper.setUserPhone(json['data']['user']['phone_number'].toString());
      SharedPreferencesHelper.setUserGender(
          json['data']['user']['gender'].toString());


      // SharedPreferencesHelper.setUserName(json['data']['user_name'].toString());

      //myToken = await SharedPreferencesHelper().getAuthToken();
      //print("////");
      //print(mm);
      if (data == 'login successful') {
        await EasyLoading.showSuccess(data);
        log("with token $myToken");
        loginInfo.isLogin = true;
        // await Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const HomePage()));

      } else {
        EasyLoading.showError(json["data"]['errors[0]']);
      }
    } else {
      Map<String, dynamic> json = jsonDecode(response.body);
      final data = json['data']['errors'][0];
      //print(data);
      await EasyLoading.showError("$data");
      // "Error Code : ${response.statusCode.toString()}");
    }
  }
}
