import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../main.dart';
import '../provider/shared_pref_helper.dart';

class AuthController {
// ! logout
  Future<void> logout(BuildContext context) async {
    try {
      String url = '/logout';
      // token
      String? token = SharedPreferencesHelper.getAuthToken();
      var response = await DioClinetToken.instance.dio!.get(
        url,
      );
      if (response.statusCode == 200) {
        VxToast.show(
          context,
          msg: response.data['data']['message'],
          bgColor: Vx.black,
        );

         SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();


        loginInfo.isLogin = false;
      }
      VxToast.show(context, msg: response.data['data']['message']);
    } on DioError catch (e) {
      log(
        e.toString(),
      );
    }
  }
}
