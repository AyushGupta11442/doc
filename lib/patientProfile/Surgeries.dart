import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'ProfileCompleteMedical.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Surgeries extends StatefulWidget {
  const Surgeries({Key? key}) : super(key: key);
  @override
  State<Surgeries> createState() => _SurgeriesState();
}

Future<void> updateSurgeries(List<String> title) async {
  if (title.isEmpty) {
    title.add("None");
  }
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_surgeries'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, List<String>>{
      'surgeries': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _SurgeriesState extends State<Surgeries> {
  List<String> surgeries = [];
  late Map profile;
  Future getSurgeries() async {
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
      if (profile['data']['profile']['surgeries'] != null) {
        surgeries = (profile['data']['profile']['surgeries']).split(',');
      } else {
        surgeries = [];
      }
    });
  }

  @override
  void initState() {
    getSurgeries();
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
          children: const [
            Text(
              "Any Past Surgeries?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
                      'Have You Had Any Surgeries \nin the Past ?',
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
                                if (surgeries.contains("None")) {
                                  surgeries.remove("None");
                                } else {
                                  surgeries.removeRange(0, surgeries.length);
                                  surgeries.add("None");
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
                              color: surgeries.contains("None")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 210.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Had no Past Surgeries',
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
                                if (surgeries.contains("Heart")) {
                                  surgeries.remove("Heart");
                                } else {
                                  surgeries.remove("None");
                                  surgeries.add("Heart");
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
                              color: surgeries.contains("Heart")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Heart',
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
                                if (surgeries.contains("Liver")) {
                                  surgeries.remove("Liver");
                                } else {
                                  surgeries.remove("None");
                                  surgeries.add("Liver");
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
                              color: surgeries.contains("Liver")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Liver',
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
                                if (surgeries.contains("Kidney")) {
                                  surgeries.remove("Kidney");
                                } else {
                                  surgeries.remove("None");
                                  surgeries.add("Kidney");
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
                              color: surgeries.contains("Kidney")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kidney',
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
                                if (surgeries.contains("Lungs")) {
                                  surgeries.remove("Lungs");
                                } else {
                                  surgeries.remove("None");
                                  surgeries.add("Lungs");
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
                              color: surgeries.contains("Lungs")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lungs',
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
                                if (surgeries.contains("Brain")) {
                                  surgeries.remove("Brain");
                                } else {
                                  surgeries.remove("None");
                                  surgeries.add("Brain");
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
                              color: surgeries.contains("Brain")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Brain',
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
                                if (surgeries.contains("Facial/Cosmetic")) {
                                  surgeries.remove("Facial/Cosmetic");
                                } else {
                                  surgeries.remove("None");
                                  surgeries.add("Facial/Cosmetic");
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
                              color: surgeries.contains("Facial/Cosmetic")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 110.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Facial/Cosmetic',
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
                  //         constraints:
                  //             BoxConstraints.tight(const Size(16, 16)),
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
                  //             hintText: "Add a surgery",
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
                updateSurgeries(surgeries).then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ProfileCompleteMedical(),
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
