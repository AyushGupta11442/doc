import 'dart:convert';
import 'package:doctor/patientProfile/AlcoholConsumption.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class SmokingHabits extends StatefulWidget {
  const SmokingHabits({Key? key}) : super(key: key);
  @override
  State<SmokingHabits> createState() => _SmokingHabitsState();
}

Future<void> updateSmokingHabit(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_smoking_habits'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'smoking_habits': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _SmokingHabitsState extends State<SmokingHabits> {
  String selectSmokingHabit = "";
  late Map profile;
  Future getSmokingHabits() async {
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
      selectSmokingHabit = profile['data']['profile']['smoking_habits'] ?? '';
    });
  }

  @override
  void initState() {
    getSmokingHabits();
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
              "Your Smoking Habits",
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
                      builder: (context) => const AlcoholConsumption()),
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
            "assets/icons/smoking_Blue.webp",
            scale: 0.8,
          ),
          const SizedBox(
            height: 36,
          ),
          SizedBox(
            height: 200.0,
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
                      'Your Smoking Habits',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() => selectSmokingHabit = 'I don\'t smoke');
                        },
                        child: SizedBox(
                          height: 60.0,
                          // width: 170.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectSmokingHabit == 'I don\'t smoke'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(6),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectSmokingHabit == 'I don\'t smoke'
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
                                  'I don\'t smoke',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color:
                                        selectSmokingHabit == 'I don\'t smoke'
                                            ? Colors.white
                                            : const Color(0xFF14B2ff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                          () => selectSmokingHabit = '1-2/Day');
                                    },
                                    child: SizedBox(
                                      height: 60.0,
                                      //width: 103.0,
                                      child: Card(
                                        elevation: 4.0,
                                        color: selectSmokingHabit == '1-2/Day'
                                            ? const Color(0xFF14B2ff)
                                            : Colors.white,
                                        margin: const EdgeInsets.all(6),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: selectSmokingHabit ==
                                                      '1-2/Day'
                                                  ? Colors.white
                                                  : const Color(0xFF14B2ff),
                                              width: 2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '1-2/Day',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: selectSmokingHabit ==
                                                        '1-2/Day'
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
                                      setState(
                                          () => selectSmokingHabit = '3-6/Day');
                                    },
                                    child: SizedBox(
                                      height: 60.0,
                                      //width: 103.0,
                                      child: Card(
                                        elevation: 4.0,
                                        color: selectSmokingHabit == '3-6/Day'
                                            ? const Color(0xFF14B2ff)
                                            : Colors.white,
                                        margin: const EdgeInsets.all(6),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: selectSmokingHabit ==
                                                      '3-6/Day'
                                                  ? Colors.white
                                                  : const Color(0xFF14B2ff),
                                              width: 2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '3-6/Day',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: selectSmokingHabit ==
                                                        '3-6/Day'
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
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() =>
                                          selectSmokingHabit = '6-10/Day');
                                    },
                                    child: SizedBox(
                                      height: 60.0,
                                      //width: 103.0,
                                      child: Card(
                                        elevation: 4.0,
                                        color: selectSmokingHabit == '6-10/Day'
                                            ? const Color(0xFF14B2ff)
                                            : Colors.white,
                                        margin: const EdgeInsets.all(6),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: selectSmokingHabit ==
                                                      '6-10/Day'
                                                  ? Colors.white
                                                  : const Color(0xFF14B2ff),
                                              width: 2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '6-10/Day',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: selectSmokingHabit ==
                                                        '6-10/Day'
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
                                      setState(
                                          () => selectSmokingHabit = '>10/Day');
                                    },
                                    child: SizedBox(
                                      height: 60.0,
                                      //width: 103.0,
                                      child: Card(
                                        elevation: 4.0,
                                        color: selectSmokingHabit == '>10/Day'
                                            ? const Color(0xFF14B2ff)
                                            : Colors.white,
                                        margin: const EdgeInsets.all(6),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: selectSmokingHabit ==
                                                      '>10/Day'
                                                  ? Colors.white
                                                  : const Color(0xFF14B2ff),
                                              width: 2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '>10/Day',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: selectSmokingHabit ==
                                                        '>10/Day'
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
                        ],
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 10,)
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
                updateSmokingHabit(selectSmokingHabit).then((value) => Navigator.pushAndRemoveUntil(
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
