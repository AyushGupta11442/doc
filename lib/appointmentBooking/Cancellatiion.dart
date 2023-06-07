import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Cancellation extends StatelessWidget {
  const Cancellation({Key? key}) : super(key: key);

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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Appointment Cancelation',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150.0,
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
                            borderRadius: BorderRadius.circular(10.0),
                            //or 15.0
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
                                        // Text(
                                        //   'Experience : 10 Years',
                                        //   textAlign: TextAlign.start,
                                        //   style: TextStyle(
                                        //     fontSize: 10.0,
                                        //     color: Colors.black,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: const <Widget>[
                                  //     Text(
                                  //       'MBBS, MD',
                                  //       textAlign: TextAlign.start,
                                  //       style: TextStyle(
                                  //         fontSize: 10.0,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       'MBBS, MD',
                                  //       textAlign: TextAlign.start,
                                  //       style: TextStyle(
                                  //         fontSize: 10.0,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                              // const SizedBox(
                              //   height: 8.0,
                              // ),
                              // Row(
                              //   children: const <Widget>[
                              //     Icon(
                              //       Icons.thumb_up_sharp,
                              //       size: 16.0,
                              //       color: Color(0xFF14ffb8),
                              //     ),
                              //     SizedBox(
                              //       width: 4.0,
                              //     ),
                              //     Text(
                              //       '100%',
                              //       textAlign: TextAlign.start,
                              //       style: TextStyle(
                              //         fontSize: 12.0,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ],
                              // )
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
              height: 83.0,
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
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180.0,
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
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 0.8,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: const <Widget>[
                              Text(
                                'Appointment for',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Sumit Rotake',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: const <Widget>[
                              Text(
                                'Appointment ID',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '25052105',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
            SizedBox(
              height: 293.0,
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
                          'Reason for Cancelling:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        height: 16,
                        thickness: 0.8,
                        color: Colors.black,
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
                                  color: Colors.blue, style: BorderStyle.solid),
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
                              'Doctor ask me to cancel',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.4,
                        color: Colors.black,
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
                                  color: Colors.blue, style: BorderStyle.solid),
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
                              'Clinic is so far',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.4,
                        color: Colors.black,
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
                                  color: Colors.blue, style: BorderStyle.solid),
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
                              'I am busy',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.4,
                        color: Colors.black,
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
                                  color: Colors.blue, style: BorderStyle.solid),
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
                              'Visitor another doctor',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
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
                onPressed: () {},
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
