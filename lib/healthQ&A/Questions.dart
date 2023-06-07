import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:doctor/sharedData/classes.dart';
import 'package:flutter/material.dart';
import 'package:doctor/healthQ&A/AskQuestion.dart';

import 'models/NewAnsmodel.dart';

class Questions extends StatefulWidget {
  Questions(
      {Key? key,
      required this.questionBody,
      required this.questionHeading,
      required this.createdDate,
      required this.id})
      : super(key: key);
  String questionHeading, questionBody, createdDate;
  int id;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  Map<int, String> reportedId = <int, String>{};
  Map<int, bool> remarkedID = <int, bool>{};

  @override
  void initState() {
    // getanswers(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Questions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 12,
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(60),
                              ),
                            ),
                            child: Image.asset(
                              'assets/icons/nephrology.png',
                              scale: 0.8,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              widget.questionHeading,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.questionBody,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Asked on ${widget.createdDate}  ',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/answers.png',
                    scale: 0.7,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    'Answers',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black54),
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: getAnswers(widget.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null || snapshot.data.length == 0) {
                    return const Center(
                      child: Text(
                        "No Answers Yet!",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return Column(mainAxisSize: MainAxisSize.max, children: <
                        Widget>[
                      for (NewAnswers a in snapshot.data)
                        SizedBox(
                          child: Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black.withOpacity(0.4),
                                  width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Wrap(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        //or 15.0
                                        child: Container(
                                          height: 60.0,
                                          width: 60.0,
                                          color: const Color(0x00b2e2fc),
                                          child: Image.network(
                                            'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${a.doctor!.imageFile}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 18.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
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
                                                    Text(
                                                      'Dr. ${a.doctor!.name}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  // Icon(
                                                  //   Icons.thumb_up_sharp,
                                                  //   size: 18.0,
                                                  //   color: Color(0xFF14ffb8),
                                                  // ),

                                                  Text(
                                                    a.createdAt!
                                                        .substring(0, 10),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            '${a.doctor!.speciality!.length > 0 ? a.doctor!.speciality![0].name : "No Speciality Mentioned"}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Text(
                                            '${a.doctor!.experience} years exp',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  //  Text(
                                  //   a.createdAt!.substring(0,10),
                                  //   style: TextStyle(
                                  //     fontSize: 13,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        a.description.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: .5,
                                        ),
                                      ),
                                      Text(
                                        "Next Steps: " + a.doNext.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: .5,
                                        ),
                                      ),
                                      Text(
                                        "Tips : " + a.tips.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: .5,
                                    ),
                                  ),
                                  if (a.customers!.length > 0)
                                    if (a.customers![0].pivot!.helpful == 1)
                                      const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 15.0),
                                          child: Text(
                                              "You have marked this answer helpful")),
                                  if (a.customers!.length > 0)
                                    if (a.customers![0].pivot!.helpful == 0)
                                      const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 15.0),
                                          child: Text(
                                              "You have reported this answer not helpful")),
                                  if (a.customers!.length == 0)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'is this answer helpful to you?',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  YesOrNo(true, a.id!).then(
                                                      (value) {
                                                    if (value['data']['errors']
                                                            .length ==
                                                        0) {
                                                      EasyLoading.showSuccess(
                                                          "Thank you for your remarks");
                                                    } else {
                                                      EasyLoading.showError(
                                                          value['data']
                                                              ['errors'][0]);
                                                    }
                                                    setState(() {
                                                      remarkedID[a.id!] = true;
                                                    });
                                                  }).catchError((Object e,
                                                      StackTrace stackTrace) {
                                                    print(e.toString());
                                                    return;
                                                  });
                                                },
                                                child: const Text(
                                                  'YES',
                                                  style: TextStyle(
                                                      color: Color(0xFF14ffb8),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  YesOrNo(false, a.id!).then(
                                                      (value) {
                                                    if (value['data']['errors']
                                                            .length ==
                                                        0) {
                                                      EasyLoading.showSuccess(
                                                          "Thank you for your remarks");
                                                    } else {
                                                      EasyLoading.showError(
                                                          value['data']
                                                              ['errors'][0]);
                                                    }
                                                    setState(() {
                                                      remarkedID[a.id!] = false;
                                                    });
                                                  }).catchError((Object e,
                                                      StackTrace stackTrace) {
                                                    print(e.toString());
                                                  });
                                                },
                                                child: const Text(
                                                  'NO',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  // if (!a.isHelpful!)
                                  //   const Divider(
                                  //     height: 0,
                                  //     thickness: 0.6,
                                  //     color: Colors.black,
                                  //   ),
                                  // if (!a.isHelpful!)
                                  //   const SizedBox(
                                  //     height: 8,
                                  //   ),
                                  // if (!a.isHelpful!)
                                  GestureDetector(
                                    onTap: () {
                                      if (reportedId.containsKey(a.id)
                                          // ||// a.report == ''
                                          ) {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (BuildContext context) {
                                            return Bottom(
                                              notifyParent:
                                                  (int id, String report) {
                                                setState(() {
                                                  reportedId[id] = report;
                                                });
                                              },
                                              id: a.id!,
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       left: 0.0, right: 0.0),
                                        //   child: SizedBox(
                                        //     width:
                                        //         250, //MediaQuery.of(context).size.width,
                                        //     child: (!reportedId
                                        //                 .containsKey(a.id) &&
                                        //             a.report != '')
                                        //         ? Padding(
                                        //             padding:
                                        //                 const EdgeInsets.only(
                                        //                     top: 6.0),
                                        //             child: Text(
                                        //               "Answer Reported : ${(a.report == '') ? reportedId[a.id] : a.report}",
                                        //               style: const TextStyle(
                                        //                 //fontSize: 13.0,
                                        //                 color: Colors.black54,
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //               ),
                                        //               //maxLines: 1,
                                        //               overflow: TextOverflow
                                        //                   .ellipsis,
                                        //             ))
                                        //         : Column(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment
                                        //                     .start,
                                        //             children: const <Widget>[
                                        //               Text(
                                        //                 'Report Raise',
                                        //                 textAlign:
                                        //                     TextAlign.start,
                                        //                 style: TextStyle(
                                        //                   fontSize: 16.0,
                                        //                   overflow:
                                        //                       TextOverflow
                                        //                           .ellipsis,
                                        //                   color:
                                        //                       Colors.black54,
                                        //                   fontWeight:
                                        //                       FontWeight.bold,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //   ),
                                        // ),
                                        // Icon(
                                        //   Icons.flag,
                                        //   size: 24.0,
                                        //   color: (!reportedId
                                        //               .containsKey(a.id) &&
                                        //           a.report != '')
                                        //       ? Colors.red
                                        //       : Colors.blue,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ]);
                  }
                } else {
                  return const Text("loading..");
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 50,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AskQuestion()));
          },
          color: const Color(0xff14B2FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: const Text(
            'Ask a question',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class Bottom extends StatefulWidget {
  final Function(int, String) notifyParent;
  int id;
  Bottom({Key? key, required this.notifyParent, required this.id})
      : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  String report = "";

  @override
  void initState() {
    super.initState();
    report = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              const Text(
                'We are sorry. Tell us about your issue.',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins Bold'),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 10,
                thickness: 0.6,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              report = 'Abusive Content';
                            });
                          },
                          constraints: BoxConstraints.tight(const Size(20, 20)),
                          fillColor: const Color(0xFF14Dfff),
                          shape: const CircleBorder(
                            side: BorderSide(
                                color: Color(0xFF14Dfff),
                                style: BorderStyle.solid),
                          ),
                          child: Icon(
                            Icons.circle_rounded,
                            size: 16.0,
                            color: (report == 'Abusive Content')
                                ? const Color(0xFF14Dfff)
                                : Colors.white,
                          ),
                        ),
                        const Text(
                          'Abusive Content',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              report = 'Unprofessional Content';
                            });
                          },
                          constraints: BoxConstraints.tight(const Size(20, 20)),
                          fillColor: const Color(0xFF14Dfff),
                          shape: const CircleBorder(
                            side: BorderSide(
                                color: Color(0xFF14Dfff),
                                style: BorderStyle.solid),
                          ),
                          child: Icon(
                            Icons.circle_sharp,
                            size: 16.0,
                            color: (report == 'Unprofessional Content')
                                ? const Color(0xFF14Dfff)
                                : Colors.white,
                          ),
                        ),
                        const Text(
                          'Unprofessional Content',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              report = 'Contains false Content';
                            });
                          },
                          constraints: BoxConstraints.tight(const Size(20, 20)),
                          fillColor: const Color(0xFF14Dfff),
                          shape: const CircleBorder(
                            side: BorderSide(
                                color: Color(0xFF14Dfff),
                                style: BorderStyle.solid),
                          ),
                          child: Icon(
                            Icons.circle_rounded,
                            size: 16.0,
                            color: (report == 'Contains false Content')
                                ? const Color(0xFF14Dfff)
                                : Colors.white,
                          ),
                        ),
                        const Text(
                          'Contains false Content',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              report = 'Advertisement';
                            });
                          },
                          constraints: BoxConstraints.tight(const Size(20, 20)),
                          fillColor: const Color(0xFF14Dfff),
                          shape: const CircleBorder(
                            side: BorderSide(
                                color: Color(0xFF14Dfff),
                                style: BorderStyle.solid),
                          ),
                          child: Icon(
                            Icons.circle_rounded,
                            size: 16.0,
                            color: (report == 'Advertisement')
                                ? const Color(0xFF14Dfff)
                                : Colors.white,
                          ),
                        ),
                        const Text(
                          'Advertisement',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              report = 'Not relevant';
                            });
                          },
                          constraints: BoxConstraints.tight(const Size(20, 20)),
                          fillColor: const Color(0xFF14Dfff),
                          shape: const CircleBorder(
                            side: BorderSide(
                                color: Color(0xFF14Dfff),
                                style: BorderStyle.solid),
                          ),
                          child: Icon(
                            Icons.circle_rounded,
                            size: 16.0,
                            color: (report == 'Not relevant')
                                ? const Color(0xFF14Dfff)
                                : Colors.white,
                          ),
                        ),
                        const Text(
                          'Not relevant',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
                thickness: 0.6,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    child: const Text(
                      'Dimiss',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1484ff)),
                    ),
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                  TextButton(
                    onPressed: () {
                      Report(report, widget.id).then((value) {
                        if (value['data']['errors'].length == 0) {
                          widget.notifyParent(widget.id, report);
                          EasyLoading.showSuccess("Answer Reported");
                        } else {
                          EasyLoading.showError(value['data']['errors'][0]);
                        }
                        Navigator.of(context).maybePop();
                      }).catchError((Object e, StackTrace stackTrace) {
                        print(e.toString());
                        Navigator.of(context).maybePop();
                        EasyLoading.showError("There was some Error");
                        return;
                      });
                    },
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1484ff)),
                    ),
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      );
}
