import 'package:doctor/patientProfile/Birthday.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);
  @override
  State<Gender> createState() => _GenderState();
}

Future<void> updateGender(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_gender'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'gender': title,
    }),
  );
  if (response.statusCode == 200) {
    SharedPreferencesHelper.setUserGender(title);
  } else {
    throw Exception('Failed to update album.');
  }
}

class _GenderState extends State<Gender> {
  late Map profile;
  String selectedGender = "";
  Future getGender() async {
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
      selectedGender = profile['data']['profile']['gender'] ?? '';
    });
  }

  @override
  void initState() {
    getGender();
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
              "Select Your Gender",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Birthday()),
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
            "assets/icons/gender_Selection.webp",
            scale: 0.8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 180.0,
              child: Card(
                elevation: 8.0,
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.1), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          'Select your Gender',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                         
                          GestureDetector(
                            onTap: () {
                              setState(() => selectedGender = "Male");
                            },
                            child: SizedBox(
                              height: 60.0,
                              // width: ,
                              child: Card(
                                elevation: 4.0,
                                color: selectedGender == 'Male'
                                    ? const Color(0xFF14B2ff)
                                    : Colors.white,
                                margin: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: selectedGender == 'Male'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                      width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Male',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: selectedGender == 'Male'
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
                              setState(() => selectedGender = "Female");
                            },
                            child: SizedBox(
                              height: 60.0,
                              // width: 95.0,
                              child: Card(
                                elevation: 4.0,
                                color: selectedGender == 'Female'
                                    ? const Color(0xFF14B2ff)
                                    : Colors.white,
                                margin: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: selectedGender == 'Female'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                      width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Female',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: selectedGender == 'Female'
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
                              setState(() => selectedGender = "Other");
                            },
                            child: SizedBox(
                              height: 60.0,
                              // width: 95.0,
                              child: Card(
                                elevation: 4.0,
                                color: selectedGender == 'Other'
                                    ? const Color(0xFF14B2ff)
                                    : Colors.white,
                                margin: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: selectedGender == 'Other'
                                          ? Colors.white
                                          : const Color(0xFF14B2ff),
                                      width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Other',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: selectedGender == 'Other'
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
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width /2.5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
          padding: EdgeInsets.all(12),
                minimumSize: const Size.fromHeight(45), // NEW
              ),
              onPressed: () {
                updateGender(selectedGender).then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const PatientPersonal(
                          screen: '1',
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
