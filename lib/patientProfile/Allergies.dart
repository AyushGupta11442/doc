import 'dart:convert';
import 'package:doctor/patientProfile/ChronicDiseases.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

//ignore: must_be_immutable
class Allergies extends StatefulWidget {
  const Allergies({Key? key}) : super(key: key);
  @override
  State<Allergies> createState() => _AllergiesState();
}

Future<void> updateAllergies(List<String> title) async {
  if (title.isEmpty) {
    title.add("None");
  }
  final token = SharedPreferencesHelper.getAuthToken();
  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/profile/change_allergic'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String, List<String>>{
      'allergies': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _AllergiesState extends State<Allergies> {
  List<String> allergies = [];
  late Map profile;
  Future getAllergies() async {
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
      if (profile['data']['profile']['allergies'] != null) {
        allergies = (profile['data']['profile']['allergies']).split(',');
      } else {
        allergies = [];
      }
    });
  }

  @override
  void initState() {
    getAllergies();
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
              "Allergies",
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
                      builder: (context) => const ChronicDiseases()),
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
            scale: 1,
          ),
          const SizedBox(
            height: 36,
          ),
          SizedBox(
            height: 290.0,
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
                      'Are you allergic to anything?',
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (allergies.contains("Pets")) {
                                  allergies.remove("Pets");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Pets");
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
                              color: allergies.contains("Pets")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Pets',
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
                                if (allergies.contains("Aspirin")) {
                                  allergies.remove("Aspirin");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Aspirin");
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
                              color: allergies.contains("Aspirin")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Aspirin',
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
                                if (allergies.contains("Gluten")) {
                                  allergies.remove("Gluten");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Gluten");
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
                              color: allergies.contains("Gluten")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Gluten',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (allergies.contains("Insulin")) {
                                  allergies.remove("Insulin");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Insulin");
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
                              color: allergies.contains("Insulin")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Insulin',
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
                                if (allergies.contains("Pollen")) {
                                  allergies.remove("Pollen");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Pollen");
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
                              color: allergies.contains("Pollen")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Pollen',
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
                                if (allergies.contains("Mushroom")) {
                                  allergies.remove("Mushroom");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Mushroom");
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
                              color: allergies.contains("Mushroom")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 55.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mushroom',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (allergies.contains("X-Ray Dye")) {
                                  allergies.remove("X-Ray Dye");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("X-Ray Dye");
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
                              color: allergies.contains("X-Ray Dye")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'X-Ray Dye',
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
                                if (allergies.contains("Lactose")) {
                                  allergies.remove("Lactose");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Lactose");
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
                              color: allergies.contains("Lactose")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lactose',
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
                                if (allergies.contains("Fish")) {
                                  allergies.remove("Fish");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Fish");
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
                              color: allergies.contains("Fish")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Fish',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                if (allergies.contains("Mold")) {
                                  allergies.remove("Mold");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Mold");
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
                              color: allergies.contains("Mold")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mold',
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
                                if (allergies.contains("Mutton")) {
                                  allergies.remove("Mutton");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Mutton");
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
                              color: allergies.contains("Mutton")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mutton',
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
                                if (allergies.contains("Chicken")) {
                                  allergies.remove("Chicken");
                                } else {
                                  allergies.remove("None");
                                  allergies.add("Chicken");
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
                              color: allergies.contains("Chicken")
                                  ? const Color(0xFF14B2ff)
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Chicken',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
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
                updateAllergies(allergies)
                    .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const PatientPersonal(
                              screen: '3',
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
