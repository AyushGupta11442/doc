import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'makepayment.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        home: MyHome());
  }
}

//ignore: must_be_immutable
class MyHome extends StatelessWidget {
  MyHome({Key? key}) : super(key: key);
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFF14DFFF),
        title: Row(
          children: <Widget>[
            Text(
              'Book In Clinic Appointment',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 8.0,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 151.0,
                child: Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black.withOpacity(0.4),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10.0), //or 15.0
                              child: Container(
                                height: 90.0,
                                width: 90.0,
                                color: const Color(0x00b2e2fc),
                                child: Image.network(
                                  'https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-profiles/avatar-1.webp',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 18.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Dr. Subhidita Chatterjee',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 19.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, right: 32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text(
                                            'Gynaecologist / Obstetrician',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 96.0,
                width: 380,
                child: Card(
                  color: const Color(0xFF14DFFF),
                  elevation: 4.0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black.withOpacity(0),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: const <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Apollo Gleneagles Hospital',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '58 Canal Circular Road, On E.M. Bypass Road',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 240.0,
                child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.4), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '25 May',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Sunday, 09:00AM',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.8,
                          color: Colors.black,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'This in-clinic appointment is for:',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {},
                              constraints:
                                  BoxConstraints.tight(const Size(16, 16)),
                              fillColor: Colors.white,
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid),
                              ),
                              child: const Icon(
                                Icons.circle_rounded,
                                size: 16.0,
                                color: Color(0xff1484FF),
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Milan Sasmal',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {},
                              constraints:
                                  BoxConstraints.tight(const Size(16, 16)),
                              fillColor: Colors.white,
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid),
                              ),
                              child: const Icon(
                                Icons.circle,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Someone Else',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 215.0,
                child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.4), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Provide the following information about',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Milan Sasmal',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.perm_contact_cal_outlined,
                                size: 24.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Milan Sasmal',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.call,
                                size: 24.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '9564213886',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.mail,
                                size: 24.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'milansasmal8@gmail.com',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70.0,
                width: 380,
                child: Card(
                  color: const Color(0xFF14DFFF),
                  elevation: 4.0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black.withOpacity(0),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Consultation Fees',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rs. 500',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150.0,
                child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.4), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: <Widget>[
                              RawMaterialButton(
                                onPressed: () {},
                                constraints:
                                    BoxConstraints.tight(const Size(16, 16)),
                                fillColor: Colors.white,
                                shape: const CircleBorder(
                                  side: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid),
                                ),
                                child: const Icon(
                                  Icons.circle_rounded,
                                  size: 16.0,
                                  color: Color(0xff1484FF),
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Rs. 500 Pay Online',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: <Widget>[
                              RawMaterialButton(
                                onPressed: () {},
                                constraints:
                                    BoxConstraints.tight(const Size(16, 16)),
                                fillColor: Colors.white,
                                shape: const CircleBorder(
                                  side: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid),
                                ),
                                child: const Icon(
                                  Icons.circle,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Rs. 500 Pay Later at Clinic',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'NOTE :',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  '1. Free cancellation and rescheduling is available till 2 hours before the appointment time. ',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  '2. After the stipulated time, rescheduling will not be available, and a fees of 50 INR will be applicable for cancellation or no-shows.',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text:
                            "3. By booking this appointment you agree to the ",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      TextSpan(
                          text: "T & C",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      const TextSpan(
                        text: ".",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "4. You can read our payment ",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      TextSpan(
                          text: "FAQs",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      const TextSpan(
                        text: ".",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff14b2ff),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Payment(),
                      ),
                    );
                  },
                  child: const Text(
                    "Confirm & Pay",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
