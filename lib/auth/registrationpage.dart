import 'dart:developer';
import 'package:doctor/auth/loginpage.dart';
import 'package:doctor/controller/Registation_Controller.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    // margin: EdgeInsets.only(top: 10),
                    child: Image.network(
                      'https://doctrro.com/wp-content/uploads/2023/03/android-chrome-144x144-1.png',
                      width: 120,
                      height: 120,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _name,
                  validator: (String? Value) {
                    if (Value!.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  onSaved: (String? name) {},
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Enter Your Name",
                      fillColor: Colors.grey.shade100,
                      filled: true),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(top: 2, left: 23, right: 34),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 60,
                width: 370,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      "assets/images/india_flag.jpg",
                      height: 48,
                      width: 48,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      "+91",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        alignment: Alignment.center,
                        //margin: EdgeInsets.only(right: 25),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          controller: _phone,
                          textInputAction: TextInputAction.next,
                          validator: (String? Value) {
                            if (Value!.isEmpty) {
                              return "Please enter valid phone";
                            }
                            if (Value.length != 10) {
                              return "Please enter valid phone";
                            }
                            return null;
                          },
                          onSaved: (String? phone) {},
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: "Phone No",
                              fillColor: Colors.grey.shade100,
                              filled: true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _email,
                  textInputAction: TextInputAction.next,
                  validator: (String? Value) {
                    if (Value!.isEmpty) {
                      return "Please enter email";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(Value)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },

                  // validator: (String? Value) {
                  //   if (Value!.isEmpty) {
                  //     return "Please enter  email";
                  //   }
                  //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  //       .hasMatch(Value)) {
                  //     return "Please enter valid email";
                  //   }
                  //   return null;
                  // },
                  onSaved: (String? email) {},

                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Enter Your Email",
                      fillColor: Colors.grey.shade100,
                      filled: true),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _password,
                  validator: passwordValidator,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Create Password",
                      fillColor: Colors.grey.shade100,
                      filled: true),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _confirmpassword,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: ((value) => MatchValidator(
                          errorText: 'passwords do not match')
                      .validateMatch(_password.text, _confirmpassword.text)),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Confirm Password",
                      fillColor: Colors.grey.shade100,
                      filled: true),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 48,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      // RegistrationUser();
                      RegistaionController.registrationUserPost(
                        name: _name.text,
                        email: _email.text,
                        phoneNumber: _phone.text,
                        password: _password.text,
                        passwordConfirmation: _confirmpassword.text,
                        context: context,
                      );
                    } else {
                      log("Unsuccessfull");
                    }
                  },
                  color: const Color(0xff2cd7ee),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1484FF),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Future RegistrationUser() async {
  //   var APIURL = Uri.parse("https://api.doctrro.com/api/register");

  //   Map mapeddate = {
  //     'name': _name.text,
  //     'email': _email.text,
  //     'phone_number': _phone.text,
  //     'password': _password.text,
  //     'password_confirmation': _confirmpassword.text,
  //     'country_code': '+91'
  //   };
  //   //send  data using http post to our php code
  //   http.Response reponse = await http.post(APIURL, body: mapeddate);
  //   //getting response from php code, here
  //   var data = jsonDecode(reponse.body);
  //   log(reponse.statusCode.toString());

  //   if(reponse.statusCode == 201){
  //     Utils.toastMessage("Registration Successful");

  //     log("DATA: $data");

  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => LoginPage()));
  //       //TODO: token need form backend
  //       // SharedPreferencesHelper.setAuthToken(token);
  //   }
  //   else{

  //     Utils.toastMessage(data['data']['errors'][0].toString());
  //   }
  // }
}
