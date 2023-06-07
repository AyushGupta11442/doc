import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor/auth/registrationpage.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../api/ApiService.dart';
import '../client/DioClientToken/DioClient_Token.dart';
import '../core/constants.dart';
import '../view/Settings/view/EnterPassword.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool visible = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  // late String email;
  // late String password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String token = SharedPreferencesHelper.getAuthToken();
    log("token: $token");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<dynamic> Email(String email) async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/forgot_password/0', data: {'email': email });

      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnterPassword(
                      email: email, otpType: 0,
                    )));
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
        await EasyLoading.showError(e.response!.data['data']['errors'][0].toString());
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Form(
          key: globalFormKey,
          autovalidateMode: AutovalidateMode.always,
          child: Focus(
            autofocus: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            height: 200,
                            // decoration: const BoxDecoration(
                            //   image: DecorationImage(
                            //       image: AssetImage("assets/images/doctor.jpg"),
                            //       fit: BoxFit.fitHeight),
                            // ),
                            child: Image.network(
                              'https://doctrro.com/wp-content/uploads/2023/03/android-chrome-144x144-1.png',
                              width: 120,
                              height: 120,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          autofocus: true,

                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          // onChanged: (value) {
                          //   setState(() {
                          //     email = value;
                          //   });
                          // },
                          onFieldSubmitted: (v) {},
                          validator: (value) {
                            RegExp regex = RegExp(pattern);
                            if (value!.isEmpty) {
                              return "Please enter a email";
                            } else if (!regex.hasMatch(value)) {
                              return 'Email format is invalid';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: "Enter Your Email",
                              fillColor: Colors.grey.shade100,
                              filled: true),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          autofocus: true,
                          // onChanged: (value) {
                          //   setState(() {
                          //     password = value;
                          //   });
                          // },

                          textInputAction: TextInputAction.next,
                          controller: _passwordController,

                          // validator: passwordValidator,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: "Password",
                              fillColor: Colors.grey.shade100,
                              filled: true),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 42),
                      InkWell(
                          onTap: () async {
                            //print(password);
                            //print(email);
                            FocusScope.of(context).unfocus();
                            if (globalFormKey.currentState!.validate()) {
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              await HttpService.login(email, password, context);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: const Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontFamily: 'Poppins SemiBold',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xff14DFFF),
                                borderRadius: BorderRadius.circular(8)),
                          )),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextButton(
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontFamily: 'Poppins SemiBold',
                                  fontSize: 15,
                                  color: Color(0xff1484FF),
                                ),
                              ),
                              onPressed: () {
                                if (_emailController.text.isNotEmpty) {
                                  String email = _emailController.text;

                                  Email(email);
                                  // .then((res) => {
                                  //       // print("res" + res),
                                  //     }
                                  //     );
                                } else {
                                  EasyLoading.showError(
                                      "Please enter your email");
                                }
                              },
                            ),
                          ),
                          //SizedBox(width : 15),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextButton(
                              child: const Text(
                                "Sign up for Doctrro",
                                style: TextStyle(
                                  fontFamily: 'Poppins SemiBold',
                                  fontSize: 15,
                                  color: Color(0xff1484FF),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationPage()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
