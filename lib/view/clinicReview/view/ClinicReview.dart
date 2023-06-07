// The screen of the error page.

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/view/clinicReview/view/Submitted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class ClinicReview extends StatefulWidget {
  // / Creates an [ErrorScreen].
  const ClinicReview(
      {Key? key, this.star, this.id, this.review, this.reviewId, this.clinic})
      : super(key: key);
  final int? star;
  final int? id;
  final String? review;
  final int? reviewId;
  final Clinices? clinic;

  @override
  State<ClinicReview> createState() => _ClinicReviewState();
}

class _ClinicReviewState extends State<ClinicReview> {
  String message = '';
  // int? clinicDetailId = widget.id;
  String rating = '';
  int stars = 0;

  void getValues() {
    setState(() {
      message = (widget.review ?? "");
      rating = widget.star != null ? widget.star.toString() : "";
      stars = widget.star ?? 0;
    });
  }

  void editReview(int? id) async {
    try {
      final response = await DioClinetToken.instance.dio!.put(
          '/clinic_review_update/' + id.toString(),
          data: {"rating": rating, "message": message});

      if (response.statusCode == 200) {
        // Navigator.push(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return SubmitScreen(
                id: widget.id,
                clinic: widget.clinic,
              );
            },
          ),
        );
      }
      // print(response.data);
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
      final response = await DioClinetToken.instance.dio!
          .post('/add_clinic_review', data: {
        "clinic_detail_id": widget.id,
        "rating": rating,
        "message": message
      });
      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return SubmitScreen(
                id: widget.id,
                clinic: widget.clinic,
              );
            },
          ),
        );
      }
      // print(response.data);
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
    getValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/Cover Photo.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 100),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/Building.png',
                                  fit: BoxFit.fill,
                                  height: 135.0,
                                  width: 125.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.clinic!.name.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      //  Text(
                      //   '${widget.clinic!.address}',
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w200,
                      //       color: Colors.grey),
                      // ),
                      Text(
                        widget.clinic!.address.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      const Divider(color: Colors.grey)
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How Was Your Experience?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Card(
                        borderOnForeground: true,
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.star,
                                        color: Colors.grey, size: 26),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Rate This Clinic',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    for (int i = 1; i <= 5; i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            rating = i.toString();
                                            stars = i;
                                          });
                                          print(rating);
                                        },
                                        child: i <= stars
                                            ? const Icon(Icons.star,
                                                color: Colors.green, size: 32)
                                            : const Icon(
                                                Icons.star_border_outlined,
                                                color: Colors.green,
                                                size: 32),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        elevation: 4.0,
                        borderOnForeground: true,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.message,
                                          color: Colors.grey, size: 26),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Tell us about your experience',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                        onPressed: () {},
                                        child: TextField(
                                          onChanged: (text) {
                                            setState(() {
                                              message = text;
                                            });
                                          },
                                          // obscureText: true,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            helperText: 'Add Your Experience',
                                          ),
                                        )))
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Note: All stories go under strict modeartion process before publishing to check abusing language, threats, superiative comments on medical abilities and so on.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Checkbox(
                      //       value: false,
                      //       activeColor: Colors.blue,
                      //       onChanged: (bool? value) {},
                      //     ),
                      //     const SizedBox(
                      //       width: 8.0,
                      //     ),
                      //     Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: const [
                      //         Text(
                      //           'keep this story publicly anonymous',
                      //           style: TextStyle(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.black),
                      //         ),
                      //         Text(
                      //           'Note: Your profile will be shared with the doctor.',
                      //           style: TextStyle(
                      //               color: Colors.grey,
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w300),
                      //         ),
                      //       ],
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(
                              40), // fromHeight use double.infinity as width and 40 is the height
                        ),
                        onPressed: () {
                          if (widget.reviewId != null) {
                            editReview(widget.reviewId);
                          } else {
                            addReview();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'By submitting my story I agree to ',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                            GestureDetector(
                              onTap: () async {
                                const Urlstring =
                                    'https://doctrro.com/privacy-policy/';
                                if (await canLaunchUrl(Uri.parse(Urlstring))) {
                                  await launchUrlString(Urlstring);
                                }
                              },
                              child: Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
