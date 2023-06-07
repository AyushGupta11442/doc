import 'package:doctor/doctorProfile/doctorprofile.dart';

import 'package:flutter/material.dart';

class DoctorPatientReview extends StatefulWidget {
  const DoctorPatientReview({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<DoctorPatientReview> createState() => _DoctorPatientReviewState();
}

class _DoctorPatientReviewState extends State<DoctorPatientReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14DFFF),
        title: const Text('Doctor Profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
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
                                    fontSize: 18.0,
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
                                              fontSize: 13.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.thumb_up_sharp,
                                      size: 16.0,
                                      color: Color(0xFF14ffb8),
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      '100%',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'Experience : 10 Yrs',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DoctorProfile(id: widget.id,),
                        ),
                      );
                    },
                    child: const SizedBox(
                      height: 60.0,
                      width: 130.0,
                      child: Card(
                        elevation: 4.0,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF1484ff), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Appointment',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF1484ff)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         DoctorAbout(  id: widget.id,
                      //     ),
                      //   ),
                      // );
                    },
                    child: const SizedBox(
                      height: 60.0,
                      width: 130.0,
                      child: Card(
                        elevation: 4.0,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF1484ff), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'About',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF1484ff)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60.0,
                    width: 130.0,
                    child: Card(
                      elevation: 4.0,
                      color: Color(0xFF1484ff),
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF1484ff), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Reviews',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
