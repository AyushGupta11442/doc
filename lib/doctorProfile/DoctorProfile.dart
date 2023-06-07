import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/doctorProfile/modal/Clinic_about.dart';
import 'package:doctor/doctorProfile/modal/clininc_review.dart';
import 'package:doctor/widget/CircleProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Home/view/modals/ssearch_by_clinic_id.dart';
import '../appointmentBooking/doctorappoint.dart';
import '../appointmentBooking/models/dateClass.dart';
import '../appointmentBooking/models/slotClass.dart';
import '../core/constants.dart';
import '../view/clinicReview/view/AllReviews.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile({Key? key, required this.id, this.screen = "2"})
      : super(key: key);
  final int id;
  final String? screen;

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

late Doctor_about_class doc_about;

class _DoctorProfileState extends State<DoctorProfile> {
  bool isload = false;
  bool reviewLoaded = false;
  void getDoctorabout() async {
    final response = await DioClinetToken.instance.dio!
        .get('/doctor/' + widget.id.toString());
    var data = jsonDecode(response.toString());
    setState(() {
      doc_about = Doctor_about_class.fromJson(data);
      get_speciality();
    });
  }

  String doc_speciality = '';
  List doc_speciality_list = [];
  void get_speciality() {
    for (Speciality s in doc_about.data!.speciality!) {
      doc_speciality += '${s.name.toString()}/';
      doc_speciality_list.add(s.name.toString());
    }
    setState(() {
      isload = true;
    });
  }

  late Review_class review;

  void GetReview() async {
    final response = await DioClinetToken.instance.dio!
        .get('/doctor_reviews/' + widget.id.toString());
    var data = jsonDecode(response.toString());
    setState(() {
      review = Review_class.fromJson(data);
      reviewLoaded = true;
    });
  }

  late String screen = '2';
  Color Appointmentcolor = Colors.white;
  Color Appointmenttextcolor = const Color(0xFF14B2ff);
  Color Appointmentbordercolor = const Color(0xFF14B2ff);
  Color Aboutcolor = const Color(0xFF14B2ff);
  Color Abouttextcolor = Colors.white;
  Color Aboutbordercolor = const Color(0xFF14B2ff);
  Color Reviewscolor = Colors.white;
  Color Reviewstextcolor = const Color(0xFF14B2ff);
  Color Reviewsbordercolor = const Color(0xFF14B2ff);
  @override
  void initState() {
    getDoctorabout();
    GetReview();
    getclinics();
    if (widget.screen! == "1") {
      setState(() {
        screen = widget.screen!;
        Appointmentcolor = const Color(0xFF14B2ff);
        Appointmenttextcolor = Colors.white;
        Appointmentbordercolor = const Color(0xFF14B2ff);
        Aboutcolor = Colors.white;
        Abouttextcolor = const Color(0xFF14B2ff);
        Aboutbordercolor = const Color(0xFF14B2ff);
        Reviewscolor = Colors.white;
        Reviewstextcolor = const Color(0xFF14B2ff);
        Reviewsbordercolor = const Color(0xFF14B2ff);
      });
    }
    super.initState();
  }

  bool value = false;
  List<Clinices> clinics = [];
  List<slotClass> Today_slots = [];
  List<slotClass> Tomorrow_slots = [];
  List<slotClass> NExtDay_slots = [];

  //arguments for next page
  slotClass? selectedSlot;
  dateClass? selectedDate;
  Clinices? selectedClinic;
  List<slotClass> selectedSlots = [];

  dateClass? today;
  dateClass? tomorrow;
  dateClass? dayAfterTomorrow;

  var today_reqDate;
  var tomorrow_reqDate;
  var next_reqDate;
  // var doctorId;
  var slotId = 0;
  dynamic clinicId = 0;
  void getclinics() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .get('/doctor_clinic_list/' + widget.id.toString());

      var _clinics = response.data['data']['clinic'];
      if (response.statusCode == 200) {
        for (var cl in _clinics) {
          Clinices c = Clinices.fromJson(cl);

          clinics.add(c);
        }

        print(clinics);
        if (clinics.isNotEmpty) {
          selectedClinic = clinics.first;
          clinicId = clinics.first.id;
        }
        setState(() {});
      }

      getDates();
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

  void get_today_Slots() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/today_available_slots', data: {
        "clinic_id": selectedClinic!.id,
        "doctor_id": widget.id,
        "date": today_reqDate
      });

      var _slots = response.data['data']['today_slots_available'];
      if (response.statusCode == 200) {
        for (var sl in _slots) {
          slotClass slt = slotClass(
              id: sl['id'],
              availableSlot: sl['available_slot'],
              day: sl['day'],
              status: sl['status']);

          Today_slots.add(slt);
          print(Today_slots);
        }
        setState(() {});
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

  void get_tomorrow_Slots() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/today_available_slots', data: {
        "clinic_id": selectedClinic!.id,
        "doctor_id": widget.id,
        "date": tomorrow_reqDate
      });

      var _slots = response.data['data']['today_slots_available'];
      if (response.statusCode == 200) {
        for (var sl in _slots) {
          slotClass slt = slotClass(
              id: sl['id'],
              availableSlot: sl['available_slot'],
              day: sl['day'],
              status: sl['status']);

          Tomorrow_slots.add(slt);
        }
        setState(() {});
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

  void get_nextday_Slots() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/today_available_slots', data: {
        "clinic_id": selectedClinic!.id,
        "doctor_id": widget.id,
        "date": next_reqDate
      });

      var _slots = response.data['data']['today_slots_available'];
      if (response.statusCode == 200) {
        for (var sl in _slots) {
          slotClass slt = slotClass(
              id: sl['id'],
              availableSlot: sl['available_slot'],
              day: sl['day'],
              status: sl['status']);

          NExtDay_slots.add(slt);
        }
        setState(() {});
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

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Select Clinic',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (Clinices cl in clinics)
              Builder(builder: (context) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cl.name.toString(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(cl.address.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400))
                    ],
                  ),
                  leading: Radio(
                    value: cl.id!,
                    groupValue: clinicId,
                    onChanged: (value) {
                      setState(() {
                        clinicId = value;
                        selectedClinic = cl;
                        Today_slots = [];
                        Tomorrow_slots = [];
                        NExtDay_slots = [];
                        selectedSlots = [];
                        get_today_Slots();
                        get_tomorrow_Slots();
                        get_nextday_Slots();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  dateClass convertdate(DateTime today) {
    var day = today.day.toString();
    var month = today.month.toString();
    var year = today.year.toString();

    List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    if (int.parse(month) < 10) {
      month = '0' + month;
    }
    if (int.parse(day) < 10) {
      day = '0' + day;
    }

    String date = day + "-" + month + "-" + year;

    dateClass d = dateClass(
        date: date,
        day: weekdays[today.weekday - 1],
        dateString: today.toString().substring(0, 10));

    return d;
  }

  void getDates() {
    setState(() {
      today = convertdate(DateTime.now());
      tomorrow = convertdate(DateTime.now().add(const Duration(hours: 24)));
      dayAfterTomorrow = convertdate(DateTime.now().add(const Duration(
          hours:
              48))); //TODO: change it to 48 hours to show the day after tommrorrow, right now its like this bcs any slots arent avaiable in this time

      today_reqDate = today!.date.toString();
      tomorrow_reqDate = tomorrow!.date.toString();
      print(tomorrow_reqDate);
      next_reqDate = dayAfterTomorrow!.date.toString();
    });

    get_today_Slots();
    get_tomorrow_Slots();
    get_nextday_Slots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0xFF14DFFF),
          title: const Text('Doctor Profile'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(
          //       Icons.share,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       // do something
          //     },
          //   )
          // ],
        ),
        body: (isload != false)
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 151.0,
                        child: Card(
                          elevation: 4.0,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black.withOpacity(0.2),
                              width: 1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.0), //or 15.0
                                      child: Container(
                                          height: 90.0,
                                          width: 90.0,
                                          color: const Color(0x00b2e2fc),
                                          child: image(
                                              doc_about.data!.doctor!.imageFile,
                                              'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${doc_about.data!.doctor!.imageFile}')),
                                    ),
                                    const SizedBox(
                                      width: 18.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          doc_about.data!.doctor!.name!,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0, right: 32.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 160,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                        doc_speciality,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Icon(
                                              Icons.thumb_up_sharp,
                                              size: 16.0,
                                              color: Color(0xFF14ffb8),
                                            ),
                                            const SizedBox(
                                              width: 4.0,
                                            ),
                                            (reviewLoaded)
                                                ? Text(
                                                    '${review.data!.doctorRecomended}',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                : SizedBox(),
                                            const SizedBox(width: 50),
                                            Text(
                                              'Experience : ${doc_about.data!.doctor!.experience} yr',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 4, right: 4),
                              child: InkWell(
                                child: Container(
                                  height: 48.0,
                                  width: 115.0,
                                  decoration: BoxDecoration(
                                      color: Appointmentcolor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                        color: Appointmentbordercolor,
                                        width: 2,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Appointment",
                                      style: TextStyle(
                                          color: Appointmenttextcolor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: (() {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (BuildContext context) =>
                                  //             DoctorAppoint(
                                  //               id: doc_about.data!.doctor!.id!,
                                  //               imagefile: doc_about
                                  //                   .data!.doctor!.imageFile,
                                  //               name:
                                  //                   doc_about.data!.doctor!.name!,
                                  //               speciality: doc_speciality,
                                  //             )));
                                  setState(() {
                                    Appointmentcolor = const Color(0xFF14B2ff);
                                    Appointmenttextcolor = Colors.white;
                                    Appointmentbordercolor =
                                        const Color(0xFF14B2ff);
                                    Aboutcolor = Colors.white;
                                    Abouttextcolor = const Color(0xFF14B2ff);
                                    Aboutbordercolor = const Color(0xFF14B2ff);
                                    Reviewscolor = Colors.white;
                                    Reviewstextcolor = const Color(0xFF14B2ff);
                                    Reviewsbordercolor =
                                        const Color(0xFF14B2ff);
                                    screen = "1";
                                  });
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 4, right: 4),
                              child: InkWell(
                                child: Container(
                                  height: 48.0,
                                  width: 115.0,
                                  decoration: BoxDecoration(
                                      color: Aboutcolor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                        color: Aboutbordercolor,
                                        width: 2,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "About",
                                      style: TextStyle(
                                          color: Abouttextcolor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: (() {
                                  setState(() {
                                    Appointmentcolor = Colors.white;
                                    Appointmenttextcolor =
                                        const Color(0xFF14B2ff);
                                    Appointmentbordercolor =
                                        const Color(0xFF14B2ff);
                                    Aboutcolor = const Color(0xFF14B2ff);
                                    Abouttextcolor = Colors.white;
                                    Aboutbordercolor = const Color(0xFF14B2ff);
                                    Reviewscolor = Colors.white;
                                    Reviewstextcolor = const Color(0xFF14B2ff);
                                    Reviewsbordercolor =
                                        const Color(0xFF14B2ff);
                                    screen = "2";
                                  });
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 4, right: 4),
                              child: InkWell(
                                child: Container(
                                  height: 48.0,
                                  width: 115.0,
                                  decoration: BoxDecoration(
                                      color: Reviewscolor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                        color: Reviewsbordercolor,
                                        width: 2,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Reviews",
                                      style: TextStyle(
                                          color: Reviewstextcolor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: (() {
                                  setState(() {
                                    Appointmentcolor = Colors.white;
                                    Appointmenttextcolor =
                                        const Color(0xFF14B2ff);
                                    Appointmentbordercolor =
                                        const Color(0xFF14B2ff);
                                    Aboutcolor = Colors.white;
                                    Abouttextcolor = const Color(0xFF14B2ff);
                                    Aboutbordercolor = const Color(0xFF14B2ff);
                                    Reviewscolor = const Color(0xFF14B2ff);
                                    Reviewstextcolor = Colors.white;
                                    Reviewsbordercolor =
                                        const Color(0xFF14B2ff);
                                    screen = "3";
                                  });
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Screen(),
                    ],
                  ),
                ),
              )
            : circularProgressIndicator());
  }

  Widget Screen() {
    // {
    // // if (screen == '1') {
    // //   return appointments();
    // }
    if (screen == '2') {
      return about();
    } else if (screen == "1") {
      return appointments();
    } else {
      return Review();
    }
  }

  Widget Review() {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          child: const Center(
            child: Text(
              "These stories represent patient's opinions & experience.\nThey do not reflect the doctor's medical capabilities.",
              style: TextStyle(fontSize: 13.0, color: Colors.white),
            ),
          ),
          height: 50,
          width: 400,
          color: const Color(0xFFD2D2D2),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xff14b2ff),
        //       minimumSize: const Size.fromHeight(40),
        //     ),
        //     onPressed: () {},
        //     child: const Text(
        //       "Share your Story",
        //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        for (PatientReviews r in review.data!.patientReviews!) reviewCard(r),
      ],
    );
  }

  Widget reviewCard(PatientReviews r) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(
                        r.customer!.imageFile!.isNotEmpty
                            ? 'https://api.doctrro.com/assets/uploads/customer/profile_pictures/${r.customer!.imageFile!}'
                            : dumyProfilePic,
                        //   // data!.data.profile.imageFile,
                      ),
                      // child: SizedBox(
                      //     width: 50,
                      //     height: 50,
                      //     child: ClipOval(
                      //         child: image(r.customer!.imageFile,
                      //             'https://api.doctrro.com/assets/uploads/customer/profile_pictures/${r.customer!.imageFile}'))),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      r.customer!.name!,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${r.customer!.age} ${(r.customer!.gender == 'Male') ? 'M' : (r.customer!.gender == 'Female') ? 'F' : 'O'}',
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                (r.recommend == 1)
                    ? Row(
                        children: const <Widget>[
                          SizedBox(
                            width: 48.0,
                          ),
                          Icon(
                            Icons.thumb_up_sharp,
                            size: 16.0,
                            color: Color(0xFF14ffb8),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          // Text("Recomended")
                        ],
                      )
                    : Row(
                        children: const <Widget>[
                          SizedBox(
                            width: 48.0,
                          ),
                          Icon(
                            Icons.thumb_down_alt_sharp,
                            size: 16.0,
                            color: Color.fromARGB(255, 255, 20, 20),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          // Text("Not recomended")
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Date : ${r.createdAt!.substring(0, 10)}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 45, top: 1, right: 12, bottom: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 300,
                  child: Text(
                    r.experience!,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  appointments() {
    if (clinicId == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "No clinics found",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      return Column(children: [
        Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Icon(
                            Icons.home,
                            color: Colors.grey,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'In-clinic Appointment',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rs. ${selectedClinic!.fees} Fees',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF14B2ff),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Divider(
                    height: 20,
                    thickness: 0.8,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 210,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AllReviews(
                                          id: selectedClinic!.id!,
                                          clinic: selectedClinic!,
                                        )));
                          },
                          child: Text(
                            '${selectedClinic!.name}',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context),
                        ),
                        child: Text(
                          '${clinics.length - 1} more Clinics',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF14B2ff),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '${selectedClinic!.address}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      // SizedBox(
                      //   width: 2.0,
                      // ),
                      // Icon(
                      //   Icons.circle,
                      //   size: 6,
                      // ),
                      // SizedBox(
                      //   width: 2.0,
                      // ),
                      // Text(
                      //   '5.0 km',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //     fontSize: 14.0,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          // height: 70.0,
                          width: 160.0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = today;
                                selectedSlots = Today_slots;
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedDate == today
                                        ? const Color(0xff14b2ff)
                                        : Colors.black.withOpacity(0.4),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Today ${today_reqDate.toString()}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        today == null
                                            ? "Today"
                                            : (selectedClinic!.id == 0)
                                                ? today!.day.toString()
                                                : '${Today_slots.length.toString()} slots',
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: (Today_slots.isEmpty)
                                                ? const Color(0xFFEE4B2B)
                                                : const Color(0xFF14ffb8),
                                            fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // height: 70,
                          width: 160,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = tomorrow;
                                selectedSlots = Tomorrow_slots;
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedDate == tomorrow
                                        ? const Color(0xff14b2ff)
                                        : Colors.black.withOpacity(0.4),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        ' Tomorrow ${tomorrow_reqDate.toString()}',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        tomorrow == null
                                            ? "Tomorrow"
                                            : (selectedClinic!.id == 0)
                                                ? tomorrow!.day.toString()
                                                : '${Tomorrow_slots.length.toString()} Slots',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: (Tomorrow_slots.isEmpty)
                                                ? const Color(0xFFEE4B2B)
                                                : const Color(0xFF14ffb8),
                                            fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // height: 70,
                          width: 160,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = dayAfterTomorrow;
                                selectedSlots = NExtDay_slots;
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedDate == dayAfterTomorrow
                                        ? const Color(0xff14b2ff)
                                        : Colors.black.withOpacity(0.4),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        dayAfterTomorrow == null
                                            ? "Day after Tomorrow"
                                            : dayAfterTomorrow!.date.toString(),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        dayAfterTomorrow == null
                                            ? ""
                                            : (selectedClinic!.id == 0)
                                                ? dayAfterTomorrow!.day
                                                    .toString()
                                                : ('${NExtDay_slots.length.toString()} Slots'),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: (NExtDay_slots.isEmpty)
                                                ? const Color(0xFFEE4B2B)
                                                : const Color(0xFF14ffb8),
                                            fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                  ),
                ]))),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Card(
            elevation: 1.0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${(selectedDate?.date == null) ? 'Select Clinic and Slot' : selectedDate?.date}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      (selectedDate == today)
                          ? '${Today_slots.length} Time Schedule Available'
                          : (selectedSlot == tomorrow)
                              ? '${Tomorrow_slots.length} Time Schedule Available'
                              : (selectedSlot == dayAfterTomorrow)
                                  ? '${NExtDay_slots.length} Time Schedule Available'
                                  : 'Select clinic and slot',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Color(0xFF14ffb8),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 0.8,
                    color: Colors.black,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: selectedDate == null
                          ? const Center(
                              child: Text(
                                'Please Select A clinic and Date',
                                style: TextStyle(
                                    color: Color(0xFF14ffb8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : (selectedSlots.isEmpty)
                              ? const Text(
                                  'No Slots available',
                                  style: TextStyle(
                                      color: Color(0xFF14ffb8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              : SizedBox(
                                  width: 340,
                                  child: Column(
                                    children: [
                                      // Row(
                                      //   children: const [
                                      //     Icon(CupertinoIcons
                                      //         .sunrise),
                                      //     Text('Morining')
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GridView.count(
                                        crossAxisCount: 3,
                                        childAspectRatio: (1 / .4),
                                        shrinkWrap: true,
                                        children: slots_list_func(
                                            (selectedDate == today)
                                                ? Today_slots
                                                : (selectedDate == tomorrow)
                                                    ? Tomorrow_slots
                                                    : NExtDay_slots,
                                            1),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ))
                      // Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: [
                      //
                      //     ],
                      // ),
                      ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => DoctorAppoint(
                                    id: doc_about.data!.doctor!.id!,
                                    imagefile:
                                        doc_about.data!.doctor!.imageFile,
                                    name: doc_about.data!.doctor!.name!,
                                    speciality: doc_speciality,
                                    clinic: selectedClinic,
                                  )));
                    },
                    child: const Text(
                      'View all Slots',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF14B2ff),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]);
    }
    //                   SizedBox(

    //                     height: 80,
    //                     width: 124,
    //                     child: Card(
    //                       elevation: 4.0,
    //                       margin:
    //                           const EdgeInsets.only(top: 12.0, bottom: 12.0),
    //                       shape: RoundedRectangleBorder(
    //                         side: BorderSide(
    //                             color: Colors.black.withOpacity(0.4), width: 2),
    //                         borderRadius:
    //                             const BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.only(top: 12.0, bottom: 12.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 'Tomorrow, 25 May',
    //                                 textAlign: TextAlign.center,
    //                                 style: TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                     fontSize: 11),
    //                               ),
    //                             ),
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 '9 slots',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                     color: Color(0xFF14ffb8), fontSize: 12),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 80,
    //                     width: 65,
    //                     child: Card(
    //                       elevation: 4.0,
    //                       margin:
    //                           const EdgeInsets.only(top: 12.0, bottom: 12.0),
    //                       shape: RoundedRectangleBorder(
    //                         side: BorderSide(
    //                             color: Colors.black.withOpacity(0.4), width: 2),
    //                         borderRadius:
    //                             const BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(12.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 '19 May',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                     fontSize: 11),
    //                               ),
    //                             ),
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 '5 slots',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                     color: Color(0xFF14ffb8), fontSize: 12),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '11:30AM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '12:00PM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '12:30PM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '05:30PM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 8.0,
    //               ),
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: const Text(
    //                   'View all Slots',
    //                   style: TextStyle(
    //                       fontSize: 12.0,
    //                       color: Color(0xFF14B2ff),
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 235.0,
    //       child: Card(
    //         elevation: 8.0,
    //         margin: const EdgeInsets.all(10),
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
    //           borderRadius: const BorderRadius.all(Radius.circular(12)),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(12.0),
    //           child: Column(
    //             children: <Widget>[
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   Row(
    //                     children: const <Widget>[
    //                       Icon(
    //                         Icons.video_call,
    //                         color: Colors.grey,
    //                         size: 24.0,
    //                       ),
    //                       SizedBox(
    //                         width: 4.0,
    //                       ),
    //                       Text(
    //                         'Video Consult',
    //                         textAlign: TextAlign.start,
    //                         style: TextStyle(
    //                           color: Colors.grey,
    //                           fontSize: 18.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   const Text(
    //                     'Rs. 500 Fees',
    //                     textAlign: TextAlign.end,
    //                     style: TextStyle(
    //                         fontSize: 18.0,
    //                         color: Color(0xFF14B2ff),
    //                         fontWeight: FontWeight.bold),
    //                   )
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 4.0,
    //               ),
    //               const Divider(
    //                 height: 20,
    //                 thickness: 0.8,
    //                 color: Colors.black,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   SizedBox(
    //                     height: 80.0,
    //                     width: 105.0,
    //                     child: Card(
    //                       elevation: 4.0,
    //                       margin:
    //                           const EdgeInsets.only(top: 12.0, bottom: 12.0),
    //                       shape: const RoundedRectangleBorder(
    //                         side:
    //                             BorderSide(color: Color(0xff14b2ff), width: 2),
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(12.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 'Today, 24 May',
    //                                 textAlign: TextAlign.center,
    //                                 style: TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                     fontSize: 11),
    //                               ),
    //                             ),
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 '7 Slots',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                     color: Color(0xFF14ffb8), fontSize: 12),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 80,
    //                     width: 124,
    //                     child: Card(
    //                       elevation: 4.0,
    //                       margin:
    //                           const EdgeInsets.only(top: 12.0, bottom: 12.0),
    //                       shape: RoundedRectangleBorder(
    //                         side: BorderSide(
    //                             color: Colors.black.withOpacity(0.4), width: 2),
    //                         borderRadius:
    //                             const BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(12.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 'Tomorrow, 25 May',
    //                                 textAlign: TextAlign.center,
    //                                 style: TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                     fontSize: 11),
    //                               ),
    //                             ),
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 '9 slots',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                     color: Color(0xFF14ffb8), fontSize: 12),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 80,
    //                     width: 65,
    //                     child: Card(
    //                       elevation: 4.0,
    //                       margin:
    //                           const EdgeInsets.only(top: 12.0, bottom: 12.0),
    //                       shape: RoundedRectangleBorder(
    //                         side: BorderSide(
    //                             color: Colors.black.withOpacity(0.4), width: 2),
    //                         borderRadius:
    //                             const BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(12.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 '19 May',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                     fontSize: 11),
    //                               ),
    //                             ),
    //                             Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 '5 slots',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                     color: Color(0xFF14ffb8), fontSize: 12),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '11:30AM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '12:00PM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '12:30PM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 40,
    //                     width: 85,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Column(
    //                           children: const <Widget>[
    //                             Text(
    //                               '05:30PM',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 12),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 8.0,
    //               ),
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: const Text(
    //                   'View all Slots',
    //                   style: TextStyle(
    //                       fontSize: 12.0,
    //                       color: Color(0xFF14B2ff),
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 150.0,
    //       child: Card(
    //         elevation: 8.0,
    //         margin: const EdgeInsets.all(10),
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
    //           borderRadius: const BorderRadius.all(Radius.circular(12)),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(12.0),
    //           child: Column(
    //             children: <Widget>[
    //               Row(
    //                 children: const <Widget>[
    //                   Icon(
    //                     Icons.contact_mail_rounded,
    //                     color: Colors.grey,
    //                     size: 24.0,
    //                   ),
    //                   SizedBox(
    //                     width: 4.0,
    //                   ),
    //                   Text(
    //                     'Contact Clinic',
    //                     textAlign: TextAlign.start,
    //                     style: TextStyle(
    //                       color: Colors.grey,
    //                       fontSize: 18.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 4.0,
    //               ),
    //               const Divider(
    //                 height: 20,
    //                 thickness: 0.8,
    //                 color: Colors.black,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 children: <Widget>[
    //                   SizedBox(
    //                     height: 45,
    //                     width: 90,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(4)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: const <Widget>[
    //                             Icon(
    //                               Icons.call,
    //                               color: Colors.white,
    //                             ),
    //                             SizedBox(
    //                               width: 2.0,
    //                             ),
    //                             Text(
    //                               'Call',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 16),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 45,
    //                     width: 90,
    //                     child: Card(
    //                       color: const Color(0xFF14B2FF),
    //                       elevation: 4.0,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(6)),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 8.0, bottom: 4.0, left: 1.0, right: 1.0),
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: const <Widget>[
    //                             Icon(
    //                               Icons.email,
    //                               color: Colors.white,
    //                             ),
    //                             SizedBox(
    //                               width: 2.0,
    //                             ),
    //                             Text(
    //                               'Email',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: 16),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 227.0,
    //       child: Card(
    //         elevation: 8.0,
    //         margin: const EdgeInsets.all(10),
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
    //           borderRadius: const BorderRadius.all(Radius.circular(12)),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(12.0),
    //           child: Column(
    //             children: <Widget>[
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   Row(
    //                     children: const <Widget>[
    //                       Icon(
    //                         Icons.location_on,
    //                         color: Colors.grey,
    //                         size: 24.0,
    //                       ),
    //                       SizedBox(
    //                         width: 4.0,
    //                       ),
    //                       Text(
    //                         'Clinic Location',
    //                         textAlign: TextAlign.start,
    //                         style: TextStyle(
    //                           color: Colors.grey,
    //                           fontSize: 18.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 4.0,
    //               ),
    //               const Divider(
    //                 height: 20,
    //                 thickness: 0.8,
    //                 color: Colors.black,
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   const Text(
    //                     'Elen Health Care',
    //                     textAlign: TextAlign.start,
    //                     style: TextStyle(
    //                       fontSize: 16.0,
    //                       color: Colors.black,
    //                     ),
    //                   ),
    //                   const Text(
    //                     '962(A), Eastern Metropolitan, Survey Park, Jadavpur',
    //                     textAlign: TextAlign.start,
    //                     style: TextStyle(
    //                       fontSize: 16.0,
    //                       color: Colors.grey,
    //                     ),
    //                   ),
    //                   // Map to be added here
    //                   Padding(
    //                     padding: const EdgeInsets.all(12.0),
    //                     child: ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                         backgroundColor: const Color(0xff14b2ff),
    //                         minimumSize: const Size.fromHeight(40),
    //                       ),
    //                       onPressed: () {},
    //                       child: const Text(
    //                         "Tap on the Map for directions",
    //                         style: TextStyle(
    //                             fontSize: 16, fontWeight: FontWeight.bold),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  List<Widget> Doc_specialities() {
    List<Widget> text = [];
    for (String? s in doc_speciality_list) {
      text.add(
        Row(
          children: <Widget>[
            const SizedBox(
              width: 12.0,
            ),
            const Icon(
              Icons.circle,
              color: Colors.black,
              size: 6.0,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              (s == null) ? 'Nothing to Show' : s,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    }
    return text;
  }

  Widget about() {
    var aboutload = true;
    return (aboutload)
        ? Column(
            children: [
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.medical_information,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'About',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.8,
                          color: Colors.black,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (doc_about.data?.doctor?.about != null)
                                ? doc_about.data!.doctor!.about!
                                : 'nothing to show',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.contact_mail,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Specialization',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.8,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 0.8,
                          child: SingleChildScrollView(
                            child: Column(
                              children: Doc_specialities(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.school,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Education',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.8,
                          color: Colors.black,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 8.0,
                            ),
                            doc_about.data?.qualification!.length == 0
                                ? Text(
                                    'No Qualification Found',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      for (Qualification q
                                          in doc_about.data!.qualification!)
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.black,
                                              size: 6.0,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            SizedBox(
                                              width: 240,
                                              child: Text(
                                                // '${q.degree!.name} - ${q.college!.medicalCollegeName} - ${q.passingYear}',
                                                '${q.degree!.name}',
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(
                                        height: 4.0,
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
              Card(
                elevation: 8.0,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.4), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Icon(
                            Icons.request_page_rounded,
                            color: Colors.grey,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'Registration',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      const Divider(
                        height: 20,
                        thickness: 0.8,
                        color: Colors.black,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 6.0,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            '${doc_about.data?.doctor!.registrationNo} - ${doc_about.data?.doctor!.registrationCouncil} - ${doc_about.data?.doctor!.registrationYear}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   child: Card(
              //     elevation: 8.0,
              //     margin: const EdgeInsets.all(10),
              //     shape: RoundedRectangleBorder(
              //       side: BorderSide(
              //           color: Colors.black.withOpacity(0.4), width: 1),
              //       borderRadius: const BorderRadius.all(Radius.circular(12)),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Column(
              //         children: <Widget>[
              //           Row(
              //             children: const <Widget>[
              //               Icon(
              //                 Icons.work,
              //                 color: Colors.grey,
              //                 size: 24.0,
              //               ),
              //               SizedBox(
              //                 width: 4.0,
              //               ),
              //               Text(
              //                 'Experience',
              //                 textAlign: TextAlign.start,
              //                 style: TextStyle(
              //                   color: Colors.grey,
              //                   fontSize: 18.0,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             height: 4.0,
              //           ),
              //           const Divider(
              //             height: 20,
              //             thickness: 0.8,
              //             color: Colors.black,
              //           ),
              //           Row(
              //             children: const <Widget>[
              //               SizedBox(
              //                 width: 12.0,
              //               ),
              //               Icon(
              //                 Icons.circle,
              //                 color: Colors.black,
              //                 size: 6.0,
              //               ),
              //               SizedBox(
              //                 width: 8.0,
              //               ),
              //               // TODO:this is static data
              //               Text(
              //                 '2008 to Present - Elan Health Care',
              //                 textAlign: TextAlign.start,
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 12.5,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        : const Text("null");
  }

  List<Widget> clinicspecialities(speciality) {
    List<Widget> text = [];
    for (var s in speciality) {
      text.add(
        Row(
          children: <Widget>[
            const SizedBox(
              width: 12.0,
            ),
            const Icon(
              Icons.circle,
              color: Colors.black,
              size: 6.0,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              s.name!,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    }
    return text;
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

  List<SizedBox> slots_list_func(slots, int when) {
    List<SizedBox> morning = [];
    List<SizedBox> afternoon = [];
    List<SizedBox> evening = [];
    List<SizedBox> night = [];
    if (slots != null) {
      for (slotClass sl in slots) {
        String time = sl.availableSlot!.split(' ')[2];
        if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 12:00:01"))) {
          morning.add(
            SizedBox(
              height: 50,
              width: 65,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 18:00:01"))) {
          afternoon.add(
            SizedBox(
              height: 50,
              width: 65,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 24:00:01"))) {
          evening.add(
            SizedBox(
              height: 50,
              width: 65,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 06:00:01"))) {
          night.add(
            SizedBox(
              height: 50,
              width: 65,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
    if (when == 1) {
      return morning;
    } else if (when == 2) {
      return afternoon;
    } else if (when == 3) {
      return evening;
    } else {
      return night;
    }
  }
}
