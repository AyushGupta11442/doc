import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/appointment/reschedule.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../appointment/UpcomingAppointments.dart';
import '../appointment/models/AppointmentClass.dart';

class Appointment_Confirmation extends StatefulWidget {
  const Appointment_Confirmation({
    Key? key,
    this.appointment,
    this.string1,
    this.string2,
    this.string3,
    this.image,
  }) : super(key: key);
  final Appointment? appointment;
  final String? string1;
  final String? string2;
  final String? string3;
  final String? image;
  @override
  State<Appointment_Confirmation> createState() =>
      _Appointment_ConfirmationState();
}

class _Appointment_ConfirmationState extends State<Appointment_Confirmation> {
  bool value = false;
  bool iscancel = false;
  bool isResheduled = false;
  bool notShow = false;
  bool isCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.appointment!.status == -2 || widget.appointment!.status == -3) {
      iscancel = true;
    } else if (widget.appointment!.status == -1) {
      notShow = true;
    } else if (widget.appointment!.status == 1) {
      isResheduled = true;
    }
    else if (widget.appointment!.status == 4) {
      isCompleted = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Appointment Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150.0,
              child: Card(
                elevation: 4.0,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.4),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            //or 15.0
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              color: const Color(0x00b2e2fc),
                              child: image(widget.image,
                                  'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.image}'),
                            ),
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.appointment!.doctor_name.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  widget.appointment!.doctor_speciality
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.string2.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    widget.string3.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80.0,
              width: 380,
              child: Card(
                color: const Color(0xFF14DFFF),
                elevation: 4.0,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black.withOpacity(0),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.appointment!.clinic_name.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //  Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //    widget.appointment..toString() ,

                      //     textAlign: TextAlign.start,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            (iscancel)
                ? SizedBox(
                    height: 80.0,
                    width: 430,
                    child: Card(
                      color: Colors.red.withOpacity(0.1),
                      elevation: 0.0,
                      margin: const EdgeInsets.all(10),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Appointment has been cancelled',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                            Icon(
                              Icons.cancel_outlined,
                              size: 25.0,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : isResheduled
                    ? SizedBox(
                        height: 80.0,
                        width: 430,
                        child: Card(
                          color: Colors.orange.withOpacity(0.1),
                          elevation: 0.0,
                          margin: const EdgeInsets.all(10),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.orange,
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Text(
                                  'Appointment has been Resheduled',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.orange,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_month,
                                  size: 25.0,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : notShow
                        ? SizedBox(
                            height: 80.0,
                            width: 430,
                            child: Card(
                              color: Colors.red.withOpacity(0.1),
                              elevation: 0.0,
                              margin: const EdgeInsets.all(10),
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Text(
                                      'Appointment has expired',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Icon(
                                      Icons.cancel_outlined,
                                      size: 25.0,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        :isCompleted?SizedBox(
                            height: 80.0,
                            width: 430,
                            child: Card(
                              color: Colors.green.withOpacity(0.1),
                              elevation: 0.0,
                              margin: const EdgeInsets.all(10),
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.green,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Text(
                                      'Appointment has been completed',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Icon(
                                      Icons.done_all_outlined,
                                      size: 25.0,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ): const SizedBox(),
            SizedBox(
              child: Card(
                elevation: 8.0,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.4), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.appointment!.date.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.appointment!.slotTiming.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 0.8,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Text(
                                'Appointment for',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.appointment!.appointmentFor.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              const Text(
                                'Appointment ID',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.appointment!.id.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: iscancel == false &&
              notShow == false &&
              isCompleted == false && isResheduled == false
          ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AppointmentRescheduling(
                              appointment: widget.appointment,
                              string1: widget.string1.toString(),
                              string2: widget.string2.toString(),
                              string3: widget.string3.toString(),
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff14b2ff)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          "Reschedule",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cancel_appoin();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff14b2ff)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text("Cancel"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : isResheduled
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            cancel_appoin();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff14b2ff)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Text("Cancel"),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
    );
  }

  Future<void> cancel_appoin() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .get('/appointment_delete/${widget.appointment!.id!}');
      var data = jsonDecode(response.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        Responsee response = Responsee.fromJson(data);
        if (response.data?.message == 'Appointment Deleted') {
          setState(() {
            iscancel = true;
          });
           Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const UpcomingAppointments(),
            ),
            (route) => route.isFirst,
          );
        } else {
          await EasyLoading.showError(response.data!.errors![0].toString());
        }
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
}

class Responsee {
  Data? data;

  Responsee({this.data});

  Responsee.fromJson(Map<String, dynamic> json) {
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
  List? errors;
  String? message;

  Data({this.errors, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors!.add(v);
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

Widget image(String? image, String imageURL) {
  if (image != null) {
    return Container(
        width: 90,
        height: 100,
        margin: const EdgeInsets.only(left: 8, top: 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                  imageURL,
                ),
                fit: BoxFit.fill)));
  } else {
    return Container(
      width: 90,
      height: 100,
      margin: const EdgeInsets.only(left: 8, top: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
            image: AssetImage('assets/images/docto.png'), fit: BoxFit.fill),
      ),
    );
  }
}
