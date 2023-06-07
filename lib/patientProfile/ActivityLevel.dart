import 'dart:convert';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'Profession.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class ActivityLevel extends StatefulWidget {
  const ActivityLevel({Key? key}) : super(key: key);
  @override
  State<ActivityLevel> createState() => _ActivityLevelState();
}

Future<void> updateActivityLevel(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_activity_level'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'activity': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _ActivityLevelState extends State<ActivityLevel> {
  String selectActivityLevel = "";
  late Map profile;
  Future getActivityLevel() async {
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
      selectActivityLevel = profile['data']['profile']['activity_level'] ?? '';
    });
  }

  @override
  void initState() {
    getActivityLevel();
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
              "Your Activity Level",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profession()),
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
                      'Your Activity Level',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() => selectActivityLevel = 'Low');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 120.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectActivityLevel == 'Low'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectActivityLevel == 'Low'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Low',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectActivityLevel == 'Low'
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
                          setState(() => selectActivityLevel = 'Moderately');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 120.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectActivityLevel == 'Moderately'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectActivityLevel == 'Moderately'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Moderately',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectActivityLevel == 'Moderately'
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
                          setState(() => selectActivityLevel = 'High');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 120.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectActivityLevel == 'High'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectActivityLevel == 'High'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'High',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectActivityLevel == 'High'
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
                          setState(() => selectActivityLevel = 'Very High');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 120.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectActivityLevel == 'Very High'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectActivityLevel == 'Very High'
                                      ? Colors.white
                                      : const Color(0xFF14B2ff),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Very High',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectActivityLevel == 'Very High'
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
                updateActivityLevel(selectActivityLevel).then((value) =>  Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const PatientPersonal(screen: '2',),
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
