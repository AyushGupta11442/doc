import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/core/constants.dart';
import 'package:doctor/patientProfile/ActivityLevel.dart';
import 'package:doctor/patientProfile/AlcoholConsumption.dart';
import 'package:doctor/patientProfile/Allergies.dart';
import 'package:doctor/patientProfile/Birthday.dart';
import 'package:doctor/patientProfile/BloodGroup.dart';
import 'package:doctor/patientProfile/ChronicDiseases.dart';
import 'package:doctor/patientProfile/FoodPreference.dart';
import 'package:doctor/patientProfile/Height.dart';
import 'package:doctor/patientProfile/Injuries.dart';
import 'package:doctor/patientProfile/MaritalStatus.dart';
import 'package:doctor/patientProfile/Number.dart';
import 'package:doctor/patientProfile/Profession.dart';
import 'package:doctor/patientProfile/SmokingHabits.dart';
import 'package:doctor/patientProfile/Surgeries.dart';
import 'package:doctor/patientProfile/Weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../provider/shared_pref_helper.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Email.dart';
import '../../Gender.dart';
import '../../Location.dart';
import '../controller/patientpersonal_controller.dart';

import 'package:http/http.dart';

Future<void> medicalupdateName(String title) async {
  final token = SharedPreferencesHelper.getAuthToken();

  final Response response = await put(
    Uri.parse('https://api.doctrro.com/api/edit_name'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'name': title,
    }),
  );
  if (response.statusCode == 200) {
    SharedPreferencesHelper.setUserName(title);
  } else {
    throw Exception('Failed to update Name');
  }
}

//ignore: must_be_immutable
class PatientPersonal extends ConsumerStatefulWidget {
  const PatientPersonal({Key? key, required this.screen}) : super(key: key);
  final String screen;

  @override
  ConsumerState<PatientPersonal> createState() => _PatientPersonalState();
}

class _PatientPersonalState extends ConsumerState<PatientPersonal> {
  String uname = "";
  late String screen = widget.screen;

  Color personalcolor = const Color(0xFF14B2ff);
  Color personaltextcolor = Colors.white;
  Color personalbordercolor = const Color(0xFF14B2ff);
  Color lifestylecolor = Colors.white;
  Color lifestyletextcolor = const Color(0xFF14B2ff);
  Color lifestylebordercolor = const Color(0xFF14B2ff);
  Color medicalcolor = Colors.white;
  Color medicaltextcolor = const Color(0xFF14B2ff);
  Color medicalbordercolor = const Color(0xFF14B2ff);

  Future<void> getColors() async {
    switch (widget.screen) {
      case "1":
        {
          setState(() {
            personalcolor = const Color(0xFF14B2ff);
            personaltextcolor = Colors.white;
            personalbordercolor = const Color(0xFF14B2ff);
            lifestylecolor = Colors.white;
            lifestyletextcolor = const Color(0xFF14B2ff);
            lifestylebordercolor = const Color(0xFF14B2ff);
            medicalcolor = Colors.white;
            medicaltextcolor = const Color(0xFF14B2ff);
            medicalbordercolor = const Color(0xFF14B2ff);
          });
        }
        break;

      case "2":
        {
          setState(() {
            personalcolor = Colors.white;
            personaltextcolor = const Color(0xFF14B2ff);
            personalbordercolor = const Color(0xFF14B2ff);
            lifestylecolor = const Color(0xFF14B2ff);
            lifestyletextcolor = Colors.white;
            lifestylebordercolor = const Color(0xFF14B2ff);
            medicalcolor = Colors.white;
            medicaltextcolor = const Color(0xFF14B2ff);
            medicalbordercolor = const Color(0xFF14B2ff);
          });
          //statements;
        }
        break;

      case "3":
        {
          setState(() {
            personalcolor = Colors.white;
            personaltextcolor = const Color(0xFF14B2ff);
            personalbordercolor = const Color(0xFF14B2ff);
            lifestylecolor = Colors.white;
            lifestyletextcolor = const Color(0xFF14B2ff);
            lifestylebordercolor = const Color(0xFF14B2ff);
            medicalcolor = const Color(0xFF14B2ff);
            medicaltextcolor = Colors.white;
            medicalbordercolor = const Color(0xFF14B2ff);
          });
        }
        break;

      default:
        {
          setState(() {
            personalcolor = const Color(0xFF14B2ff);
            personaltextcolor = Colors.white;
            personalbordercolor = const Color(0xFF14B2ff);
            lifestylecolor = Colors.white;
            lifestyletextcolor = const Color(0xFF14B2ff);
            lifestylebordercolor = const Color(0xFF14B2ff);
            medicalcolor = Colors.white;
            medicaltextcolor = const Color(0xFF14B2ff);
            medicalbordercolor = const Color(0xFF14B2ff);
          });
        }
        break;
    }
  }

  late Map medicalmapResponse;
  String medicalname = '';
  String medicalemail = '';
  String medicalallergies = '';
  String medicalchronicDiseases = '';
  String medicalinjuries = '';
  String medicalsurgeries = '';

  Future medicalapiCall() async {
    final token = SharedPreferencesHelper.getAuthToken();
    http.Response response;
    response = await http.get(
      Uri.parse("https://api.doctrro.com/api/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    medicalmapResponse = await json.decode(response.body);
    setState(() {
      medicalname =
          medicalmapResponse['data']['profile']['name'] ?? 'Enter your name!';
      medicalemail =
          medicalmapResponse['data']['profile']['email'] ?? 'Enter your email!';
      medicalallergies = medicalmapResponse['data']['profile']['allergies'] ??
          'Enter your allergies...';
      if (medicalallergies.length > 28) {
        medicalallergies = medicalallergies.substring(0, 25) + '...';
      }
      medicalchronicDiseases = medicalmapResponse['data']['profile']
              ['chronic_diseases'] ??
          'Enter your chronic...';
      if (medicalchronicDiseases.length > 28) {
        medicalchronicDiseases =
            medicalchronicDiseases.substring(0, 25) + '...';
      }
      medicalinjuries = medicalmapResponse['data']['profile']['injuries'] ??
          'Enter your injuries...';
      if (medicalinjuries.length > 28) {
        medicalinjuries = medicalinjuries.substring(0, 25) + '...';
      }
      medicalsurgeries = medicalmapResponse['data']['profile']['surgeries'] ??
          'Enter your surgeries...';
      if (medicalsurgeries.length > 28) {
        medicalsurgeries = medicalsurgeries.substring(0, 25) + '...';
      }
    });
  }

  late Map lifestylemapResponse;
  String lifestylename = '';
  String lifestyleemail = '';
  String lifestylesmokingHabit = '';
  String lifestylealcoholConsumption = '';
  String lifestylefoodPreference = '';
  String lifestyleactivityLevel = '';
  String lifestyleoccupation = '';
  String lifestylemaritalStatus = '';

  Future lifestyleapiCall() async {
    final token = SharedPreferencesHelper.getAuthToken();
    http.Response response;
    response = await http.get(
      Uri.parse("https://api.doctrro.com/api/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    mapResponse = await json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        name = mapResponse['data']['profile']['name'] ?? 'Enter your name!';
        email = mapResponse['data']['profile']['email'] ?? 'Enter your email!';
        lifestylesmokingHabit =
            mapResponse['data']['profile']['smoking_habits'] ??
                // 'Tell us about your smoking habit!';
                'Tell us about your...';
        if (lifestylesmokingHabit.length > 25) {
          lifestylesmokingHabit =
              lifestylesmokingHabit.substring(0, 20) + ' ...';
        }
        lifestylealcoholConsumption =
            mapResponse['data']['profile']['alcohol_consumption'] ??
                // 'Tell us about your alcohol consumption!';
                'Tell us about your...';
        if (lifestylealcoholConsumption.length > 25) {
          lifestylealcoholConsumption =
              lifestylealcoholConsumption.substring(0, 20) + ' ...';
        }
        lifestylefoodPreference =
            mapResponse['data']['profile']['food_preference'] ??
                // 'Tell us about your food preference!';
                'Tell us about your...';
        if (lifestylefoodPreference.length > 25) {
          lifestylefoodPreference =
              lifestylefoodPreference.substring(0, 20) + ' ...';
        }
        lifestyleactivityLevel =
            mapResponse['data']['profile']['activity_level'] ??
                // 'Tell us about your activity level!';
                'Tell us about your...';
        if (lifestyleactivityLevel.length > 25) {
          lifestyleactivityLevel =
              lifestyleactivityLevel.substring(0, 20) + ' ...';
        }
        lifestyleoccupation = mapResponse['data']['profile']['occupation'] ??
            // 'Tell us about your occupation!';
            'Tell us about your...';

        lifestyleoccupation = lifestyleoccupation;

        lifestylemaritalStatus = mapResponse['data']['profile']
                ['marital_status'] ??
            'Enter your marital status!';
        if (lifestylemaritalStatus.length > 25) {
          lifestylemaritalStatus =
              lifestylemaritalStatus.substring(0, 20) + ' ...';
        }
      });
    }
  }

  late Map mapResponse;
  String name = '';
  String phone = '';
  String email = '';
  String gender = '';
  String dateOfBirth = '';
  String bloodGroup = '';
  String height = '';
  int weight = 0;
  String weightCheck = '';
  String location = '';

  Future apiCall() async {
    final token = SharedPreferencesHelper.getAuthToken();
    http.Response response;
    response = await http.get(
      Uri.parse("https://api.doctrro.com/api/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    mapResponse = await json.decode(response.body);
    setState(() {
      name = mapResponse['data']['profile']['name'] ?? 'Enter your name!';
      phone = mapResponse['data']['profile']['phone_number'] ??
          'Enter your phone number!';
      email = mapResponse['data']['profile']['email'] ?? 'Enter your email!';
      if (email.length > 25) {
        email = email.substring(0, 16) + ' ...';
      }
      gender = mapResponse['data']['profile']['gender'] ?? 'Enter your gender!';
      dateOfBirth = mapResponse['data']['profile']['date_of_birth'] ??
          'Enter your date of birth!';
      bloodGroup = mapResponse['data']['profile']['blood_group'] ??
          'Enter your blood group!';
      height = mapResponse['data']['profile']['height'] ?? 'Enter your height!';
      weight = mapResponse['data']['profile']['weight'] ?? 0;
      if (weight == 0) {
        weightCheck = 'Enter your weight!';
      } else {
        weightCheck = weight.toString() + ' kgs';
      }
      location =
          mapResponse['data']['profile']['address'] ?? 'Enter your address!';
      if (location.length > 25) {
        location = location.substring(0, 20) + ' ...';
      }
    });
  }

  @override
  void initState() {
    apiCall();
    lifestyleapiCall();
    medicalapiCall();
    getColors();
    screen = widget.screen;
    super.initState();
  }

  PatientPersonalController patinetPersonalController =
      PatientPersonalController();

  @override
  Widget build(BuildContext context) {
    final patientProfilePersonalData =
        ref.watch(getPatientPersonalProfileProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF14Dfff),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              const SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF14Dfff),
                  ),
                ),
                height: 50,
                width: double.infinity,
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 64,
                      child: patientProfilePersonalData.when(
                        data: (data) {
                          if (data.error == null) {
                            return CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.black,
                              backgroundImage: CachedNetworkImageProvider(
                                data.data!.data!.profile!.imageFile.isNotEmpty
                                    ? 'https://api.doctrro.com/assets/uploads/customer/profile_pictures/${SharedPreferencesHelper.getUserImage()}'
                                    : dumyProfilePic,
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                        error: (err, stack) {
                          return null;
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 250,
                                  ),
                                  SizedBox(
                                    // height: 260.0,
                                    width: 500,
                                    child: Card(
                                      elevation: 8.0,
                                      margin: const EdgeInsets.all(20),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    RawMaterialButton(
                                                        fillColor: Colors
                                                            .grey.shade200,
                                                        child: Image.asset(
                                                          'assets/icons/folder.png',
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        shape:
                                                            const CircleBorder(),
                                                        onPressed: () {}),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        // ! upload image from galery
                                                        var image =
                                                            await patinetPersonalController
                                                                .pickImageGallery(
                                                                    context);
                                                        // await EasyLoading
                                                        //     .show(
                                                        //         status:
                                                        //             'Uploading...');

                                                        if (image != null) {
                                                          await patinetPersonalController
                                                              .uploadProfileImage(
                                                                  image, ref)
                                                              .then((value) =>
                                                                  apiCall());

                                                          // EasyLoading
                                                          //     .dismiss();
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Upload Photo',
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                // const Divider(
                                                //   height: 8,
                                                //   color: Colors.black,
                                                // ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                // Row(
                                                //   children: [
                                                //     RawMaterialButton(
                                                //       fillColor:
                                                //           Colors.grey.shade200,
                                                //       child: Image.asset(
                                                //         'assets/icons/viewPhoto.png',
                                                //         height: 30,
                                                //         width: 30,
                                                //       ),
                                                //       shape:
                                                //           const CircleBorder(),
                                                //       onPressed: () {},
                                                //     ),
                                                //     const Text(
                                                //       'View Photo',
                                                //       style: TextStyle(
                                                //         fontSize: 18.0,
                                                //         color: Colors.black,
                                                //         fontWeight:
                                                //             FontWeight.bold,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                // const SizedBox(
                                                //   height: 8,
                                                // ),
                                                const Divider(
                                                  height: 8,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    RawMaterialButton(
                                                        fillColor: Colors
                                                            .grey.shade200,
                                                        child: Image.asset(
                                                          'assets/icons/takePhoto.png',
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        shape:
                                                            const CircleBorder(),
                                                        onPressed: () {}),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        // ! Camera profile

                                                        // ! upload image from galery
                                                        var image =
                                                            await patinetPersonalController
                                                                .pickImageCamera(
                                                                    context);

                                                        if (image != null) {
                                                          patinetPersonalController
                                                              .uploadProfileImage(
                                                                  image, ref)
                                                              .then((value) =>
                                                                  apiCall());
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Take Photo',
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        fillColor: Colors.grey.shade50,
                        child: const Icon(
                          Icons.camera,
                          color: Colors.blue,
                        ),
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 48,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'Poppins Bold',
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontSize: 11.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200.0,
                              width: 500,
                              child: Card(
                                elevation: 8.0,
                                margin: const EdgeInsets.all(20),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: TextFormField(
                                            initialValue: name,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              hintText: '',
                                              labelText: 'Name',
                                              labelStyle: TextStyle(
                                                color: Color(0xFF14B4ff),
                                              ),
                                            ),
                                            // onSaved: (String? value) {
                                            //   setState(() {
                                            //     name = value!;
                                            //   });
                                            // },
                                            onChanged: (String value) {
                                              setState(() {
                                                uname = value;
                                                // name = value;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                medicalupdateName(uname);
                                                setState(() {
                                                  name = uname;
                                                });
                                                Navigator.pop(context, false);
                                              },
                                              child: const Text(
                                                'Save',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.cyanAccent,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                  child: InkWell(
                    child: Container(
                      height: 48.0,
                      width: 115.0,
                      decoration: BoxDecoration(
                          color: personalcolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: personalbordercolor,
                            width: 2,
                          )),
                      child: Center(
                        child: Text(
                          "Personal",
                          style: TextStyle(
                              color: personaltextcolor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: (() {
                      setState(() {
                        personalcolor = const Color(0xFF14B2ff);
                        personaltextcolor = Colors.white;
                        personalbordercolor = const Color(0xFF14B2ff);
                        lifestylecolor = Colors.white;
                        lifestyletextcolor = const Color(0xFF14B2ff);
                        lifestylebordercolor = const Color(0xFF14B2ff);
                        medicalcolor = Colors.white;
                        medicaltextcolor = const Color(0xFF14B2ff);
                        medicalbordercolor = const Color(0xFF14B2ff);
                        screen = "1";
                      });
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                  child: InkWell(
                    child: Container(
                      height: 48.0,
                      width: 115.0,
                      decoration: BoxDecoration(
                          color: lifestylecolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: lifestylebordercolor,
                            width: 2,
                          )),
                      child: Center(
                        child: Text(
                          "Lifestyle",
                          style: TextStyle(
                              color: lifestyletextcolor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: (() {
                      setState(() {
                        personalcolor = Colors.white;
                        personaltextcolor = const Color(0xFF14B2ff);
                        personalbordercolor = const Color(0xFF14B2ff);
                        lifestylecolor = const Color(0xFF14B2ff);
                        lifestyletextcolor = Colors.white;
                        lifestylebordercolor = const Color(0xFF14B2ff);
                        medicalcolor = Colors.white;
                        medicaltextcolor = const Color(0xFF14B2ff);
                        medicalbordercolor = const Color(0xFF14B2ff);
                        screen = "2";
                      });
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                  child: InkWell(
                    child: Container(
                      height: 48.0,
                      width: 115.0,
                      decoration: BoxDecoration(
                          color: medicalcolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: medicalbordercolor,
                            width: 2,
                          )),
                      child: Center(
                        child: Text(
                          "Medical",
                          style: TextStyle(
                              color: medicaltextcolor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: (() {
                      setState(() {
                        personalcolor = Colors.white;
                        personaltextcolor = const Color(0xFF14B2ff);
                        personalbordercolor = const Color(0xFF14B2ff);
                        lifestylecolor = Colors.white;
                        lifestyletextcolor = const Color(0xFF14B2ff);
                        lifestylebordercolor = const Color(0xFF14B2ff);
                        medicalcolor = const Color(0xFF14B2ff);
                        medicaltextcolor = Colors.white;
                        medicalbordercolor = const Color(0xFF14B2ff);
                        screen = "3";
                      });
                    }),
                  ),
                ),
              ],
            ),
          ),
          (screen == "1")
              ? personalscreen()
              : (screen == "3")
                  ? medicalscreen()
                  : lifestylescreen(),
        ],
      ),
    );
  }

  Widget personalscreen() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              // height: 450.0,
              child: Card(
                elevation: 8.0,
                margin: const EdgeInsets.only(
                    left: 5, right: 5, top: 10, bottom: 10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.1), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/phone.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  'Phone',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  phone,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: phone.startsWith('Enter')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Number(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                          height: 16,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.1)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/email.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                "Email".text.color(Colors.grey).size(14).make(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // email.text
                                //     .size(14)
                                //     .color(
                                //       email.startsWith('Enter')
                                //           ? Colors.grey
                                //           : Colors.black,
                                //     )
                                //     .xs
                                //     .make(),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    // email.isNotEmpty
                                    //     ? email.substring(0, 15) + "..."
                                    //     : "",
                                    email,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: email.startsWith('Enter')
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Email(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                          height: 16,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.1)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/gender.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  'Gender',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    gender,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: gender.startsWith('Enter')
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Gender(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                          height: 16,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.1)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/calender.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  'DOB',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  dateOfBirth,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: dateOfBirth.startsWith('Enter')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Birthday(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                          height: 16,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.1)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/blood.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  'Blood Group',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  bloodGroup,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: bloodGroup.startsWith('Enter')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const BloodGroup(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                          height: 16,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.1)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/height.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  'Height',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  height,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: height.startsWith('Enter')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Height(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                          height: 16,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.1)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/weight.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  'Weight',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  weightCheck,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: weightCheck.startsWith('Enter')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Weight(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                          height: 16,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.1)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Image.asset(
                                  "assets/icons/location.webp",
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  'Location',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  location,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: location.startsWith('Enter')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Location(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget lifestylescreen() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.1), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/gender.webp",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Smoking Habits',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                lifestylesmokingHabit,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: lifestylesmokingHabit
                                            .startsWith('Tell us')
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const SmokingHabits(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/calender.webp",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Alcohol Consumption',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                lifestylealcoholConsumption,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: lifestylealcoholConsumption
                                            .startsWith('Tell us')
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const AlcoholConsumption(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/blood.webp",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Food Preference',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                lifestylefoodPreference,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: lifestylefoodPreference
                                            .startsWith('Tell us')
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const FoodPreference(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/height.webp",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Activity Level',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                lifestyleactivityLevel,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: lifestyleactivityLevel
                                            .startsWith('Tell us')
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ActivityLevel(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/weight.webp",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Occupation',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                lifestyleoccupation,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: lifestyleoccupation
                                            .startsWith('Tell us')
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Profession(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/location.webp",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Marital Status',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                lifestylemaritalStatus,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: lifestylemaritalStatus
                                            .startsWith('Enter your')
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const MaritalStatus(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget medicalscreen() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 8.0,
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.1), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/circle.png",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Allergies',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                child: Text(
                                  medicalallergies,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: medicalallergies
                                                  .startsWith('Enter') ||
                                              medicalallergies
                                                  .startsWith('None')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
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
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/circle.png",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Chronic Diseases',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                child: Text(
                                  medicalchronicDiseases,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: medicalchronicDiseases
                                                  .startsWith('Enter') ||
                                              medicalchronicDiseases
                                                  .startsWith('None')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ChronicDiseases(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/circle.png",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Injuries',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                child: Text(
                                  medicalinjuries,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: medicalinjuries
                                                  .startsWith('Enter') ||
                                              medicalinjuries.startsWith('None')
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Injuries(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Divider(
                        height: 16,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              Image.asset(
                                "assets/icons/circle.png",
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              const Text(
                                'Surgeries',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                child: Text(
                                  medicalsurgeries,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: (medicalsurgeries
                                                  .startsWith('Enter') ||
                                              medicalsurgeries
                                                  .startsWith('None'))
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Surgeries(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
