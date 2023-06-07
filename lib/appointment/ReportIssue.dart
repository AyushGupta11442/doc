import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ReportIssue extends StatelessWidget {
  const ReportIssue({Key? key}) : super(key: key);

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
        //centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Report Issue',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        width: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please let us know what went wrong',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins Bold'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 455.0,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Location of center is incorrect',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            constraints:
                                BoxConstraints.tight(const Size(20, 20)),
                            fillColor: const Color(0xFF14Dfff),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14Dfff),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.circle_sharp,
                              size: 16.0,
                              color: Color(0xFF14Dfff),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'I had to wait for long time',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            constraints:
                                BoxConstraints.tight(const Size(20, 20)),
                            fillColor: const Color(0xFF14Dfff),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14Dfff),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.circle_rounded,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Consultation fees mentioned in Doctrro is incorrect',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            constraints:
                                BoxConstraints.tight(const Size(20, 20)),
                            fillColor: const Color(0xFF14Dfff),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14Dfff),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.circle_rounded,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Clinic was closed',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            constraints:
                                BoxConstraints.tight(const Size(20, 20)),
                            fillColor: const Color(0xFF14Dfff),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14Dfff),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.circle_rounded,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Clinic is permanently closed',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            constraints:
                                BoxConstraints.tight(const Size(20, 20)),
                            fillColor: const Color(0xFF14Dfff),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14Dfff),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.circle_rounded,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Doctor does not practice at the center anymore',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            constraints:
                                BoxConstraints.tight(const Size(20, 20)),
                            fillColor: const Color(0xFF14Dfff),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14Dfff),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.circle_rounded,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Doctor is not avaliable',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            constraints:
                                BoxConstraints.tight(const Size(20, 20)),
                            fillColor: const Color(0xFF14Dfff),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF14Dfff),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.circle_rounded,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Others',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
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
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff14b2ff)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 4.0, bottom: 4.0, left: 16, right: 16),
                                child: Text("Contact Us"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),


            SizedBox(height: 180),



            Padding(
              padding: const EdgeInsets.only(right: 10.0,left: 10.0),
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
                        backgroundColor: MaterialStateProperty.all(const Color(0xffFF0000)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text("Submit Report"),
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
