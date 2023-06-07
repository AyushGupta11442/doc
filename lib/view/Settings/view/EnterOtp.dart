import 'package:doctor/auth/loginpage.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  String? email;
  Otp({Key? key, this.email}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final Color _appBarColor = Colors.lightBlueAccent;
  String token = '';
  late String otpresponse;
  late String resend_otpresponse;
  late bool text_to_print = false;
  late bool resend_text_to_print = false;
  void getresponse() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .put('/customer/account_disable/confirm', data: {'otp_token': token });

      setState(() {
        otpresponse = response.data['data'].toString();
      });
    } catch (e) {
      print(e);
    }
  }

  void resendotp() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .put('/verify_customer_otp', data: {'otp_token': token});

      setState(() {
        resend_otpresponse = response.data['data']['message'].toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const Text(
                "email",
                style: TextStyle(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (text_to_print)
                Text(
                  otpresponse.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              if (text_to_print)
                Text(
                  resend_otpresponse.toString(),
                  style: const TextStyle(color: Colors.red),
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
                      setState(() {
                        resend_text_to_print = true;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      getresponse();
                      if (otpresponse == 'Your Email is Varified') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                        );
                      } else {
                        setState(() {
                          text_to_print = true;
                        });
                      }
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

  Widget _textFieldOTP({bool? first, last}) {
    return SizedBox(
      height: 60,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
              token += value;
              print(token);
            }
            if (value.length == 1 && last == true) {
              token += value;
              print(token);
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
              token = token.substring(0, token.length - 1);
              print(token);
            }
            if (value.isEmpty && first == true) {
              token = token.substring(0, token.length - 1);
              print(token);
            }
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
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: _appBarColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
