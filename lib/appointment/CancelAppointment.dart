import 'package:flutter/material.dart';



class CancelAppointment extends StatefulWidget {
  const CancelAppointment({Key? key}) : super(key: key);

  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Appointment Details',
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
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
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
              height: 80.0,
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
              height: 80.0,
              width: 430,
              child: Card(
                color: Colors.red.withOpacity(0.1),
                elevation: 0.0,
                margin: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Appointment has been cancelled',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      Icon(
                        Icons.cancel_outlined,
                        size: 25.0,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180.0,
              width: 370.0,
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

            const SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //     const (),
                        //   ),
                        // );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff14b2ff)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text("Re-book Appointment",style: TextStyle(
                          fontSize: 13,
                        ),),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //       const (),
                        //     ),
                        //   );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff14b2ff)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text("Contact Us"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
