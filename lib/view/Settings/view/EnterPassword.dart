import 'package:dio/dio.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../provider/shared_pref_helper.dart';

class EnterPassword extends StatefulWidget {
  const EnterPassword({Key? key, this.email, this.phone, required this.otpType})
      : super(key: key);
  final String? email;
  final String? phone;
  final int otpType;
  // final String? phone;

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

final TextEditingController _password = TextEditingController();
final TextEditingController _confirmpassword = TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _EnterPasswordState extends State<EnterPassword> {
  int type = 0;
  String otp = '';
  String new_password = '';
  String confirm_Password = '';
  Future<dynamic> resetPassword() async {
    try {
      print(otp);
      final response = await DioClinetToken.instance.dio!
          .post('/reset_password/${widget.otpType}',
              data: widget.otpType == 0
                  ? {
                      'otp': otp,
                      'password': new_password,
                      'password_confirmation': confirm_Password,
                      'email': widget.email
                    }
                  : {
                      'otp': otp,
                      'password': new_password,
                      'password_confirmation': confirm_Password,
                      'phone_number': widget.phone
                    });
      if (response.statusCode == 200 &&
          SharedPreferencesHelper.getAuthToken() == null) {
        EasyLoading.showSuccess("Password Changed Successfully");
        Get.toNamed("/login");
      } else {
        Navigator.pop(context);
      }
      return response;
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
    }
  }

  void resendotp() async {
    try {
      print(widget.email);
      final response = await DioClinetToken.instance.dio!.post(
          '/resend_customer_otp',
          data: {'email': widget.email, '_method': 'PUT'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          // resend_otpresponse = response.data['data']['message'].toString();
          // resend_error = false;
          // otpresponse = "";
        });
        await EasyLoading.showSuccess("Otp sent on your email");
      } else {
        print("else");
        // setState(() {
        //   resend_error_text = response.data['data']['message'];
        //   resend_error = true;
        // });
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
    }
  }

  void resendotpPhone() async {
    try {
      print(widget.email);
      final response = await DioClinetToken.instance.dio!.post(
          '/customer/resend_phone_otp',
          data: {'phone_number': widget.phone, '_method': 'PUT'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          // resend_otpresponse = response.data['data']['message'].toString();
          // resend_error = false;
          // otpresponse = "";
        });
        await EasyLoading.showSuccess("Otp sent on your Phone");
      } else {
        print("else");
        // setState(() {
        //   resend_error_text = response.data['data']['message'];
        //   resend_error = true;
        // });
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
    }
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
        errorText:
            'passwords must have at least one uppercase,\n one lowercase, one number and\n one special character')
    // errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Row(
            children: const [
              Icon(
                Icons.key,
                color: Colors.black,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Enter Password',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formkey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter OTP',
                  style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {},
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                        print(otp);
                      });
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.phone,
                    validator: (String? Value) {
                      if (Value!.isEmpty) {
                        return "Please enter otp";
                      }
                      if (Value.length != 6) {
                        return "Please enter valid otp";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'OTP',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter new password',
                  style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {},
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        new_password = value;
                      });
                    },
                    controller: _password,
                    validator: passwordValidator,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'new password',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {},
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        confirm_Password = value;
                      });
                    },
                    controller: _confirmpassword,
                    validator: ((value) => MatchValidator(
                            errorText: 'passwords do not match')
                        .validateMatch(_password.text, _confirmpassword.text)),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'confirm new password',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300)),
                  ),
                ),
              ),
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
                  if (widget.otpType == 0) {
                    resendotp();
                  } else {
                    resendotpPhone();
                  }

                  // setState(() {
                  //   resend_text_to_print = true;
                  // });
                },
              ),
            ]),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              elevation: 2,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  resetPassword();
                }
              },
              color: Colors.blue,
              elevation: 2,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      );
}
