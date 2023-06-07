import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import 'MedicalInformation.dart';
import '../provider/shared_pref_helper.dart';
import '../sharedData/file_uploader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'MedicalInformation.dart';

Future<String> func() async {
  String? uname = SharedPreferencesHelper.getUserName();
  return uname!.toString();
}

class MedicalRecords extends StatefulWidget {
  late List<File> F;
  late void Function() emptyList;
  String? pName = '';
  late String initialTitle;
  String? record_for;
  MedicalRecords(
      {Key? key,
      required this.F,
      required this.emptyList,
      required this.initialTitle,
      this.record_for})
      : super(key: key);

  @override
  State<MedicalRecords> createState() => _MedicalRecords();
}

class _MedicalRecords extends State<MedicalRecords> {
  String date = "";
  String initialTitle = '';
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();

  String recordType = 'Prescription';

  @override
  void initState() {
    super.initState();
    initialTitle = widget.initialTitle;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 16,
                ),
                for (int i = 0; i < widget.F.length; i++)
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              color: const Color(0x00b2e2fc),
                              child: FittedBox(
                                child: Image.file(widget.F[i]),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {
                                  if (widget.F.length > 1) {
                                    setState(() {
                                      widget.F.removeAt(i);
                                    });
                                  } else {
                                    widget.F.removeAt(0);
                                    widget.emptyList();
                                  }
                                },
                                child: ClipOval(
                                  child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      color: Colors.black.withOpacity(0.4),
                                      child: const Icon(Icons.delete_outline,
                                          color: Colors.red)),
                                ),
                              ))
                        ],
                      )),
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return medicalRecordButton(
                            updateImageList: (File x) {
                              setState(() {
                                widget.F.add(x);
                              });
                            },
                          );
                        },
                      );
                    },
                    child: const SizedBox(
                      height: 95.0,
                      width: 95.0,
                      child: Card(
                        margin: EdgeInsets.all(1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF14Dfff), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF14Dfff),
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 328.0,
          child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Record Title (Event, symptoms, procedure, etc)',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                initialTitle,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF14Dfff),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                openDialog(context, (String x) {
                                  _textEditingController2.text = initialTitle;
                                  setState(() {
                                    initialTitle = x;
                                  });
                                }, _textEditingController2);
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 15,
                                color: Color(0xFF14Dfff),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    thickness: 0.6,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Record for',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: FutureBuilder(
                              future: func(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Text(
                                    '${widget.record_for}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF14Dfff),
                                    ),
                                  );
                                } else {
                                  widget.pName = snapshot.data;
                                  return Text(
                                    snapshot.data,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF14Dfff),
                                    ),
                                  );
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    thickness: 0.6,
                    color: Colors.black,
                  ),
                  _recordType(
                    typeRecord: recordType,
                    changeRecordType: (String r) {
                      recordType = r;
                    },
                  ),
                  const Divider(
                    height: 2,
                    thickness: 0.6,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Records created on',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedDate.day.toString() +
                                  '-' +
                                  selectedDate.month.toString() +
                                  '-' +
                                  selectedDate.year.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF14Dfff),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 15,
                                color: Color(0xFF14Dfff),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //const SizedBox(height: 210),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 40,
            onPressed: () {
              String MM = (selectedDate.month < 10)
                  ? '0${selectedDate.month.toString()}'
                  : selectedDate.month.toString();
              String DD = (selectedDate.day < 10)
                  ? '0${selectedDate.day.toString()}'
                  : selectedDate.day.toString();
              String currentDate =
                  selectedDate.year.toString() + '-' + MM + '-' + DD;
              //print(this.recordType);
              EasyLoading.showInfo(
                  "Uploading Record\nPlease don't press back button");
              ImageUpload(widget.F, widget.pName!, initialTitle, recordType,
                      currentDate)
                  .then((response) {
                if (response.statusCode == 201) {
                  EasyLoading.showSuccess("Record Uploaded");
                  // Navigator.of(context).maybePop();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedicalInformation()),
                    (route) => route.isFirst,
                  );
                } else {
                  EasyLoading.showError("Record not uploaded");
                  Navigator.of(context).maybePop();
                }
              });
            },
            color: const Color(0xff14B2FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: const Text(
              "Upload Records",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate) {
      setState(
        () {
          selectedDate = selected;
          _textEditingController
            ..text = DateFormat.yMMMd().format(selectedDate)
            ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: _textEditingController.text.length,
                  affinity: TextAffinity.upstream),
            );
        },
      );
    }
  }
}

class _recordType extends StatefulWidget {
  late String typeRecord;
  final Function(String) changeRecordType;
  _recordType(
      {Key? key, required this.typeRecord, required this.changeRecordType})
      : super(key: key);
  @override
  State<_recordType> createState() => _recordTypeState();
}

class _recordTypeState extends State<_recordType> {
  String typeRecord = '';

  @override
  void initState() {
    super.initState();
    typeRecord = widget.typeRecord;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Record type',
                style: TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.changeRecordType('Prescription');
                    setState(() {
                      typeRecord = 'Prescription';
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/prescription_Blue.png",
                        scale: 0.5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Prescription',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: (typeRecord == 'Prescription')
                                ? const Color(0xFF14Dfff)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                GestureDetector(
                  onTap: () {
                    widget.changeRecordType('Invoice');
                    setState(() {
                      typeRecord = 'Invoice';
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/invoice.png",
                        scale: 0.5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Invoice',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: (typeRecord == 'Invoice')
                                ? const Color(0xFF14Dfff)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.changeRecordType('Medical Report');
                      typeRecord = 'Medical Report';
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/medical.png",
                        scale: 0.5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Medical Report',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: (typeRecord == 'Medical Report')
                                ? const Color(0xFF14Dfff)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
                        fontFamily: 'Poppins Regular',
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
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

Future openDialog(
        BuildContext c, Function(String) editFunc, TextEditingController T) =>
    showDialog(
      context: c,
      builder: (c) => AlertDialog(
        title: const Text('Record Title'),
        content: TextField(
          controller: T,
          autofocus: true,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: '(Event, symptoms, procedure, etc)'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(c).maybePop();
                editFunc(T.text);
              },
              child: const Text('Submit'))
        ],
      ),
    );
