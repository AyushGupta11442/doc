import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

import '../client/DioClientToken/DioClient_Token.dart';
import 'Allergies.dart';

//ignore: must_be_immutable
class ProfileCompleteLifestyle extends StatefulWidget {
  const ProfileCompleteLifestyle({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteLifestyle> createState() =>
      _ProfileCompleteLifestyleState();
}

class _ProfileCompleteLifestyleState extends State<ProfileCompleteLifestyle> {
  late Map mapResponse;
  late int lifestyleDetailsFilled;
  late int lifestyleDetailsTotalQuestions;
  late double lifestyleDetailsFraction = 0.0;
  late double lifestyleDetailsPercentage = 0.0;

  Future apiCall() async {
    final response = await DioClinetToken.instance.dio!
        .get('https://api.doctrro.com/api/customer_profile/completed');
    mapResponse = response.data;
    setState(() {
      lifestyleDetailsFilled = mapResponse['data']['lifestyle_details_filled'];
      lifestyleDetailsTotalQuestions =
          mapResponse['data']['lifestyle_details_total_questions'];
      lifestyleDetailsFraction =
          lifestyleDetailsFilled / lifestyleDetailsTotalQuestions;
      lifestyleDetailsPercentage = lifestyleDetailsFraction * 100;
    });
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
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            CircularPercentIndicator(
              radius: 75.0,
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              percent: lifestyleDetailsFraction,
              center: Text(
                (lifestyleDetailsFraction * 100).round().toString() +
                    '%',
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
                      'Your profile is ${lifestyleDetailsPercentage.round()}% completed.',
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
                        'Lets go to your medical profile.\n',
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
                        'Your Medical profile will help us give you better\nhealth suggestions',
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
                      builder: (BuildContext context) => const Allergies(),
                    ),
                    (route) => route.isFirst,
                  );
                },
                color: const Color(0xff14B2FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Let's go to your Medical",
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
                      screen: '2',
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
