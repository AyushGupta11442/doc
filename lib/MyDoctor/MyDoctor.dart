import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/MyDoctor/widgets/doctorCard.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Home/view/Homepage.dart';
import '../widget/CircleProgress.dart';
import 'models/DoctorClass.dart';

// class MyDoctor extends StatelessWidget {
//   const MyDoctor({Key? key}) : super(key: key);

@override
// Widget build(BuildContext context) {
//   return MaterialApp(
//       theme: ThemeData(fontFamily: 'Poppins'),
//       debugShowCheckedModeBanner: false,
//       home: MyHome());
// }
// }

class MyDoctor extends StatefulWidget {
  const MyDoctor({Key? key}) : super(key: key);

  @override
  State<MyDoctor> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyDoctor> {
  bool isload = false;
  bool value = false;
  late mydoctor_class doctor_list;

  void getDoctors() async {
    try {
      final response = await DioClinetToken.instance.dio!.get('/doctors_list');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.toString());
        setState(() {
          doctor_list = mydoctor_class.fromJson(data);
          isload = true;
        });
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else if (e.response?.statusCode != null) {
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

  @override
  void initState() {
    getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          backgroundColor: const Color(0xFF14Dfff),
          title: const Text(
            'My Doctors',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: (isload)
            ? SingleChildScrollView(
                child: doctor_list.data!.doctor!.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 16,
                          ),
                          for (Doctor d in doctor_list.data!.doctor!)
                            DoctorCard(
                              doctor: d,
                            )
                        ],
                      )
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "The Doctors you have booked appointment with, will show up here",
                              overflow: TextOverflow.visible,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
              )
            : circularProgressIndicator());
  }
}
