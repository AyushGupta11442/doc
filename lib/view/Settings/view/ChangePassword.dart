import 'package:dio/dio.dart';
import 'package:doctor/view/Settings/view/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../client/DioClientToken/DioClient_Token.dart';
import '../../../core/globalkey/globalkey.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

final TextEditingController _password = TextEditingController();
final TextEditingController _confirmpassword = TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _ChangePasswordState extends State<ChangePassword> {
  Future<void> reset() async {
    try {
      final response =
          await DioClinetToken.instance.dio!.put('/change_password', data: {
        'current_password': currentpassword,
        'new_password': new_password,
        'new_password_confirmation': conferm_password
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        await EasyLoading.showSuccess("Password Updated Successfully");
        Navigator.pop(context);
      } else if (response.statusCode == 422) {}
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

    // else{

    // }
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

  String currentpassword = '';
  String new_password = '';
  String conferm_password = '';
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: GestureDetector(
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
                'Change Password',
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enter your current password',
                      style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {},
                      child: TextField(
                        // obscureText: true,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'current password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300)),
                        onChanged: (value) {
                          currentpassword = value;
                        },
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
                        controller: _password,
                        validator: passwordValidator,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'new password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300)),
                        onChanged: (value) {
                          setState(() {
                            new_password = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {},
                      child: TextFormField(
                        controller: _confirmpassword,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            conferm_password = value;
                          });
                        },
                        textInputAction: TextInputAction.done,
                        validator: ((value) =>
                            MatchValidator(errorText: 'passwords do not match')
                                .validateMatch(
                                    _password.text, _confirmpassword.text)),
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'confirm new password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300)),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Text('Forgot password?',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              MaterialButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    reset();
                  }
                },
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
