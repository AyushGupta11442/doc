import 'package:doctor/doctorReview/selectdocument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../MyDoctor/MyDoctor.dart';

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.only(top: 10),
                    height: 200,
                    child: Image.asset(
                      "assets/icons/page.webp",
                      scale: 0.7,
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                        Text(
                          'We want to validate your story',
                          style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff14B2FF),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Poppins Bold'),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'We wish to make sure each patient story is genuine.\nHelp us with your appointment prescription or bill\nto verify that you visited this doctor.',
                          style: TextStyle(
                            color: Color(0xff14DFFF),
                            fontFamily: 'Poppins Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Note: This proof will not be published on Doctrro.',
                          style: TextStyle(
                            color: Color(0xff14DFFF),
                            fontFamily: 'Poppins Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ])),
                ),
                const SizedBox(height: 180),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 40,
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32, top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                    'Upload a Proof',
                                    style: TextStyle(
                                      color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Poppins Bold'),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey.shade100,
                                          child: const Icon(
                                            Icons.folder_open_rounded,
                                            color: Color(0xFF14Dfff),
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Text(
                                          'Upload files',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins Regular',
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey.shade100,
                                          child: const Icon(
                                            Icons.photo,
                                            color: Color(0xFF14Dfff),
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Text(
                                          'Upload from gallery',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins Regular',
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey.shade100,
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Color(0xFF14Dfff),
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Text(
                                          'Take Photo',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins Regular',
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    color: const Color(0xff14B2FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    child: const Text(
                      "Upload a Proof",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
                // Container(
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                //     child: MaterialButton(
                //       minWidth: double.infinity,
                //       height: 40,
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (BuildContext context) =>
                //                 const SelectDocument(),
                //           ),
                //         );
                //       },
                //       color: const Color(0xff14B2FF),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10)),
                //       child: const Text(
                //         "Upload a proof",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w800,
                //             fontSize: 16),
                //       ),
                //     ),
                //   ),
                // ),
                TextButton(
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontFamily: 'Poppins Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff2cd7ee),
                    ),
                  ),
                  onPressed: () {
                     Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const MyDoctor(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
