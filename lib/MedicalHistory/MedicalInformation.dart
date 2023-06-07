import 'package:doctor/MedicalHistory/AddMedicalRecords.dart';
import 'package:doctor/MedicalHistory/UpdateRecords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../sharedData/medicalHistory.dart';

import 'MedicalDetails.dart';

class MedicalInformation extends StatefulWidget {
  const MedicalInformation({Key? key}) : super(key: key);

  @override
  State<MedicalInformation> createState() => _MedicalInformation();
}

class _MedicalInformation extends State<MedicalInformation> {
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
          'My Medical Records',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              FutureBuilder(
                  future: getMedicalRecords(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null || snapshot.data.length == 0) {
                      return Container(
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("No Records Yet"),
                          ),
                        ),
                      );
                    }
                    return Column(mainAxisSize: MainAxisSize.max, children: <
                        Widget>[
                      for (medicalRecord m in snapshot.data)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 8.0,
                              margin: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black.withOpacity(0.4),
                                    width: 1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        m.dateDay,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28),
                                      ),
                                      Text(
                                        m.dateMonth,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MedicalDetails(
                                            rType: m.type,
                                            id: m.id,
                                            DATE: getFormattedDate(m.date),
                                            TITLE: m.title,
                                            record_for: m.record_for,
                                          )));
                                },
                                child: SizedBox(
                                    height: 100.0,
                                    //width: double.infinity, //MediaQuery.of(context).size.width,
                                    child: Card(
                                      elevation: 8.0,
                                      margin: const EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            width: 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, top: 15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    // color: Colors.amber,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            200,
                                                    child: Text(
                                                      m.title,
                                                      style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    )),
                                                Container(
                                                  height: 15,
                                                  child:
                                                      PopupMenuButton<String>(
                                                    iconSize: 10,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      //top: 16.0,
                                                      right: 16.0,
                                                      left: 16.0,
                                                    ),
                                                    color:
                                                        const Color(0xFF1484ff),
                                                    icon: const Icon(
                                                      Icons.more_vert,
                                                      size: 24,
                                                      color: Color(0xFF1484ff),
                                                    ),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(12),
                                                      ),
                                                    ),
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return [
                                                        const PopupMenuItem(
                                                          child: Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          value: '/edit',
                                                        ),
                                                        const PopupMenuItem(
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          value: '/delete',
                                                        )
                                                      ];
                                                    },
                                                    onSelected: (value) {
                                                      if (value == '/delete') {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Center(
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 250,
                                                                ),
                                                                SizedBox(
                                                                  height: 220.0,
                                                                  child: Card(
                                                                    elevation:
                                                                        8.0,
                                                                    margin:
                                                                        const EdgeInsets.all(
                                                                            20),
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              height: 60,
                                                                              color: Colors.teal,
                                                                              child: Container(
                                                                                margin: const EdgeInsets.only(left: 16, right: 16),
                                                                                child: const Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    'Are you sure?',
                                                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 120,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(16.0),
                                                                                child: Column(
                                                                                  children: [
                                                                                    const Text(
                                                                                      'You are about to delete these records from your drive. You will not be able to recover them.',
                                                                                      style: TextStyle(
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.w400,
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        TextButton(
                                                                                          child: const Text(
                                                                                            "CANCEL",
                                                                                            style: TextStyle(fontFamily: 'Poppins Bold', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            //print("Delete");
                                                                                            Navigator.of(context).maybePop();
                                                                                          },
                                                                                        ),
                                                                                        TextButton(
                                                                                          child: const Text(
                                                                                            "DELETE",
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Poppins Bold',
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 16,
                                                                                              color: Colors.blue,
                                                                                            ),
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            deleteRecord(m.id).then((value) {
                                                                                              if (value) {
                                                                                                EasyLoading.showSuccess('Record Deleted');
                                                                                              } else {
                                                                                                EasyLoading.showError("There is some Error in server");
                                                                                              }
                                                                                              Navigator.of(context).maybePop();
                                                                                              setState(() {});
                                                                                            }).catchError((Object e, StackTrace stackTrace) {
                                                                                              //print(e.toString());
                                                                                              EasyLoading.showError("There was some Error");
                                                                                              Navigator.of(context).maybePop();
                                                                                              setState(() {});
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
                                                      } else if (value ==
                                                          '/edit') {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        UpdateRecord(
                                                                          initialTitle:
                                                                              m.title,
                                                                          id: m
                                                                              .id,
                                                                          initialType:
                                                                              m.type,
                                                                          recordfor:
                                                                              m.record_for,
                                                                        )));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      200,
                                                  child: Text(
                                                    m.record_for,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      200,
                                                  child: Text(
                                                    'Type: ${m.type}',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )))
                          ],
                        )
                    ]);
                  }),
              //const SizedBox(height: 520),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddMedicalRecords()));
                  },
                  color: const Color(0xff14B2FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: const Text(
                    "Upload Records",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

const List<String> fullMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

String getFormattedDate(String date) {
  List<String> d = date.split('-');
  String day = int.parse(d[2]).toString();
  return day + ' ${fullMonths[int.parse(d[1]) - 1]}' + ', ${d[0]}';
}
