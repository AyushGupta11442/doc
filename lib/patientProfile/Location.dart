import 'dart:convert';
import 'package:doctor/patientProfile/ProfileCompletePersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../provider/shared_pref_helper.dart';
import 'SmokingHabits.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);
  @override
  State<Location> createState() => _LocationState();
}

Future<void> updateLocation(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_location'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'address': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _LocationState extends State<Location> {
  String enteredAddress = "";
  late Map profile;
  Future getLocation() async {
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
      enteredAddress = profile['data']['profile']['address'] ?? '';
    });
  }

  @override
  void initState() {
    getLocation();
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
              "Enter Your Address",
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
                      builder: (context) => const SmokingHabits()),
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
              "assets/icons/location_Selection.webp",
              scale: 0.8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150.0,
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
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: const Text(
                          'Let us know your Location',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          controller: TextEditingController(
                              text: enteredAddress.toString()),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: enteredAddress,
                            hintStyle: const TextStyle(
                              color: Color(0xFF14B4ff),
                            ),
                            labelText: 'Location',
                          ),
                          onSaved: (String? value) {
                            enteredAddress = value!;
                          },
                          onChanged: (String value) {
                            enteredAddress = value;
                          },
                        ),
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
                  updateLocation(enteredAddress).then((value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ProfileCompletePersonal(),
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
