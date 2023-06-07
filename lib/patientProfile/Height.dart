import 'dart:convert';
import 'dart:core';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'Weight.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Height extends StatefulWidget {
  const Height({Key? key}) : super(key: key);
  @override
  State<Height> createState() => _HeightState();
}

Future <void> updateHeight(int feet, int inches) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_height'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'feet': feet,
      'inch': inches,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _HeightState extends State<Height> {
  late Map profile;
  int feet = 0;
  int inch = 0;
  Future getHeight() async {
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
      String height = profile['data']['profile']['height'] ?? '0';
      if (profile['data']['profile']['height'] != null) {
        feet = int.tryParse(height.substring(0, 1))!;
        inch = int.tryParse(height.substring(7, 8))!;
      } else {
        feet = 0;
        inch = 0;
      }
    });
  }

  @override
  void initState() {
    getHeight();
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
              "Enter Your Height",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Weight()),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 125,
            ),
            Image.asset(
              "assets/icons/height.png",
              scale: 0.8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 160.0,
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
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            'Enter your Height',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: TextFormField(
                                  controller: TextEditingController(text: feet.toString()),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    // hintText: feet.toString(),
                                    hintStyle: TextStyle(
                                      color: Color(0xFF14B4ff),
                                    ),
                                    labelText: 'Feets',
                                    labelStyle: TextStyle(
                                      color: Color(0xFF14B4ff),
                                    ),
                                  ),
                                  onSaved: (String? value) {
                                    feet = int.tryParse(value!) ?? 0;
                                  },
                                  onChanged: (String? value) {
                                    feet = int.tryParse(value!) ?? 0;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: TextFormField(
                                  controller: TextEditingController(
                                      text: inch.toString()),

                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    // hintText: inch.toString(),
                                    hintStyle: TextStyle(
                                      color: Color(0xFF14B4ff),
                                    ),
                                    labelText: 'Inches',
                                    labelStyle: TextStyle(
                                      color: Color(0xFF14B4ff),
                                    ),
                                  ),
                                  onSaved: (String? value) {
                                    inch = int.tryParse(value!) ?? 0;
                                  },
                                  onChanged: (String? value) {
                                    inch = int.tryParse(value!) ?? 0;
                                  },
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
                  updateHeight(feet, inch).then((value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const PatientPersonal(screen: '1',),
                    ),
                  (route) => route.isFirst,
            
                  ));
                  
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
