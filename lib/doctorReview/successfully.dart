import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "assets/icons/double tick.webp",
                      scale: 0.7,
                    )),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                        Text(
                          'Your story has been uploaded',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff14B2FF),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins Bold'),
                        ),
                        Text(
                          'successfully',
                          style: TextStyle(
                            color: Color(0xff14B2FF),
                            fontFamily: 'Poppins Bold',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ])),
                ),
                const SizedBox(height: 200),
                Container(
                    margin: const EdgeInsets.only(top: 100, bottom: 32),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        onPressed: () {},
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
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
