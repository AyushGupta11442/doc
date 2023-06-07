import 'dart:convert';
import 'package:doctor/patientProfile/Surgeries.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Injuries extends StatefulWidget {
  const Injuries({Key? key}) : super(key: key);
  @override
  State<Injuries> createState() => _InjuriesState();
}

Future<void> updateInjuries(List<String> title) async {
  if (title.isEmpty) {
    title.add("None");
  }
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_injuries'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, List<String>>{
      'injuries': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _InjuriesState extends State<Injuries> {
  List<String> injuries = [];
  late Map profile;
  Future getInjuries() async {
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
      if (profile['data']['profile']['injuries'] != null) {
        injuries = (profile['data']['profile']['injuries']).split(',');
      } else {
        injuries = [];
      }
    });
  }

  @override
  void initState() {
    getInjuries();
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
              "Any Past Injuries?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Surgeries()),
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
                      'Have You Had Any Injuries in the Past ?',
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
                                if (injuries.contains("None")) {
                                  injuries.remove("None");
                                } else {
                                  injuries.removeRange(0, injuries.length);
                                  injuries.add("None");
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
                              color: injuries.contains("None")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 210.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Had no Past Injuries',
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
                                if (injuries.contains("Burns")) {
                                  injuries.remove("Burns");
                                } else {
                                  injuries.remove("None");
                                  injuries.add("Burns");
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
                              color: injuries.contains("Burns")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Burns',
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
                                if (injuries.contains("Spinal Fracture")) {
                                  injuries.remove("Spinal Fracture");
                                } else {
                                  injuries.remove("None");
                                  injuries.add("Spinal Fracture");
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
                              color: injuries.contains("Spinal Fracture")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Spinal Fracture',
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
                                if (injuries.contains("Jaw Fracture")) {
                                  injuries.remove("Jaw Fracture");
                                } else {
                                  injuries.remove("None");
                                  injuries.add("Jaw Fracture");
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
                              color: injuries.contains("Jaw Fracture")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Jaw Fracture',
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
                                if (injuries.contains("Facial Trauma")) {
                                  injuries.remove("Facial Trauma");
                                } else {
                                  injuries.remove("None");
                                  injuries.add("Facial Trauma");
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
                              color: injuries.contains("Facial Trauma")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Facial Trauma',
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
                                if (injuries.contains("Brain Injury")) {
                                  injuries.remove("Brain Injury");
                                } else {
                                  injuries.remove("None");
                                  injuries.add("Brain Injury");
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
                              color: injuries.contains("Brain Injury")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Brain Injury',
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
                                if (injuries.contains("Acoustic Trauma")) {
                                  injuries.remove("Acoustic Trauma");
                                } else {
                                  injuries.remove("None");
                                  injuries.add("Acoustic Trauma");
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
                              color: injuries.contains("Acoustic Trauma")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Acoustic Trauma',
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
                  //         child: const Icon(
                  //           Icons.circle,
                  //           size: 16.0,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 45,
                  //         width: 275,
                  //         child: TextField(
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(
                  //                 borderSide:
                  //                     const BorderSide(color: Colors.black),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             hintText: "Add a injury",
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
                updateInjuries(injuries).then((value) => Navigator.pushAndRemoveUntil(
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
