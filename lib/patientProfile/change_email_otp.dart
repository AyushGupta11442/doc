import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../patientProfile/patientpersonal/view/patientPersonal.dart';

class Change_email_Otp extends StatefulWidget {
  final String email;
  const Change_email_Otp({Key? key, required this.email}) : super(key: key);

  @override
  _Change_email_OtpState createState() => _Change_email_OtpState();
}

class _Change_email_OtpState extends State<Change_email_Otp> {
  final Color _appBarColor = Colors.lightBlueAccent;

  @override
  Widget build(BuildContext context) {
    String emailToPrint = widget.email;
    if (emailToPrint.length > 25) {
      emailToPrint = emailToPrint.substring(0, emailToPrint.length - 25);
      emailToPrint += 'xxxx@xxxxx.xxx';
    } else if (emailToPrint.length > 22) {
      emailToPrint = emailToPrint.substring(0, emailToPrint.length - 22);
      emailToPrint += 'xxxx@xxxxx.xxx';
    } else if (emailToPrint.length > 17) {
      emailToPrint = emailToPrint.substring(0, emailToPrint.length - 17);
      emailToPrint += 'xxxx@xxxxx.xxx';
    } else if (emailToPrint.length > 14) {
      emailToPrint = emailToPrint.substring(0, emailToPrint.length - 14);
      emailToPrint += 'xxxx@xxxxx.xxx';
    } else {
      emailToPrint = emailToPrint.substring(0, emailToPrint.length - 14);
      emailToPrint += 'xxxx@xxxxx.xxx';
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff14D2FF),
        title: const Text(
          "Enter OTP",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          // padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 120),
              const Text(
                'Please enter 6 digits OTP that has to be send',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                emailToPrint,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 140,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: const Offset(0.5, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "6 Digit OTP",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _textFieldOTP()
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: const Text(
                      "Resend 6 digits OTP?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2cd7ee),
                      ),
                    ),
                    onPressed: () {
                      resendotp();
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      check_otp();
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff14B2FF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Confirm OTP',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String digit1 = '';

  String digit2 = '';

  String digit3 = '';

  String digit4 = '';

  String digit5 = '';

  String digit6 = '';

  Widget _textFieldOTP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60,
          child: AspectRatio(
            aspectRatio: 0.8,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      digit1 = value;
                    });
                  } else {
                    setState(() {
                      digit1 = '';
                    });
                  }
                });
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: _appBarColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: AspectRatio(
            aspectRatio: 0.8,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      digit2 = value;
                      print(digit2);
                    });
                  } else {
                    setState(() {
                      digit2 = '';
                    });
                  }
                });
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: _appBarColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: AspectRatio(
            aspectRatio: 0.8,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      digit3 = value;
                      print(digit3);
                    });
                  } else {
                    setState(() {
                      digit3 = '';
                    });
                  }
                });
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: _appBarColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: AspectRatio(
            aspectRatio: 0.8,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      digit4 = value;
                    });
                  } else {
                    setState(() {
                      digit4 = '';
                    });
                  }
                });
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: _appBarColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: AspectRatio(
            aspectRatio: 0.8,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      digit5 = value;
                      print(digit5);
                    });
                  } else {
                    setState(() {});
                  }
                });
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: _appBarColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: AspectRatio(
            aspectRatio: 0.8,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      digit6 = value;
                      print(digit6);
                    });
                  } else {
                    setState(() {
                      digit6 = '';
                    });
                  }
                });
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: _appBarColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> check_otp() async {
    String otp = digit1 + digit2 + digit3 + digit4 + digit5 + digit6;
    print(digit1.length);
    print(widget.email);
    try {
      if (digit1.isNotEmpty &&
          digit2.isNotEmpty &&
          digit3.isNotEmpty &&
          digit4.isNotEmpty &&
          digit5.isNotEmpty &&
          digit6.isNotEmpty) {
        final response = await DioClinetToken.instance.dio!
            .post('/customer/edit_email', data: {
          'email': widget.email,
          'otp_token': otp,
          '_method': 'PUT'
        });
        var data = jsonDecode(response.toString());
        print(response.statusCode);
        if (response.statusCode == 200) {
          Otp_S_Response otpRes = Otp_S_Response.fromJson(data);
          if (otpRes.data?.message == 'Success') {
            await EasyLoading.showSuccess("Email changed successfully");
            SharedPreferencesHelper.setUserMail(widget.email);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const PatientPersonal(
                        screen: '1',
                      )),
                  (route) => route.isFirst,

            );
          } else {
            await EasyLoading.showError("${otpRes.data!.message}");
          }
        }
      } else {
        await EasyLoading.showInfo("Enter Otp correctly");
        rebuildAllChildren(context);
      }
    } on DioError catch (e) {
      print(e.response);
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else if (e.response!.statusCode == 422) {
        if (e.response!.data['data']['errors'] ==
            'The email has already been taken.') {
          print(e.response!.data['data']['errors'].toString());
          MaterialPageRoute(
              builder: (BuildContext context) => const PatientPersonal(
                    screen: '1',
                  ));
        }
        await EasyLoading.showError(
            e.response!.data['data']['errors'].toString());

        // String er = '';
        // for (String e in otpRes.data!.errors!) {
        //   if (e == 'OTP does not match.') {
        //     await EasyLoading.showSuccess("Enter Otp correctly");
        //     setState(() {});
        //   }else
        //   {
        //     er += er + e;
        //   }
        // }
        // if(er != ''){
        //   await EasyLoading.showError(er);
        // }
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
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Future<void> resendotp() async {
    try {
      final response = await DioClinetToken.instance.dio!.post(
          '/resend_customer_otp',
          data: {'email': widget.email, '_method': 'PUT'});
      var data = jsonDecode(response.toString());
      if (response.statusCode == 200) {
        Otp_S_Response otpRes = Otp_S_Response.fromJson(data);
        if (otpRes.data?.message == 'OTP re-send successfully') {
          await EasyLoading.showSuccess("Otp sent successfully");
        } else {
          await EasyLoading.showError("${otpRes.data!.message}");
        }
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
        Navigator.pushReplacement(
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

class Otp_S_Response {
  Data? data;

  Otp_S_Response({this.data});

  Otp_S_Response.fromJson(Map<String, dynamic> json) {
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

class Otp_e_Response {
  Datae? data;

  Otp_e_Response({this.data});

  Otp_e_Response.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Datae.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Datae {
  String? errors;

  Datae({this.errors});

  Datae.fromJson(Map<String, dynamic> json) {
    errors = json['errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = errors;
    return data;
  }
}
