import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

import '../client/DioClientToken/DioClient_Token.dart';
import 'SmokingHabits.dart';

//ignore: must_be_immutable
class ProfileCompletePersonal extends StatefulWidget {
  const ProfileCompletePersonal({Key? key}) : super(key: key);

  @override
  State<ProfileCompletePersonal> createState() =>
      _ProfileCompletePersonalState();
}

class _ProfileCompletePersonalState extends State<ProfileCompletePersonal> {
  bool isLoading = false;
  late Map mapResponse;
  late int personalDetailsFilled;
  late int personalDetailsTotalQuestions;
  late double personalDetailsFraction = 0;
  late double personalDetailsPercentage = 0;

  Future apiCall() async {
    setState(() {
      isLoading = true;
    });
    final response = await DioClinetToken.instance.dio!
        .get('https://api.doctrro.com/api/customer_profile/completed');
    // http.Response response;
    // response = await http.get(
    //   Uri.parse("https://api.doctrro.com/api/profile/completed"),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer ${SharedPreferencesHelper.getAuthToken()}',
    //   },
    // );

    mapResponse = response.data;
    setState(() {
      personalDetailsFilled = mapResponse['data']['personal_details_filled'];
      personalDetailsTotalQuestions =
          mapResponse['data']['personal_details_total_questions'];
      personalDetailsFraction =
          personalDetailsFilled / personalDetailsTotalQuestions;
      personalDetailsPercentage = personalDetailsFraction * 100;
      isLoading = false;
    });
    print(personalDetailsFilled);
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
            // isLoading
            //     ? Container(
            //         margin: const EdgeInsets.only(top: 40),
            //         child: const Center(
            //           child: CircularProgressIndicator(
            //             color: Colors.blue,
            //           ),
            //         ),
            //       )
            // :
            Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            CircularPercentIndicator(
              radius: 75.0,
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              percent: personalDetailsFraction,
              center: Text(
                personalDetailsPercentage.round().toString() + '%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Color(0xFF14B2ff),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: const Color(0xFF14ffB8),
              progressColor: const Color(0xFF14B2ff),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Your profile is ${personalDetailsPercentage.round()}% completed.',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins Bold'),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lets go to your lifestyle profile.\n',
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Lifestyle profile will help us give you better\nhealth suggestions',
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 180),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 45,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SmokingHabits()),
                    (route) => route.isFirst,
                  );
                },
                color: const Color(0xff14B2FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Let's go to your Lifestyle",
                  style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ),
            TextButton(
              child: const Text(
                "Do it later",
                style: TextStyle(
                  fontFamily: 'Poppins Bold',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const PatientPersonal(
                      screen: '1',
                    ),
                  ),
                  (route) => route.isFirst,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
