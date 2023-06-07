import 'dart:convert';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/patientProfile/BloodGroup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Birthday extends StatefulWidget {
  const Birthday({Key? key}) : super(key: key);
  @override
  State<Birthday> createState() => _BirthdayState();
}

Future <void> updateDateOfBirth(DateTime selectedDate) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_dob'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({
      'date_of_birth': selectedDate.toString().substring(0, 10),
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _BirthdayState extends State<Birthday> {
  late Map profile;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();

  Future getBirthday() async {
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
      date = profile['data']['profile']['date_of_birth'] ?? '';
    });
  }

  @override
  void initState() {
    getBirthday();
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
              "Select Your Birthday",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BloodGroup()),
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
            "assets/icons/birthday_Selection.webp",
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          'Select your Birthday',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  date,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const Icon(Icons.arrow_forward,
                                  color: Colors.black, size: 24.0),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              _selectDate(context);
                            },
                            child: Image.asset(
                              "assets/icons/birthday_Selection.webp",
                              scale: 2,
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
                        width: MediaQuery.of(context).size.width / 2.5,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                 backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {
                
                updateDateOfBirth(selectedDate).then((value) => Navigator.pushAndRemoveUntil(
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (selected != null && selected != selectedDate) {
      setState(
        () {
          selectedDate = selected;
          _textEditingController
            ..text = DateFormat.yMMMd().format(selectedDate)
            ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: _textEditingController.text.length,
                  affinity: TextAffinity.upstream),
            );
        },
      );

      setState(() {
        date = (selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString());
      });
    }
  }
}
