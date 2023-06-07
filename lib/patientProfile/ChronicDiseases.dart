import 'dart:convert';
import 'package:doctor/patientProfile/Injuries.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable

class ChronicDiseases extends StatefulWidget {
  const ChronicDiseases({Key? key}) : super(key: key);

  @override
  State<ChronicDiseases> createState() => _ChronicDiseasesState();
}

Future<void> updateChronicDiseases(List<String> title) async {
  if (title.isEmpty) {
    title.add("None");
  }
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_diseases'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, List<String>>{
      'diseases': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _ChronicDiseasesState extends State<ChronicDiseases> {
  bool textFilled = false;
  List<String> diseases = [];
  late Map profile;
  Future getChronicDiseases() async {
    http.Response response;
    final token = SharedPreferencesHelper.getAuthToken();
    response = await http.get(
      Uri.parse("https://api.doctrro.com/api/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    profile = json.decode(response.body);
    setState(() {
      if (profile['data']['profile']['chronic_diseases'] != null) {
        diseases = (profile['data']['profile']['chronic_diseases']).split(',');
      } else {
        diseases = [];
      }
    });
  }

  @override
  void initState() {
    getChronicDiseases();
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
        backgroundColor: const Color(0xFF14Dfff),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Chronic Diseases",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Injuries()),
                );
              },
              child: const Text(
                "NEXT",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/activity_Blue.webp",
            scale: 1,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 300.0,
            child: Card(
              elevation: 8.0,
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.1), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    child: const Text(
                      'Do You Have Any Chronic Diseases?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(
                      indent: 20,
                      endIndent: 20,
                      height: 8,
                      thickness: 0.5,
                      color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (diseases.contains("None")) {
                                  diseases.remove("None");
                                } else {
                                  diseases.removeRange(0, diseases.length);
                                  diseases.add("None");
                                }
                              });
                            },
                            constraints:
                                BoxConstraints.tight(const Size(16, 16)),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14B2ff),
                                  style: BorderStyle.solid),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 16.0,
                              color: diseases.contains("None")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 210.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Had no Chronic Diseases',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                      indent: 20,
                      endIndent: 20,
                      height: 8,
                      thickness: 0.5,
                      color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (diseases.contains("Diabetes")) {
                                  diseases.remove("Diabetes");
                                } else {
                                  diseases.remove("None");
                                  diseases.add("Diabetes");
                                }
                              });
                            },
                            constraints:
                                BoxConstraints.tight(const Size(16, 16)),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14B2ff),
                                  style: BorderStyle.solid),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 16.0,
                              color: diseases.contains("Diabetes")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Diabetes',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (diseases.contains("Hypertension")) {
                                  diseases.remove("Hypertension");
                                } else {
                                  diseases.remove("None");
                                  diseases.add("Hypertension");
                                }
                              });
                            },
                            constraints:
                                BoxConstraints.tight(const Size(16, 16)),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14B2ff),
                                  style: BorderStyle.solid),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 16.0,
                              color: diseases.contains("Hypertension")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Hypertension',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (diseases.contains("Heart Disease")) {
                                  diseases.remove("Heart Disease");
                                } else {
                                  diseases.remove("None");
                                  diseases.add("Heart Disease");
                                }
                              });
                            },
                            constraints:
                                BoxConstraints.tight(const Size(16, 16)),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14B2ff),
                                  style: BorderStyle.solid),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 16.0,
                              color: diseases.contains("Heart Disease")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Heart Disease',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (diseases.contains("Arthritis")) {
                                  diseases.remove("Arthritis");
                                } else {
                                  diseases.remove("None");
                                  diseases.add("Arthritis");
                                }
                              });
                            },
                            constraints:
                                BoxConstraints.tight(const Size(16, 16)),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14B2ff),
                                  style: BorderStyle.solid),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 16.0,
                              color: diseases.contains("Arthritis")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Arthritis',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (diseases.contains("Depression")) {
                                  diseases.remove("Depression");
                                } else {
                                  diseases.remove("None");
                                  diseases.add("Depression");
                                }
                              });
                            },
                            constraints:
                                BoxConstraints.tight(const Size(16, 16)),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14B2ff),
                                  style: BorderStyle.solid),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 16.0,
                              color: diseases.contains("Depression")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Depression',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (diseases.contains("Fertility Problems")) {
                                  diseases.remove("Fertility Problems");
                                } else {
                                  diseases.remove("None");
                                  diseases.add("Fertility Problems");
                                }
                              });
                            },
                            constraints:
                                BoxConstraints.tight(const Size(16, 16)),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14B2ff),
                                  style: BorderStyle.solid),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 16.0,
                              color: diseases.contains("Fertility Problems")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Fertility Problems',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       RawMaterialButton(
                  //         onPressed: () {},
                  //         constraints: BoxConstraints.tight(const Size(16, 16)),
                  //         fillColor: Colors.white,
                  //         shape: const CircleBorder(
                  //           side: BorderSide(
                  //               color: Colors.blue, style: BorderStyle.solid),
                  //         ),
                  //         child: Icon(
                  //           Icons.circle,
                  //           size: 16.0,
                  //           color: textFilled
                  //               ? const Color(0xFF14B2ff)
                  //               : Colors.white,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 45,
                  //         width: 275,
                  //         child: TextField(
                  //           onChanged: (value) {
                  //             diseases.add(value);
                  //             if (value != "") {
                  //               setState(() {
                  //                 textFilled = true;
                  //               });
                  //             } else {
                  //               setState(() {
                  //                 textFilled = false;
                  //               });
                  //             }
                  //           },
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(
                  //                 borderSide:
                  //                     const BorderSide(color: Colors.black),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             hintText: "Add a chronic disease",
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
          
                minimumSize: const Size.fromHeight(45), // NEW
              ),
              onPressed: () {
                updateChronicDiseases(diseases).then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const PatientPersonal(
                          screen: '3',
                        ),
                      ),
                  (route) => route.isFirst,
                      
                    ));
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
