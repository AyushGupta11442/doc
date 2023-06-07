import 'dart:convert';

import 'package:doctor/main.dart';
import 'package:doctor/sharedData/medicalHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../provider/shared_pref_helper.dart';
import 'package:http/http.dart' as http;

import 'MedicalInformation.dart';
import 'UpdateRecords.dart';

String? name = SharedPreferencesHelper.getUserName();

Future<List<String>> getRecordData(int id) async {
  var data = await http.get(
      Uri.parse('https://api.doctrro.com/api/medical_record/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      });
  dynamic res = jsonDecode(data.body);
  res = res['data']['medical_record_files'];
  List<String> arr = [];
  for (dynamic r in res) {
    arr.add(r['file_name']);
  }
  return arr;
}

class MedicalDetails extends StatefulWidget {
  late String rType, DATE, TITLE, record_for;
  int id = 0;
  MedicalDetails(
      {Key? key,
      required this.rType,
      required this.id,
      required this.DATE,
      required this.TITLE,
      required this.record_for})
      : super(key: key);

  @override
  State<MedicalDetails> createState() => _MedicalDetails();
}

final GlobalKey<ScaffoldState> gKey = GlobalKey<ScaffoldState>();

class _MedicalDetails extends State<MedicalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: gKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'My Medical Records',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
                future: getRecordData(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/icons/page_Green.webp",
                          scale: 0.7,
                        ));
                  }
                  return SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (String i in snapshot.data)
                              Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Image.network(
                                      'https://api.doctrro.com/assets/uploads/medical_records/$i'))
                          ],
                        ),
                      ));
                }),
            SizedBox(
              height: 393.0,
              width: 390,
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
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Record Title (Event, symptoms, procedure, etc)',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.TITLE,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Record for',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${widget.record_for}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Record type',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      (widget.rType == 'Prescription')
                                          ? "assets/icons/prescription_Blue.png"
                                          : (widget.rType == 'Invoice')
                                              ? "assets/icons/invoice.png"
                                              : "assets/icons/medical.png",
                                      scale: 0.4,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.rType,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Record created on',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.DATE,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateRecord(
                                  initialTitle: widget.TITLE,
                                  id: widget.id,
                                  initialType: widget.rType,
                                  recordfor: widget.record_for,
                                )));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff14b2ff)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text("Edit"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //     const ReportIssue(),
                        //   ),
                        // );
                        showDialog(
                          context: gKey.currentContext!,
                          builder: (BuildContext context) => Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 250,
                                ),
                                SizedBox(
                                  height: 220.0,
                                  child: Card(
                                    elevation: 8.0,
                                    margin: const EdgeInsets.all(20),
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              height: 60,
                                              color: Colors.teal,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Are you sure?',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 120,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      'You are about to delete these records from your drive. You will not be able to recover them.',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          child: const Text(
                                                            "CANCEL",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins Bold',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          onPressed: () {
                                                            //print("Delete");
                                                            Navigator.of(
                                                                    context)
                                                                .maybePop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: const Text(
                                                            "DELETE",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins Bold',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .maybePop();
                                                            EasyLoading.showInfo(
                                                                "Deleting Record\nPlease don't press back button");
                                                            deleteRecord(
                                                                    widget.id)
                                                                .then((value) {
                                                              if (value) {
                                                                EasyLoading
                                                                    .showSuccess(
                                                                        'Record Deleted');
                                                                // Navigator.of(gKey
                                                                //         .currentContext!)
                                                                //     .maybePop();
                                                                Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const MedicalInformation()),
                                                                  (route) => route
                                                                      .isFirst,
                                                                );
                                                              } else {
                                                                EasyLoading
                                                                    .showError(
                                                                        "There is some Error in server");
                                                              }
                                                            }).catchError((Object
                                                                        e,
                                                                    StackTrace
                                                                        stackTrace) {
                                                              //print('Error '+e.toString());
                                                              EasyLoading.showError(
                                                                  "There was some Error");
                                                            });
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                        child: Text("Delete"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
