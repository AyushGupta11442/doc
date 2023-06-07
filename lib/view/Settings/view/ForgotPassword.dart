import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:doctor/view/Settings/view/EnterPassword.dart';
import 'package:flutter/material.dart';

enum otp { sms, email }

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  otp? selected;
  String token = SharedPreferencesHelper.getAuthToken();

  Future<void> Email() async {
    final response = await DioClinetToken.instance.dio!.post(
        '/forgot_password/0',
        data: {'email': SharedPreferencesHelper.getUserMail().toString()});
  }

  Future<void> SMS() async {
    log(SharedPreferencesHelper.getUserPhone().toString());

    final response = await DioClinetToken.instance.dio!
        .post('/forgot_password/1', data: {
      'phone_number': SharedPreferencesHelper.getUserPhone().toString()
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
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
                'Reset Password',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SharedPreferencesHelper.getUserImage().isEmpty
                        ? Image.asset(
                            'assets/images/sourav.png',
                            // width: double.infinity,
                            // fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            backgroundImage: CachedNetworkImageProvider(
                              'https://api.doctrro.com/assets/uploads/customer/profile_pictures/${SharedPreferencesHelper.getUserImage()}',
                              // width: double.infinity,
                              // fit: BoxFit.cover,
                            ),
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(SharedPreferencesHelper.getUserName().toString())
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    'How do you want to recieve the code to reset your password?'),
                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Send otp via SMS',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              SharedPreferencesHelper.getUserPhone().toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                        Radio<otp>(
                            value: otp.sms,
                            groupValue: selected,
                            onChanged: (value) {
                              setState(() {
                                selected = value;
                              });
                            })
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Send otp via Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              SharedPreferencesHelper.getUserMail().toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                        Radio<otp>(
                            value: otp.email,
                            groupValue: selected,
                            onChanged: (value) {
                              setState(() {
                                selected = value;
                              });
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
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
                if (selected == otp.email) {
                  Email();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnterPassword(
                                email: SharedPreferencesHelper.getUserMail(),
                                otpType: 0,
                              )));
                } else {
                  SMS();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnterPassword(
                                otpType: 1,
                                phone: SharedPreferencesHelper.getUserPhone(),
                              )));
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
