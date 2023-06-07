import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

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
          'Select Information',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: const <Widget>[
                          SizedBox(
                            width: 16.0,
                          ),
                          Icon(Icons.face),
                          // Image.asset(
                          //   "assets/icons/gender.webp",
                          // ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            'Relation',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Personal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(Icons.email),
                            SizedBox(
                              width: 16.0,
                            ),
                            Text(
                              'Email',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'saurav.ch@gmail.com',
                              style: TextStyle(fontSize: 14),
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
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/gender.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Gender',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Male',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 16.0,
                          ),
                          Image.asset(
                            "assets/icons/calender.webp",
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          const Text(
                            'DOB',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            '1992-06-16',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            color: Color(0xffffdd7f),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 16.0,
                          ),
                          Image.asset(
                            "assets/icons/blood.webp",
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          const Text(
                            'Blood Group',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'O+',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            color: Color(0xffffdd7f),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 16.0,
                          ),
                          Image.asset(
                            "assets/icons/height.webp",
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          const Text(
                            'Height',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            '5 ft 6 in',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            color: Color(0xffffdd7f),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 16.0,
                          ),
                          Image.asset(
                            "assets/icons/weight.webp",
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          const Text(
                            'Weight',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            '70 kgs',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            color: Color(0xffffdd7f),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 16.0,
                          ),
                          Image.asset(
                            "assets/icons/calender.webp",
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          const Text(
                            'Location',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Jadavpur, Kolkata,WB',
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            color: Color(0xffffdd7f),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Lifestyle',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/gender.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Text(
                              'Smoking ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'I don\'t smoke',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // todo heter
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/calender.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Alcohol ',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Regular',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/blood.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Food ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Non-vegetarian',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
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
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Moderately Active',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
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
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'IT Professional',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/calender.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Martial Status',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Single',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Medical',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/gender.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Allergies',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Eggs, Cats',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/calender.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Chronic Diseases',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Diabetes',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/blood.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Injuries',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Burns',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.05), width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 16.0,
                            ),
                            Image.asset(
                              "assets/icons/height.webp",
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'Surgeries',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Kidney',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Color(0xffffdd7f),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => const InformationQuestions(),
            //   ),
            // );
          },
          color: const Color(0xff14B2FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: const Text(
            'Save',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
