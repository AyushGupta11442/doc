import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../main.dart';
import '../provider/shared_pref_helper.dart';
import 'package:dio/dio.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpEmail extends StatefulWidget {
  String email;
  OtpEmail({Key? key, required this.email}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OtpEmail> {
  final Color _appBarColor = Colors.lightBlueAccent;
  String token = '';
  late String otpresponse = "";
  late String resend_otpresponse = "";
  late String resend_error_text = "";
  late bool text_to_print = false;
  late bool resend_error = false;
  void resendotp() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .put('/resend_customer_otp', data: {'email': widget.email});
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          resend_otpresponse = response.data['data']['message'].toString();
          resend_error = false;
          otpresponse = "";
        });
        await EasyLoading.showSuccess("Otp sent on your email");
      } else {
        print("else");
        setState(() {
          resend_error_text = response.data['data']['message'];
          resend_error = true;
        });
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
      } else if (e.type == DioErrorType.response) {
        await EasyLoading.showError(
            e.response!.data['data']['errors'][0].toString());
      }
      rethrow;
    }
  }
  void verifyOtp() async {
    print(token);
    String otp = digit1 + digit2 + digit3 + digit4 + digit5 + digit6;
    print(digit1.length);
    try {
      if (digit1.isNotEmpty &&
          digit2.isNotEmpty &&
          digit3.isNotEmpty &&
          digit4.isNotEmpty &&
          digit5.isNotEmpty &&
          digit6.isNotEmpty) {
        final response = await DioClinetToken.instance.dio!
            .put('/verify_customer_otp', data: {'email_otp_token': otp ,});
        //print(response.statusCode);
        var json = response.data;
        setState(() {
          otpresponse = response.data['data']['success'].toString();
          resend_otpresponse = "";
          text_to_print = false;
        });
        if (otpresponse == "Your Email is Verified.") {
          //  setState(() {

          //  });
          loginInfo.isLogin = true;
          // await EasyLoading.showSuccess("Your Email is Verified");
          // await EasyLoading.showSuccess(otpresponse);
          SharedPreferencesHelper.setUserName(
              json['data']['customer']['name'].toString());
          SharedPreferencesHelper.setUserMail(
              json['data']['customer']['email'].toString());
          SharedPreferencesHelper.setUserId(json['data']['customer']['id']);
          SharedPreferencesHelper.setUserImage(
              json['data']['customer']['image_file'].toString());
          SharedPreferencesHelper.setUserPhone(
              json['data']['customer']['phone_number'].toString());
          SharedPreferencesHelper.setUserGender(
              json['data']['customer']['gender'].toString());

          // await Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          setState(() {
            // text_to_print = true;
          });
          await EasyLoading.showSuccess(
              "Please enter OTP correctly and try again!");
        }
      } else {
        await EasyLoading.showSuccess(
            "Please enter OTP correctly and try again!");
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
      rethrow;
    }
  }

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
                    _textFieldOTP(),
                    // OTPTextField(
                    //   length: 6,
                    //   width: double.infinity,
                    //   fieldWidth: 35,
                    //   spaceBetween: 2,
                    //   keyboardType: TextInputType.number,
                    //   style: const TextStyle(fontSize: 16),
                    //   textFieldAlignment: MainAxisAlignment.spaceAround,
                    //   fieldStyle: FieldStyle.box,
                    //   onCompleted: (pin) {
                    //     setState(() {
                    //       token = pin;
                    //     });
                    //     print("Completed: " + pin);
                    //   },
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // if (text_to_print)
              //   Text(
              //     otpresponse.toString(),
              //     style: const TextStyle(color: Colors.red),
              //   ),
              // if (resend_error)
              //   Text(
              //     resend_error_text.toString(),
              //     style: const TextStyle(color: Colors.red),
              //   ),
              // if (!resend_error)
              //   Text(
              //     resend_otpresponse.toString(),
              //     style: const TextStyle(color: Colors.green),
              //   ),
              // const SizedBox(
              //   height: 30,
              // ),
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
                      // setState(() {
                      //   resend_text_to_print = true;
                      // });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      verifyOtp();
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
}
