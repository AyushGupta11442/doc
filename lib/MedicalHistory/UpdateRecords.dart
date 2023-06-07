import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import 'MedicalInformation.dart';
import 'package:doctor/main.dart';
import '../provider/shared_pref_helper.dart';
import '../sharedData/file_uploader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'MedicalInformation.dart';

Future<String> func() async {
  String? uname = SharedPreferencesHelper.getUserName();
  return uname!.toString();
}

class ImageFile {
  late String filename;
  late int id;
  ImageFile(String x, int y) {
    filename = x;
    id = y;
  }
}

Future<List<ImageFile>> getRecordData(int id) async {
  var data = await http.get(
      Uri.parse('https://api.doctrro.com/api/medical_record/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken'
      });
  dynamic res = jsonDecode(data.body);
  res = res['data']['medical_record_files'];
  List<ImageFile> arr = [];
  for (dynamic r in res) {
    arr.add(ImageFile(r['file_name'], r['id']));
  }
  return arr;
}

class UpdateRecord extends StatefulWidget {
  String? pName = '';
  int id = 0;
  late String initialTitle, initialType, recordfor;
  UpdateRecord(
      {Key? key,
      required this.initialType,
      required this.initialTitle,
      required this.id,
      required this.recordfor})
      : super(key: key);

  @override
  State<UpdateRecord> createState() => _UpdateRecord();
}

class _UpdateRecord extends State<UpdateRecord> {
  List<File> F = [];
  String date = "";
  String initialTitle = '';
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();

  String recordType = 'Prescription';

  @override
  void initState() {
    super.initState();
    recordType = widget.initialType;
    initialTitle = widget.initialTitle;
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
            'Update Medical Record',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
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
                    FutureBuilder(
                        future: getRecordData(widget.id),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                                margin: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/icons/page_Green.webp",
                                  scale: 0.7,
                                ));
                          }
                          return SizedBox(
                              height: 200,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    for (ImageFile img in snapshot.data)
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0.0),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Container(
                                                  height: 150.0,
                                                  width: 150.0,
                                                  color:
                                                      const Color(0x00b2e2fc),
                                                  child: FittedBox(
                                                    child: Image.network(
                                                        'https://api.doctrro.com/assets/uploads/medical_records/${img.filename}'),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: InkWell(
                                                    onTap: () {
                                                      EasyLoading.showInfo(
                                                          "Deleting file. Please don't press back button");
                                                      deleteFile(img.id)
                                                          .then((res) {
                                                        if (res) {
                                                          EasyLoading.showSuccess(
                                                              'File deleted successfully');
                                                        } else {
                                                          EasyLoading.showError(
                                                              "File couldn't be deleted");
                                                        }
                                                        setState(() {});
                                                      }).catchError((Object e,
                                                              StackTrace
                                                                  stackTrace) {
                                                        print(e.toString());
                                                        EasyLoading.showError(
                                                            "There was some Error");
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: ClipOval(
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          child: const Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              color:
                                                                  Colors.red)),
                                                    ),
                                                  ))
                                            ],
                                          )),
                                  ])));
                        }),
                    updateImages(
                        fileList: F,
                        updateFileListFunc: (File x) {
                          F.add(x);
                        },
                        deleteFileListIndex: (int index) {
                          F.removeAt(index);
                        })
                  ],
                )),
            SizedBox(
              height: 328.0,
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
                                    _textEditingController2.text = initialTitle;
                                    openDialog(context, (String x) {
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
                                      return const Text(
                                        'Loading',
                                        style: TextStyle(
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
                  // String currentDate = selectedDate.year.toString() +
                  //     '-' +
                  //     selectedDate.month.toString() +
                  //     '-' +
                  //     selectedDate.day.toString();
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
                  updateRecord(F, widget.pName!, initialTitle, recordType,
                          currentDate, widget.id)
                      .then((response) {
                    print("response.body $currentDate");
                    if (response.statusCode == 200) {
                      EasyLoading.showSuccess("Record Updated");
                      // Navigator.of(context).maybePop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MedicalInformation()),
                        (route) => route.isFirst,
                      );
                    } else {
                      EasyLoading.showError("Record not updated");
                      Navigator.of(context).maybePop();
                    }
                  });
                },
                color: const Color(0xff14B2FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: const Text(
                  "Update Record",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
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

class updateImages extends StatefulWidget {
  late List<File> fileList;
  late Function(File) updateFileListFunc;
  late Function(int) deleteFileListIndex;
  updateImages({
    Key? key,
    required this.fileList,
    required this.updateFileListFunc,
    required this.deleteFileListIndex,
  }) : super(key: key);
  @override
  State<updateImages> createState() => _updateImagesState();
}

class _updateImagesState extends State<updateImages> {
  @override
  Widget build(BuildContext context) => Row(children: [
        for (int i = 0; i < widget.fileList.length; i++)
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: const Color(0x00b2e2fc),
                      child: FittedBox(
                        child: Image.file(widget.fileList[i]),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.deleteFileListIndex(i);
                          });
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
                        //widget.fileList.add(x);
                        widget.updateFileListFunc(x);
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
            ))
      ]);
}
