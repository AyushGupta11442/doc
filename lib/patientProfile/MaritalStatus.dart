import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../provider/shared_pref_helper.dart';
import 'Allergies.dart';
import 'ProfileCompleteLifestyle.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class MaritalStatus extends StatefulWidget {
  const MaritalStatus({Key? key}) : super(key: key);
  @override
  State<MaritalStatus> createState() => _MaritalStatusState();
}

Future<void> updateMaritalStatus(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_marital_status'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'marital_status': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _MaritalStatusState extends State<MaritalStatus> {
  String selectMaritalStatus = '';
  late Map profile;
  Future getMaritalStatus() async {
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
      selectMaritalStatus = profile['data']['profile']['marital_status'] ?? '';
    });
  }

  @override
  void initState() {
    getMaritalStatus();
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
              "Your Marital Status",
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
                    builder: (BuildContext context) =>
                        const Allergies(),
                  ),
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
            "assets/icons/foodPreference.png",
            scale: 0.8,
          ),
          const SizedBox(
            height: 36,
          ),
          SizedBox(
            height: 150.0,
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
                      'Your Marital Status',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() => selectMaritalStatus = 'Married');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 150.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectMaritalStatus == 'Married'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectMaritalStatus == 'Married'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Married',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectMaritalStatus == 'Married'
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
                          setState(() => selectMaritalStatus = 'Single');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 150.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectMaritalStatus == 'Single'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectMaritalStatus == 'Single'
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
                                  'Single',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectMaritalStatus == 'Single'
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
                updateMaritalStatus(selectMaritalStatus).then((value) =>  Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ProfileCompleteLifestyle(),
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
