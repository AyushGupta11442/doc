import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../MyDoctor/MyDoctor.dart';

class PageSubmit extends StatelessWidget {
  const PageSubmit({Key? key}) : super(key: key);

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
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.only(top: 20),
                    height: 140,
                    child: Image.asset(
                      "assets/icons/cloud-upload.webp",
                      scale: 0.8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Container(
                        child: Column(children: const [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your story has been submitted successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff14B2FF),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins Bold'),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your Story is under moderation. We will notify you once moderation is complete.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff14DFFF),
                            fontFamily: 'Poppins Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ])),
                  ),
                  const SizedBox(height: 280),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 40,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                 MyDoctor(),
                          ),
                          (route)=>route.isFirst
                        );
                        
                      },
                      color: const Color(0xff14B2FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                            fontFamily: 'Poppins SemiBold',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
