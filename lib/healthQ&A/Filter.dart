import 'package:doctor/healthQ&A/FilterQuestions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Filter extends StatelessWidget {
  const Filter({Key? key}) : super(key: key);

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
          'Select Filter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Heart (Cardiologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Dental Care (Dentist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Skin, Hair & Nails (Dermatologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Diabetes (Endocrinologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Digestive Issues (Gastroenterologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Kidney (Nepherologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Mental Health (Psychiatrist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Cancer (Oncologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Lungs & Breathing (Pulmonologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Urinary Issues (Urologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Brain & Nerve (Neurologist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Bones & Joints (Orthopedist)',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black54),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/nephrology.png',
                                scale: 0.8,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Ear, Nose & Throat (ENT) Specialist',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          constraints: BoxConstraints.tight(const Size(20, 20)),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => FilterQuestions(),
              ),
            );
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
