import 'dart:convert';
import 'package:doctor/patientProfile/MaritalStatus.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Profession extends StatefulWidget {
  const Profession({Key? key}) : super(key: key);
  @override
  State<Profession> createState() => _ProfessionState();
}

Future<void> updateProfession(String title) async {
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_occupation'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPreferencesHelper.getAuthToken()}',
    },
    body: jsonEncode(<String, String>{
      'profession': title,
    }),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _ProfessionState extends State<Profession> {
  String selectProfession = "";
  late Map profile;
  Future getProfession() async {
    http.Response response;
    String token = SharedPreferencesHelper.getAuthToken();
    response = await http.get(
      Uri.parse("https://api.doctrro.com/api/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    profile = json.decode(response.body);
    setState(() {
      selectProfession = profile['data']['profile']['occupation'] ?? '';
    });
  }

  @override
  void initState() {
    getProfession();
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
              "Your Profession",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MaritalStatus()),
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
            "assets/icons/profession_Blue.webp",
            scale: 0.8,
          ),
          const SizedBox(
            height: 36,
          ),
          SizedBox(
            height: 215.0,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    child: const Text(
                      'Your Profession',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() => selectProfession = 'It');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 110.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectProfession == 'It'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6.0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectProfession == 'It'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'IT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectProfession == 'It'
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
                          setState(() => selectProfession = 'Banking');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 110.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectProfession == 'Banking'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6.0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectProfession == 'Banking'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Banking',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectProfession == 'Banking'
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
                          setState(() => selectProfession = 'Education');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 110.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectProfession == 'Education'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6.0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectProfession == 'Education'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Education',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectProfession == 'Education'
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() => selectProfession = 'Student');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 110.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectProfession == 'Student'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6.0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectProfession == 'Student'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Student',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectProfession == 'Student'
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
                          setState(() => selectProfession = 'Medical');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 110.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectProfession == 'Medical'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6.0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectProfession == 'Medical'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Medical',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectProfession == 'Medical'
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
                          setState(() => selectProfession = 'Engineering');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 110.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectProfession == 'Engineering'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6.0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectProfession == 'Engineering'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Engineering',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectProfession == 'Engineering'
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
                updateProfession(selectProfession)
                    .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const PatientPersonal(
                              screen: '2',
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
