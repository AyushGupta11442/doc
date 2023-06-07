import 'dart:convert';
import 'package:doctor/patientProfile/Height.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class BloodGroup extends StatefulWidget {
  const BloodGroup({Key? key}) : super(key: key);
  @override
  State<BloodGroup> createState() => _BloodGroupState();
}

Future <void> updateBloodGroup(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_blood_group'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String, String>{
      'blood_group': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _BloodGroupState extends State<BloodGroup> {
  late Map profile;
  String selectedBloodGroup = "";

  Future getBloodGroup() async {
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
      selectedBloodGroup = profile['data']['profile']['blood_group'] ?? '';
    });
  }

  @override
  void initState() {
    getBloodGroup();
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
              "Select Blood Group",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Height()),
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
            "assets/icons/bloodGroup_Selection.webp",
            scale: 0.8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200.0,
              child: Card(
                elevation: 8.0,
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.1), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: const Text(
                        'Select Blood Group',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "A+");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'A+'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'A+'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'A+',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'A+'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "A-");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'A-'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'A-'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'A-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'A-'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "B+");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'B+'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'B+'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'B+',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'B+'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "B-");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'B-'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'B-'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'B-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'B-'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "O+");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'O+'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'O+'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'O+',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'O+'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "O-");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'O-'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'O-'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'O-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'O-'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "AB+");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'AB+'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'AB+'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'AB+',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'AB+'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedBloodGroup = "AB-");
                          },
                          child: SizedBox(
                            height: 60.0,
                            width: 75.0,
                            child: Card(
                              elevation: 4.0,
                              color: selectedBloodGroup == 'AB-'
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: selectedBloodGroup == 'AB-'
                                        ? Colors.white
                                        : const Color(0xFF14B2ff),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'AB-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: selectedBloodGroup == 'AB-'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                    ),
                                  ),
                                ),
                              ),
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
                updateBloodGroup(selectedBloodGroup).then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const PatientPersonal(screen: '1',),
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
