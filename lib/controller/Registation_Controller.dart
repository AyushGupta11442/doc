import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor/auth/otpscreenEmail.dart';
import 'package:doctor/client/DioClinet.dart/DioClient.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../main.dart';
import '../provider/shared_pref_helper.dart';

class RegistaionController {
  static Future<void> registrationUserPost({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
    required BuildContext context,
  }) async {
    // var APIURL = Uri.parse("https://api.doctrro.com/api/customer/register");
    Map mapeddate = {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'country_code': '+91'
    };

    // http.Response reponse = await http.post(APIURL, body: mapeddate);
    try {
      Response response = await DioClinet.instance.dio!.post(
        '/customer/register',
        data: mapeddate,
      );
      //getting response from php code, here
      var data = response.data;
      var success = data['data']['message'];
      print("messege" + success);
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        print(data['data']['token']);
        myToken = data['data']['token'];
        SharedPreferencesHelper.setAuthToken(myToken!);
        VxToast.show(
          context,
          msg: "Registration Successful",
          bgColor: Vx.black,
          textColor: Vx.white,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OtpEmail(email: email)),
        );
        // loginInfo.isLogin = true;
        // context.go(
        //   RouteNames.loginScreen,
        // );
      } else {
        VxToast.show(
          context,
          msg: data['data']['errors[0]'].toString(),
          bgColor: Vx.black,
          textColor: Vx.white,
          showTime: 5000,
        );
      }
    } on DioError catch (e)  {
      // print( "error ----> $e" );
       print(e.response!.data);
       print(e.type);

       if (e.type == DioErrorType.connectTimeout  ||
          e.type == DioErrorType.receiveTimeout) {
        // handle timeout error
      VxToast.show(
          context,
          msg: 'Connection Timeout',
          bgColor: Vx.black,
          textColor: Vx.white,
          showTime: 5000,
        );

      } else if(e.type == DioErrorType.response){
        await EasyLoading.showError(e.response!.data['data']['errors'].toString());
      }
    }
  }
}
