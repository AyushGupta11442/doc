import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/patientProfile/change_email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

// class Email extends StatelessWidget {
//   const Email({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(fontFamily: 'Poppins'),
//         debugShowCheckedModeBanner: false,
//         home: const MyHome());
//   }
// }
void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  String? email = SharedPreferencesHelper.getUserMail() ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Personal",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // Text(
            //   "6 questions left",
            //   style: TextStyle(fontSize: 16, color: Colors.white),
            // ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 180.0,
              child: Card(
                elevation: 8.0,
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.1), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          'Enter your Email',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: TextFormField(
                          initialValue: SharedPreferencesHelper.getUserMail(),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            isDense: true,
                          ),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 12.0, bottom: 12.0, right: 130, left: 130),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),

                minimumSize: const Size.fromHeight(45), // NEW
              ),
              onPressed: () {
                sendotp(email);
              },
              child: const Text("Send OTP"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendotp(String? email) async {
    try {
      if (email!.length > 10) {
        final response = await DioClinetToken.instance.dio!.post(
            '/customer/new_email',
            data: {'email': email, '_method': 'PUT'});
        var data = jsonDecode(response.toString());
        if (response.statusCode == 200) {
          Otp_Response otpRes = Otp_Response.fromJson(data);
          if (otpRes.data?.message == 'OTP send successfully..') {
            await EasyLoading.showSuccess("Otp sent successfully");
            print(email);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Change_email_Otp(email: email)),
            );
          } else {
            await EasyLoading.showError("${otpRes.data!.message}");
          }
        }
      } else {
        await EasyLoading.showError("Enter email correctly");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        // handle timeout error
        VxToast.show(
          context,
          msg: 'Connection Timeout',
          bgColor: Vx.black,
          textColor: Vx.white,
          showTime: 5000,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else if (e.type == DioErrorType.response) {
        await EasyLoading.showError(
            e.response!.data['data']['errors'][0].toString());
      } else {
        VxToast.show(
          context,
          msg: 'Something Went Wrong! Try Again',
          bgColor: Vx.black,
          textColor: Vx.white,
          showTime: 5000,
        );
      }
    }
  }
}

class Otp_Response {
  Data? data;

  Otp_Response({this.data});

  Otp_Response.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
