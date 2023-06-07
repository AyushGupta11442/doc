import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/appointmentBooking/models/clinicClass.dart';
import 'package:doctor/doctorReview/submit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

import '../MyDoctor/models/DoctorClass.dart';
import '../client/DioClientToken/DioClient_Token.dart';

//ignore: must_be_immutable
class DoctorReview extends StatefulWidget {
  final int doctor_id;
  final String doctorname;
  final String speciality;
  final String? doctor_image;
  final Doctor doctor;
  const DoctorReview({
    Key? key,
    required this.doctor_id,
    required this.doctorname,
    required this.speciality,
    this.doctor_image,
    required this.doctor,
  }) : super(key: key);

  @override
  State<DoctorReview> createState() => _DoctorReviewState();
}

class _DoctorReviewState extends State<DoctorReview> {
  bool checkboxvalue = false;
  // String experience = "NC";
  // List<String> experienceslist = [
  //   'Appolo Gleneagles Hospital',
  //   'Suraksha Poly Clinic',
  //   'Nidaan Poly Clinic',
  //   'Appolo Gleneagles Hospital',
  //   'Video Consultation'
  // ];
  // String experienceindex = "4";

  var clinic_id;

  String recommend = "NC";
  List<String> recommendationlist = ['Yes', 'No'];
  String recommendations = "0";

  String problem = "NC";

  String waitingtime = "NC";
  List<String> waitinglist = [
    'Less than 15 min',
    '15 min to 30min',
    '30 min to 1 hour',
    'More than 1 hour'
  ];
  String waitingindex = "0";

  String happywith = "NC";
  List<String> happywithlist = [
    'Treatment satisfaction',
    'Doctor friendliness',
    'Value for money',
    'Explanation of the health issue',
    'Wait time'
  ];
  String happywithindex = "0";

  String userexperience = "NC";

  List<ClinicClass> clinics = [];

  List<Widget> Button = [];

  // void buttonbuilder() async {
  //   for (ClinicClass c in clinics) {
  //     Button.add(
  //       Expanded(
  //         child: RadioListTile(
  //           activeColor: const Color(0xFF14DFFF),
  //           contentPadding: const EdgeInsets.all(0),
  //           title: Text(c.name.toString()),
  //           value: c.id.toString(),
  //           groupValue: clinics,
  //           onChanged: (value) {
  //             setState(() {
  //               clinic_id = int.parse(value.toString());
  //             });
  //           },
  //         ),
  //       ),
  //     );
  //   }
  // }

  void getclinics() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .get('/doctor_clinic/' + widget.doctor_id.toString());

      var _clinics = response.data['data']['clinics'];
      if (response.statusCode == 200) {
        for (var cl in _clinics) {
          ClinicClass c = ClinicClass(
              id: cl['id'],
              name: cl['name'],
              address: cl['address'],
              clinicNumber: cl['clinic_number'],
              fees: cl['fees'],
              imageFile: cl['image_file']);

          clinics.add(c);
        }
        print(clinics);
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

  void addReview() async {
    try {
      final response =
          await DioClinetToken.instance.dio!.post('/doctor_review', data: {
        "clinic_detail_id": clinic_id,
        "doctor_id": widget.doctor_id,
        "problem_description": problem,
        "duration": waitingtime,
        "experience": userexperience,
        "reaction": happywith,
      });
      // print(response.data);

      if (response.statusCode == 200) {
        await EasyLoading.showSuccess('Review Submitted');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const PageSubmit();
            },
          ),
        );
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
      } else if (e.response!.statusCode == 500) {
        VxToast.show(
          context,
          msg: 'Something Went Wrong!',
          bgColor: Vx.black,
          textColor: Vx.white,
          showTime: 5000,
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getclinics();
    // buttonbuilder();
    super.initState();
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
        title: const Text('Share Your Experience'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 151.0,
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
                              borderRadius:
                                  BorderRadius.circular(10.0), //or 15.0
                              child: Container(
                                  height: 90.0,
                                  width: 90.0,
                                  color: const Color(0x00b2e2fc),
                                  child: image(widget.doctor_image,
                                      'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.doctor_image}')
                                  // Image.network(
                                  //   'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.doctor_image}',
                                  //   fit: BoxFit.fill,
                                  // ),
                                  ),
                            ),
                            const SizedBox(
                              width: 18.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.doctorname,
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
                                            width: 140,
                                            child: Text(
                                              '${widget.speciality}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.thumb_up_sharp,
                                      size: 16.0,
                                      color: Color(0xFF14ffb8),
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      '100 %',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'Experience : ${(widget.doctor.experience == null) ? 'no data' : widget.doctor.experience} Yrs',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
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
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'How was your Appointment Experience ?',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Card(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            Icons.home,
                            color: Colors.black45,
                            size: 26.0,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Which clinic did you visit?',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                        height: 0.0,
                        thickness: 1.0,
                        color: Colors.black45.withOpacity(0.4),
                        indent: 8.0,
                        endIndent: 8.0,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (ClinicClass cl in clinics)
                                Builder(builder: (context) {
                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cl.name.toString()),
                                        // Text(" Fees : " + cl.fees.toString())
                                      ],
                                    ),
                                    leading: Radio(
                                      activeColor: const Color(0xFF14DFFF),
                                      value: cl.id!,
                                      groupValue: clinic_id,
                                      onChanged: (value) {
                                        setState(() {
                                          clinic_id = value;
                                        });
                                      },
                                    ),
                                  );
                                }),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 200,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 8.0,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Would you like to recommend \nthe doctor ?',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: Colors.black45.withOpacity(0.4),
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(recommendationlist[0]),
                            value: "0",
                            groupValue: recommendations,
                            onChanged: (value) {
                              setState(() {
                                recommendations = value.toString();
                                recommend = recommendationlist[0].toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(recommendationlist[1]),
                            value: "1",
                            groupValue: recommendations,
                            onChanged: (value) {
                              setState(() {
                                recommendations = value.toString();
                                recommend = recommendationlist[1].toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 170.0,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 8.0,
                            ),
                            Icon(
                              Icons.add_circle,
                              color: Colors.black45,
                              size: 26.0,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'For which health problem \ndid you visit ? ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: Colors.black45.withOpacity(0.4),
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Add Problem'),
                            onChanged: (value) => setState(() {
                              problem = value;
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 270.0,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 8.0,
                            ),
                            Icon(
                              Icons.av_timer,
                              color: Colors.black45,
                              size: 26.0,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'How long did you wait ?',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: Colors.black45.withOpacity(0.4),
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(waitinglist[0]),
                            value: "0",
                            groupValue: waitingindex,
                            onChanged: (value) {
                              setState(() {
                                waitingtime = waitinglist[0].toString();
                                waitingindex = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(waitinglist[1]),
                            value: "1",
                            groupValue: waitingindex,
                            onChanged: (value) {
                              setState(() {
                                waitingtime = waitinglist[1].toString();
                                waitingindex = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(waitinglist[2]),
                            value: "2",
                            groupValue: waitingindex,
                            onChanged: (value) {
                              setState(() {
                                waitingtime = waitinglist[2].toString();
                                waitingindex = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(waitinglist[3]),
                            value: "3",
                            groupValue: waitingindex,
                            onChanged: (value) {
                              setState(() {
                                waitingtime = waitinglist[3].toString();
                                waitingindex = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 320.0,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 8.0,
                            ),
                            Icon(
                              Icons.home,
                              color: Colors.black45,
                              size: 26.0,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'What were you most happy with ?',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: Colors.black45.withOpacity(0.4),
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(happywithlist[0]),
                            value: "0",
                            groupValue: happywithindex,
                            onChanged: (value) {
                              setState(() {
                                happywith = happywithlist[0].toString();
                                happywithindex = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(happywithlist[1]),
                            value: "1",
                            groupValue: happywithindex,
                            onChanged: (value) {
                              setState(() {
                                happywith = happywithlist[1].toString();
                                happywithindex = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(happywithlist[2]),
                            value: "2",
                            groupValue: happywithindex,
                            onChanged: (value) {
                              setState(() {
                                happywith = happywithlist[2].toString();
                                happywithindex = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(happywithlist[3]),
                            value: "3",
                            groupValue: happywithindex,
                            onChanged: (value) {
                              setState(() {
                                happywith = happywithlist[3].toString();
                                happywithindex = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: const Color(0xFF14DFFF),
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(happywithlist[4]),
                            value: "4",
                            groupValue: happywithindex,
                            onChanged: (value) {
                              setState(() {
                                happywith = happywithlist[4].toString();
                                happywithindex = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 160.0,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 8.0,
                            ),
                            Icon(
                              Icons.edit_note,
                              color: Colors.black45,
                              size: 26.0,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tell about your experience',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: Colors.black45.withOpacity(0.4),
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Add your experience'),
                            onChanged: (value) => setState(() {
                              userexperience = value;
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'NOTE : All stories fo under strict moderation process before publising to check abusive languague, threats, superlative comment on medical abilities or so.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              // Row(
              //   children: <Widget>[
              //     Checkbox(
              //         checkColor: const Color(0xFF14DFFF),
              //         value: checkboxvalue,
              //         onChanged: (val) {
              //           setState(() {
              //             checkboxvalue = !checkboxvalue;
              //           });
              //         }),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: const [
              //         Text(
              //           'Keep this story publicly anonymous',
              //           textAlign: TextAlign.start,
              //           style: TextStyle(
              //               fontSize: 16.0,
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold),
              //         ),
              //         Text(
              //           'Note : Your identity will be shared with doctor',
              //           textAlign: TextAlign.start,
              //           style: TextStyle(
              //             fontSize: 14.0,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff14b2ff),
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: () {
                    addReview();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    const Text(
                      'By submitting my story I agree to ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        const Urlstring = 'https://doctrro.com/privacy-policy/';
                        if (await canLaunchUrl(Uri.parse(Urlstring))) {
                          await launchUrlString(Urlstring);
                        }
                      },
                      child: const Text(
                        'Terms & Condition',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
