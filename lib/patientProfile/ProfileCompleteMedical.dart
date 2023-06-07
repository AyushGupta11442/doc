import 'package:doctor/patientProfile/patientpersonal/view/patientPersonal.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

import '../client/DioClientToken/DioClient_Token.dart';

//ignore: must_be_immutable
class ProfileCompleteMedical extends StatefulWidget {
  const ProfileCompleteMedical({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteMedical> createState() => _ProfileCompleteMedicalState();
}

class _ProfileCompleteMedicalState extends State<ProfileCompleteMedical> {
  late Map mapResponse;
  late int medicalDetailsFilled;
  late int medicalDetailsTotalQuestions;
  late double medicalDetailsFraction = 0.0;
  late double medicalDetailsPercentage = 0.0;

  Future apiCall() async {
    final response = await DioClinetToken.instance.dio!
        .get('https://api.doctrro.com/api/customer_profile/completed');

    mapResponse = response.data;
    setState(() {
      medicalDetailsFilled = mapResponse['data']['medical_details_filled'];
      medicalDetailsTotalQuestions =
          mapResponse['data']['medical_details_total_questions'];
      medicalDetailsFraction =
          medicalDetailsFilled / medicalDetailsTotalQuestions;
      medicalDetailsPercentage = medicalDetailsFraction * 100;
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
              percent: medicalDetailsFraction,
              center: Text(
                (medicalDetailsFraction * 100).round().toString() + '%',
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
                      'Your profile is ${medicalDetailsPercentage.round()}% completed.',
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
                    margin: const EdgeInsets.only(left: 60),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Congratulation! Your profile is completed.',
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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
                        builder: (context) => const PatientPersonal(
                              screen: '1',
                            )),
                            (route) => route.isFirst,
                  );
                },
                color: const Color(0xff14B2FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Go to Profile",
                  style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
