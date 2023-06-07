// delete this 


import 'package:doctor/appointmentBooking/appointmentConfirmation.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

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
          onPressed: () => () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const Confirmation(),
              ),
            );
          },
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Payment Section',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 72,
            width: 72,
            child: IconButton(
              icon: Image.asset(
                "assets/icons/wallet.webp",
              ),
              color: const Color(0xFF14Dfff),
              onPressed: () {},
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Amount to Pay INR 500',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF14Dfff),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200.withOpacity(0.75),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: const Offset(24, 24),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 270.0,
                child: Card(
                  // shadowColor: Colors.grey,
                  elevation: 16.0,
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
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select a Payment Method',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.8,
                          color: Colors.black,
                        ),
                        Row(
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {},
                              constraints:
                                  BoxConstraints.tight(const Size(16, 16)),
                              fillColor: Colors.white,
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid),
                              ),
                              child: const Icon(
                                Icons.circle_rounded,
                                size: 16.0,
                                color: Color(0xff1484FF),
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'UPI',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {},
                              constraints:
                                  BoxConstraints.tight(const Size(16, 16)),
                              fillColor: Colors.white,
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid),
                              ),
                              child: const Icon(
                                Icons.circle,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Debit/ Credit/ ATM Card',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {},
                              constraints:
                                  BoxConstraints.tight(const Size(16, 16)),
                              fillColor: Colors.white,
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid),
                              ),
                              child: const Icon(
                                Icons.circle,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Net Banking',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff14b2ff),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Pay",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
