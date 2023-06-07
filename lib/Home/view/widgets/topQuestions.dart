import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/widget/CircleProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../client/DioClientToken/DioClient_Token.dart';
import '../../models/TopQuestion.dart';
import 'package:doctor/healthQ&A/Questions.dart';

class TopQuestionList extends StatefulWidget {
  const TopQuestionList({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  State<TopQuestionList> createState() => _TopQuestionListState();
}

class _TopQuestionListState extends State<TopQuestionList> {
  late TopQuestion top_questions;
  bool isLoading = false;
  Future<void> getTopQuestions() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await DioClinetToken.instance.dio!.get('/top_question_list');

      var data = jsonDecode(response.toString());

      if (response.statusCode == 200) {
        TopQuestion topq = TopQuestion.fromJson(data);
        setState(() {
          top_questions = topq;
          isLoading = false;
        });
        print(top_questions.data!.message);
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
    // TODO: implement initState
    getTopQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: 210,
      margin: const EdgeInsets.only(top: 5),
      child: isLoading
          ? circularProgressIndicator()
          : top_questions.data!.questions!.isEmpty
              ? const Text("No Questions Found")
              : ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                  for (var tq in top_questions.data!.questions!)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 340.0,
                        // height: 200.0,
                        child: Card(
                          elevation: 1.0,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    const Icon(Icons.favorite_border,
                                        color: Color(0xff14DFFF), size: 35.0),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width: 250,
                                        child: Text(
                                          '${tq.title}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Poppins SemiBold',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                const Divider(
                                  height: 0.0,
                                  thickness: 1.0,
                                  color: Colors.black,
                                  indent: 8.0,
                                  endIndent: 8.0,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 30,
                                        child: Text(
                                          '${tq.description}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins SemiBold',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                    //  const SizedBox(
                                    //   height: 65.0,
                                    // ),
                                    SizedBox(
                                      width: widget.size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, bottom: 2.0),
                                        child: ElevatedButton(
                                          child: Text(
                                            '${tq.answersCount} answer from doctors',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins SemiBold',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                const Color(0xff14B2FF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Questions(
                                                          questionHeading:
                                                              tq.title!,
                                                          createdDate:
                                                              tq.createdAt!,
                                                          id: tq.id!,
                                                          questionBody:
                                                              tq.description!,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 5),
                ]),
    );
  }
}
