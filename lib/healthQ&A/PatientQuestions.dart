import 'package:doctor/sharedData/classes.dart';
import 'package:flutter/material.dart';
import 'package:doctor/healthQ&A/Questions.dart';
import 'package:doctor/healthQ&A/AskQuestion.dart';
import 'package:doctor/main.dart';

class PatientQuestions extends StatelessWidget {
  PatientQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Health Q&A',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         const PastAppointments(),
                    //   ),
                    // );
                  },
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).maybePop();
                      },
                      child: const SizedBox(
                        height: 48.0,
                        width: 160.0,
                        child: Card(
                          margin: EdgeInsets.all(1),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Color(0xFF14B2ff), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Read Health Q&A',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF14B2ff)),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 48.0,
                  width: 160.0,
                  child: Card(
                    color: Color(0xFF14B2ff),
                    margin: EdgeInsets.all(1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF14B2ff), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your Questions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: FutureBuilder(
                future: getMyQuestions(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null || snapshot.data.length == 0) {
                    return Column(children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        padding: const EdgeInsets.only(top: 20),
                        height: 140,
                        child: Image.asset(
                          "assets/icons/answers.png",
                          scale: 0.4,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'You haven\'t asked any questions yet.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins Bold'),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Ask a question now.',
                          style: TextStyle(
                            fontFamily: 'Poppins Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ]);
                  }
                  List<Widget> arr = <Widget>[];
                  for (int i = 0; i < snapshot.data.length; i++) {
                    arr.add(GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Questions(
                              questionHeading: snapshot.data[i].title,
                              questionBody: snapshot.data[i].body,
                              createdDate: snapshot.data[i].createdDate,
                              id: snapshot.data[i].id,
                            );
                          }));
                        },
                        child: SizedBox(
                            width: 500,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 45),
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black45),
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (snapshot.data[i].title.length >= 30)
                                              ? snapshot.data[i].title
                                                      .substring(0, 30) +
                                                  "..."
                                              : snapshot.data[i].title,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                120,
                                            child: Text(
                                              (snapshot.data[i].body.length >=
                                                      30)
                                                  ? snapshot.data[i].body
                                                          .substring(0, 30) +
                                                      "..."
                                                  : snapshot.data[i].body,
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          snapshot.data[i].createdDate,
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )))));
                    if (i < snapshot.data.length - 1) {
                      arr.add(const SizedBox(
                        height: 12,
                      ));
                      arr.add(const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ));
                      arr.add(const SizedBox(
                        height: 12,
                      ));
                    }
                  }
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Card(
                          elevation: 8.0,
                          margin: const EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black.withOpacity(0.4), width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: arr,
                              ))));
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 50,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AskQuestion()));
          },
          color: const Color(0xff14B2FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: const Text(
            'Ask a question',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
