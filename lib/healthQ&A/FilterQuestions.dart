import 'package:doctor/healthQ&A/PatientQuestions.dart';
import 'package:flutter/material.dart';
import 'package:doctor/healthQ&A/AskQuestion.dart';
// import 'package:doctor/sharedData/sharedData.dart';
import 'package:doctor/sharedData/classes.dart';
import 'package:doctor/healthQ&A/Questions.dart';

final problemController = TextEditingController();

class FilterQuestions extends StatefulWidget {
  const FilterQuestions({Key? key}) : super(key: key);

  @override
  State<FilterQuestions> createState() => _FilterQuestionsState();
}

class _FilterQuestionsState extends State<FilterQuestions> {
  String specialAbout = "2"; //TODO: Given the first id of specialization!
  int selector = 0;
  String searchTerm = "";

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
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const SizedBox(
                  width: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 45.0,
                    width: 260.0,
                    child: TextField(
                      controller: problemController,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        // focusedBorder: InputBorder.none,
                        // enabledBorder: InputBorder.none,
                        // errorBorder: InputBorder.none,
                        // disabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[250],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                        hintText: 'Search by problem or symptom',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        searchTerm = problemController.text;
                        selector = 1;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          color: const Color(0xFF14DFFF),
                          child: const Icon(Icons.search,
                              size: 32.0, color: Colors.white)),
                    )),
                const SizedBox(
                  width: 16.0,
                ),
              ],
            ),
            SizedBox(
              height: 75,
              width: 380,
              child: Card(
                color: const Color(0xFF14DFFF),
                elevation: 4.0,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black.withOpacity(0),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FutureBuilder(
                      future: getSP(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null ||
                            snapshot.data.length == 0) {
                          return Container(
                            child: const Center(
                              child: Text("No Items to choose from"),
                            ),
                          );
                        }
                        List<DropdownMenuItem<String>> arr =
                            <DropdownMenuItem<String>>[];
                        for (sp x in snapshot.data) {
                          arr.add(DropdownMenuItem<String>(
                            value: x.id.toString(),
                            child: Text(x.data, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
                          ));
                        }
                        return DropdownButton<String>(
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16.0,
                            color: Colors.white,
                          ),
                          value: specialAbout,
                          isExpanded: true,
                          items: arr,
                          onChanged: (String? str) {
                            if (str != null) {
                              setState(() {
                                specialAbout = str;
                                selector = -1;
                              });
                            }
                          },
                        );
                      })
                  ,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    height: 48.0,
                    width: 175.0,
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
                            'Read Health Q&A',
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PatientQuestions()));
                    },
                    child: const SizedBox(
                      height: 48.0,
                      width: 175.0,
                      child: Card(
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
                                  color: Color(0xFF14B2ff)),
                            ),
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
            ),
            Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.black.withOpacity(0.4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: FutureBuilder(
                  future: (selector == 0)
                      ? getQuestions()
                      : ((selector == 1)
                          ? searchQuestion(searchTerm)
                          : getQuestionsID(specialAbout)),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null || snapshot.data.length == 0) {
                      return Container(
                        child: const Center(
                          child: Text("No Questions Found", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ),
                      );
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
                              //width: 500,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 45),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black45),
                                          borderRadius:
                                              const BorderRadius.all(
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
                                            (snapshot.data[i].title.length >=
                                                    30)
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
                                                (snapshot.data[i].body
                                                            .length >=
                                                        30)
                                                    ? snapshot.data[i].body
                                                            .substring(
                                                                0, 30) +
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: arr,
                        ));
                  },
                ),
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
