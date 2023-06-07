import 'dart:convert';
import 'package:doctor/patientProfile/ActivityLevel.dart';
import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../provider/shared_pref_helper.dart';
import 'patientpersonal/controller/ButtonColor.dart';

class FoodPreference extends StatefulWidget {
  const FoodPreference({Key? key}) : super(key: key);
  @override
  State<FoodPreference> createState() => _FoodPreferenceState();
}

Future<void> updateFoodPreference(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();
  final http.Response response = await http.put(
    Uri.parse('https://api.doctrro.com/api/profile/change_food_preference'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'food_habits': title,
    }),
  );
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to update album.');
  }
}

class _FoodPreferenceState extends State<FoodPreference> {
  String selectFoodPreference = "";
  late Map profile;
  Future getFoodPreference() async {
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
      selectFoodPreference =
          profile['data']['profile']['food_preference'] ?? '';
    });
  }

  @override
  void initState() {
    getFoodPreference();
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
              "Your Food Preference",
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
                      builder: (context) => const ActivityLevel()),
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
                      'Food Preference',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() => selectFoodPreference = 'Vegetarian');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 150.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectFoodPreference == 'Vegetarian'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: selectFoodPreference == 'Vegetarian'
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
                                  'Vegetarian',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectFoodPreference == 'Vegetarian'
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
                              () => selectFoodPreference = 'Non-Vegetarian');
                        },
                        child: SizedBox(
                          height: 65.0,
                          width: 150.0,
                          child: Card(
                            elevation: 4.0,
                            color: selectFoodPreference == 'Non-Vegetarian'
                                ? const Color(0xFF14B2ff)
                                : Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color:
                                      selectFoodPreference == 'Non-Vegetarian'
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
                                  'Non-Vegetarian',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color:
                                        selectFoodPreference == 'Non-Vegetarian'
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
                updateFoodPreference(selectFoodPreference)
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
