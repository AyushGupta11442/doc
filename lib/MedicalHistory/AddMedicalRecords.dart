import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/gestures.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:flutter/material.dart';
import '../sharedData/file_uploader.dart';
import 'MedicalRecords.dart';

class AddMedicalRecords extends StatefulWidget {
  const AddMedicalRecords({Key? key}) : super(key: key);

  @override
  State<AddMedicalRecords> createState() => _AddMedicalRecordsState();
}

class _AddMedicalRecordsState extends State<AddMedicalRecords> {
  List<File> pFiles = [];

  String recordType = 'Prescription';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          backgroundColor: const Color(0xFF14Dfff),
          title: const Text(
            'My Medical Records',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: (pFiles.isEmpty)
            ? emptyAddRecord(
                updateImageList: (File x) {
                  setState(() {
                    pFiles.add(x);
                  });
                },
              )
            : MedicalRecords(
                F: pFiles,
                initialTitle: 'Records added by me',
                emptyList: () {
                  setState(() {
                    pFiles.clear();
                  });
                },
              ));
  }
}

class emptyAddRecord extends StatelessWidget {
  final void Function(File) updateImageList;
  const emptyAddRecord({Key? key, required this.updateImageList})
      : super(key: key);
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
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
                      "assets/icons/page_Green.webp",
                      scale: 0.7,
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Add a medical record',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Poppins Bold'),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'A detailed history helps a doctor diagnose',
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'you better',
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
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
                          return medicalRecordButton(
                            updateImageList: updateImageList,
                          );
                        },
                      );
                    },
                    color: const Color(0xff14B2FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    child: const Text(
                      "Add a medical record",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class medicalRecordButton extends StatelessWidget {
  final void Function(File) updateImageList;
  const medicalRecordButton({Key? key, required this.updateImageList})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Card(
        elevation: 8.0,
        margin: const EdgeInsets.only(left: 24, right: 24),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Add a medical record',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins Bold'),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
                  File image = await getImage(false);
                  Navigator.of(context).maybePop();
                  updateImageList(image);
                },
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
                        fontFamily: 'Poppins Regular',
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              // GestureDetector(
              //   onTap: () async {
              //     File image = await getImage(false);
              //     Navigator.of(context).maybePop();
              //     updateImageList(image);
              //   },
              //   child: Row(
              //     children: [
              //       CircleAvatar(
              //         backgroundColor: Colors.grey.shade100,
              //         child: const Icon(
              //           Icons.photo,
              //           color: Color(0xFF14Dfff),
              //           size: 30,
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 12,
              //       ),
              //       const Text(
              //         'Upload from gallery',
              //         style: TextStyle(
              //           fontFamily: 'Poppins Regular',
              //           fontSize: 17,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: () async {
                  File image = await getImage(true);
                  Navigator.of(context).maybePop();
                  updateImageList(image);
                },
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
}
