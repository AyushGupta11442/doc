import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:doctor/sharedData/classes.dart';

//final ageController = TextEditingController();
//final problemController = TextEditingController();
final titleController = TextEditingController();
final bodyController = TextEditingController();
int len = 0;
int len1 = 0;

dynamic resBody = {};

//ignore: must_be_immutable
class AskQuestion extends StatefulWidget {
  const AskQuestion({Key? key}) : super(key: key);

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  String special_about = "2";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Ask Your Question',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       height: 60.0,
              //       child: Card(
              //         elevation: 8.0,
              //         shape: RoundedRectangleBorder(
              //           side: BorderSide(
              //               color: Colors.black.withOpacity(0.05), width: 1),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(12)),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //               Row(
              //                 children: [
              //                   Container(
              //                     padding: const EdgeInsets.all(4),
              //                     decoration: const BoxDecoration(
              //                         color: Color(0xFF14D4FF),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(60))),
              //                     child: const Icon(
              //                       Icons.manage_accounts_outlined,
              //                       size: 16.0,
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                   const SizedBox(
              //                     width: 12,
              //                   ),
              //                   const Padding(
              //                     padding: EdgeInsets.only(top: 18),
              //                     child: Center(
              //                       child: SizedBox(
              //                           width: 100,
              //                           height: 100,
              //                           child: Text('Mysellf')),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 4.0,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           showModalBottomSheet<void>(
              //             context: context,
              //             backgroundColor: Colors.transparent,
              //             builder: (BuildContext context) {
              //               return Card(
              //                 elevation: 2.0,
              //                 shape: const RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.only(
              //                       topLeft: Radius.circular(15),
              //                       topRight: Radius.circular(15)),
              //                 ),
              //                 color: Colors.white,
              //                 child: Padding(
              //                   padding: const EdgeInsets.only(top: 12),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: const <Widget>[
              //                       SizedBox(
              //                         height: 12,
              //                       ),
              //                       Text(
              //                         'We are sorry. Tell us about you issue.',
              //                         style: TextStyle(
              //                           fontSize: 20,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         height: 12,
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         },
              //         style: ButtonStyle(
              //           backgroundColor: MaterialStateProperty.all(
              //             const Color(0xFF1484FF),
              //           ),
              //         ),
              //         child: const Padding(
              //           padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              //           child: Text("Add Member"),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 60.0,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.05), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: Color(0xFF14D4FF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60))),
                              child: const Icon(
                                Icons.filter,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 110.0,
                              height: 100,
                              child: FutureBuilder(
                                  future: getSP(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.data == null ||
                                        snapshot.data.length == 0) {
                                      return Container(
                                        child: const Center(
                                          child:
                                              Text("No Items to choose from"),
                                        ),
                                      );
                                    }
                                    List<DropdownMenuItem<String>> arr =
                                        <DropdownMenuItem<String>>[];
                                    for (sp x in snapshot.data) {
                                      arr.add(DropdownMenuItem<String>(
                                        value: x.id.toString(),
                                        child: Text(x.data),
                                      ));
                                    }
                                    return DropdownButton<String>(
                                      icon: const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 16.0,
                                        color: Colors.lightBlue,
                                      ),
                                      value: special_about,
                                      isExpanded: true,
                                      items: arr,
                                      onChanged: (String? str) {
                                        if (str != null) {
                                          setState(() {
                                            special_about = str;
                                          });
                                        }
                                      },
                                    );
                                  })
                              /*TextFormField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 4, bottom: 16, top: 16, right: 4),
                                  hintText: "Select Problem Type",
                                  hintStyle: TextStyle(fontSize: 12),
                                ),
                              )*/
                              ,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.05), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: Color(0xFF14D4FF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60))),
                              child: const Icon(
                                Icons.title,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: 200,
                              height: 100,
                              child: TextFormField(
                                cursorColor: Colors.black,
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    len = value.length;
                                  });
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40)
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 4, bottom: 16, top: 16, right: 4),
                                  hintText: "Title (Minimum 40 chars)",
                                  hintStyle: TextStyle(fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          '$len/40',
                          style: const TextStyle(
                            color: Color(0xFF14D4FF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 300.0,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.05), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF14D4FF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(60),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.keyboard,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 280,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        len1 = value.length;
                                      });
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1000)
                                    ],
                                    cursorColor: Colors.black,
                                    controller: bodyController,
                                    maxLines: 50,
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 4, bottom: 32, right: 4),
                                      hintText:
                                          "Description (Minimum 1000 chars)",
                                      hintStyle: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '$len1/1000',
                              style: const TextStyle(
                                color: Color(0xFF14D4FF),
                                fontSize: 12,
                              ),
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => const (),
            //   ),
            // );
            submitQuestion(
                    titleController.text, bodyController.text, special_about)
                .then((res) => {
                      resBody = jsonDecode(res.body),
                      if (resBody['data']['errors'] != null)
                        {EasyLoading.showError(resBody['data']['errors'][0])}
                      else
                        {
                          EasyLoading.showSuccess(
                              "Question submitted Successfully"),
                          Navigator.of(context).maybePop(),
                        },
                    })
                .catchError((Object e, StackTrace stackTrace) {
              print(e.toString());
              EasyLoading.showError("There was some Error");
            });
          },
          color: const Color(0xff14B2FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: const Text(
            'Submit',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
