import 'package:doctor/doctorReview/successfully.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDocument extends StatefulWidget {
  const SelectDocument({Key? key}) : super(key: key);

  @override
  State<SelectDocument> createState() => _SelectDocumentState();
}

class _SelectDocumentState extends State<SelectDocument> {
  String date = "";
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 500,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/book.webp'),
                          fit: BoxFit.cover))),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select a type of document',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins Bold',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: OutlinedButton.icon(
                        label: const Text(
                          'Bill',
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: Image.asset(
                          "assets/icons/bill.webp",
                          scale: 0.8,
                        ),
                        style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: const Color(0xff14DFFF),
                            padding: const EdgeInsets.all(8)),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            primary: const Color(0xff14DFFF),
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xff14DFFF),
                            ),
                            padding: const EdgeInsets.all(8)),
                        label: const Text(
                          'Prescription',
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: Image.asset(
                          "assets/icons/prescription.webp",
                          scale: 0.8,
                        ),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            primary: const Color(0xff14DFFF),
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xff14DFFF),
                            ),
                            padding: const EdgeInsets.all(8)),
                        label: const Text(
                          'Report',
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: Image.asset(
                          "assets/icons/report.webp",
                          scale: 0.8,
                        ),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select your appointment date',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins Bold',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide:
                          BorderSide(color: Color(0xff14DFFF), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide:
                          BorderSide(color: Color(0xff14DFFF), width: 2),
                    ),
                    hintText: 'Select date',
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Color(0xff14DFFF),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  controller: _textEditingController,
                  onTap: () {
                    _selectDate(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomTableCalendar()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 40, right: 40, top: 20, bottom: 20),
                alignment: Alignment.center,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SuccessPage(),
                      ),
                    );
                  },
                  color: const Color(0xff14DFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
            ..selection = TextSelection.fromPosition(TextPosition(
                offset: _textEditingController.text.length,
                affinity: TextAffinity.upstream));
        },
      );
    }
  }
}
