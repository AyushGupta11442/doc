import 'package:flutter/material.dart';

class MedicalList extends StatelessWidget {
  const MedicalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
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
        iconTheme: const IconThemeData(color: Color(0xFF1484ff), size: 24.0),
        backgroundColor: Colors.white,
        title: const Text(
          'LOGO',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24.0),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 12.0,
              ),
              const Icon(
                Icons.location_on,
                size: 32.0,
                color: Color(0xFF14ffb8),
              ),
              const Text(
                'Telco \nTata 831004',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 36.0,
                  width: 180.0,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[250],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Container(
                    color: const Color(0xFF14DFFF),
                    child: const Icon(Icons.search,
                        size: 32.0, color: Colors.white)),
              ),
              const SizedBox(
                width: 8.0,
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 32.0,
                ),
                Card(
                  color: const Color(0xFF14DFFF),
                  elevation: 7.0,
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0), //or 15.0
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          color: const Color(0x00b2e2fc),
                          child: Image.network(
                            'https://mdbcdn.b-cdn.net/img/new/avatars/5.webp',
                            width: 300,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Saurav Chatterjee',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Poppins Bold',
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Saurav.ch@gmail.com',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Poppins SemiBold',
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '+91 9567336336',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Poppins SemiBold',
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 2),
            Center(
                child: Text(
              'Dashboard',
              style: TextStyle(
                fontFamily: 'Poppins SemiBold',
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            )),
            ListTile(
              leading: Icon(
                Icons.face,
                color: Colors.lightBlueAccent,
                size: 24.0,
              ),
              title: Text(
                "My Profile",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "My Appointment",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.local_hospital,
                color: Colors.lightBlueAccent,
                size: 24.0,
              ),
              title: Text(
                "My Doctor",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_outlined,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "My Medical Records",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer_rounded,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "Health Q & A",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.health_and_safety,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "Health Articles",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark_outlined,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "Ask Question to Doctor",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 2),
            Center(
                child: Text(
              'About doctrro',
              style: TextStyle(
                fontFamily: 'Poppins SemiBold',
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            )),
            ListTile(
              leading: Icon(Icons.assignment_late_rounded,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "About Doctrro",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts_outlined,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "Contact us & Help",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.share_arrival_time_sharp,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "Share with friends & family",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Colors.lightBlueAccent, size: 24.0),
              title: Text(
                "Setting",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.login,
                color: Colors.lightBlueAccent,
                size: 24.0,
              ),
              title: Text(
                "Log in",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
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
                height: 215.0,
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
                                height: 105.0,
                                width: 90.0,
                                color: const Color(0x00b2e2fc),
                                child: Image.asset(
                                  'assets/images/Building.png',
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
                                Row(
                                  children: const [
                                    Text(
                                      'AMRI Medical Store',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Text(
                                      'Open',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                const Text(
                                  'Aliphatic Pharmacy',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                const Text(
                                  'BB-99, VIP Park, Kestopur',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                const Text(
                                  'Kolkata-700101',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Divider(
                          height: 2,
                          thickness: 0.6,
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFF14ffb8),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Rating',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '5 out of 5',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.home,
                                color: Color(0xFF14DFFF),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Clinics',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.shopping_bag_sharp,
                                color: Color(0xFF1484FF),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Doctor',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
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
                                height: 105.0,
                                width: 90.0,
                                color: const Color(0x00b2e2fc),
                                child: Image.asset(
                                  'assets/images/Building.png',
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
                                Row(
                                  children: const [
                                    Text(
                                      'AMRI Medical Store',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Text(
                                      'Open',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                const Text(
                                  'Aliphatic Pharmacy',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                const Text(
                                  'BB-99, VIP Park, Kestopur',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                const Text(
                                  'Kolkata-700101',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Divider(
                          height: 2,
                          thickness: 0.6,
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFF14ffb8),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Rating',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '5 out of 5',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.home,
                                color: Color(0xFF14DFFF),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Clinics',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.shopping_bag_sharp,
                                color: Color(0xFF1484FF),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Doctor',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
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
                                height: 105.0,
                                width: 90.0,
                                color: const Color(0x00b2e2fc),
                                child: Image.asset(
                                  'assets/images/Building.png',
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
                                Row(
                                  children: const [
                                    Text(
                                      'AMRI Medical Store',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Text(
                                      'Close',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                const Text(
                                  'Aliphatic Pharmacy',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                const Text(
                                  'BB-99, VIP Park, Kestopur',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                const Text(
                                  'Kolkata-700101',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Divider(
                          height: 2,
                          thickness: 0.6,
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFF14ffb8),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Rating',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '5 out of 5',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.home,
                                color: Color(0xFF14DFFF),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Clinics',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.shopping_bag_sharp,
                                color: Color(0xFF1484FF),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Doctor',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
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
      ),
    );
  }
}
