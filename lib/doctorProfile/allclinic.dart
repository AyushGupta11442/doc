import 'package:flutter/material.dart';

class Allclinic extends StatelessWidget {
  const Allclinic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  MyHome({Key? key}) : super(key: key);
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14DFFF),
        title: const Text('All Clinic'),

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
                    child: Row(

                      children: const <Widget>[
                       Icon(Icons.mark_unread_chat_alt_outlined, color: Colors.white,),
                        SizedBox(width: 10),
                        Text(
                            'All Clinic',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),


                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 200.0,
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
                              BorderRadius.circular(50.0), //or 15.0
                              child: Container(
                                height: 90.0,
                                width: 90.0,
                                color: const Color(0x00b2e2fc),
                                child: Image.asset(
                                  'assets/logo.png',
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
                                  'Appolo Gleneagles Hospital',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
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
                                          left: 0.0, right: 24.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text(
                                            '58, Circular road,Kolkata-700007 ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 13.5,
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
                                    Text(
                                      'Consultation Fee :',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'Rs 500',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0,left: 2.0),
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
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14.0),

                                          )
                                      ),
                                    backgroundColor: MaterialStateProperty.all(const Color(0xff14b2ff)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                    child: Text("View Clinic Profile"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
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

                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14.0),

                                        )
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all(const Color(0xff14b2ff)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                    child: Text("Contact Clinic"),
                                  ),
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
                height: 200.0,
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
                              BorderRadius.circular(50.0), //or 15.0
                              child: Container(
                                height: 90.0,
                                width: 90.0,
                                color: const Color(0x00b2e2fc),
                                child: Image.asset(
                                  'assets/logo.png',
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
                                  'Surakha Poly Clinic',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
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
                                          left: 0.0, right: 24.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text(
                                            '58, E.M.Bypass,Kolkata-700009 ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 13.5,
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
                                    Text(
                                      'Consultation Fee :',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'Rs 500',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0,left: 2.0),
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
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14.0),

                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all(const Color(0xff14b2ff)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                    child: Text("View Clinic Profile"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
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

                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14.0),

                                        )
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all(const Color(0xff14b2ff)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                    child: Text("Contact Clinic"),
                                  ),
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
                height: 200.0,
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
                              BorderRadius.circular(50.0), //or 15.0
                              child: Container(
                                height: 90.0,
                                width: 90.0,
                                color: const Color(0x00b2e2fc),
                                child: Image.asset(
                                  'assets/logo.png',
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
                                  'Nidaan Poly Clinic',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
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
                                          left: 0.0, right: 24.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text(
                                            '18b, Park Shreet,Kolkata-700012 ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 13.5,
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
                                    Text(
                                      'Consultation Fee :',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'Rs 500',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0,left: 2.0),
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
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14.0),

                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all(const Color(0xff14b2ff)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                    child: Text("View Clinic Profile"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
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

                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14.0),

                                        )
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all(const Color(0xff14b2ff)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                    child: Text("Contact Clinic"),
                                  ),
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

              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       primary: const Color(0xff14b2ff),
              //       minimumSize: const Size.fromHeight(40),
              //     ),
              //     onPressed: () {},
              //     child: const Text(
              //       "Share your Story",
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
