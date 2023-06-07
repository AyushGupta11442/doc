import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'Filter.dart';

class GeneralHealth extends StatelessWidget {
  const GeneralHealth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  MyHome({Key? key}) : super(key: key);

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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         const PastAppointments(),
                    //   ),
                    // );
                  },
                  child: const SizedBox(
                    height: 48.0,
                    width: 160.0,
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
            const SizedBox(
              height: 12,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 45.0,
                    width: 280.0,
                    child: TextField(
                      decoration: InputDecoration(
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
                const SizedBox(
                  width: 12.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      color: const Color(0xFF14DFFF),
                      child: const Icon(Icons.search,
                          size: 32.0, color: Colors.white)),
                ),
                const SizedBox(
                  width: 16.0,
                ),
              ],
            ),
            SizedBox(
              height: 80,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Filter your questions',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const Filter(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60))),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 16.0,
                            color: Color(0xFF14DFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 565.0,
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
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 45),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Sugar level is high with kidney problems',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'CKD patient with creatine 2.0. Regular taking insulin\nshots(Lipusillin R) 3 times with baselog but...',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '30 minutes ago  |  15 views',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 45),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Sugar level is high with kidney problems',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'CKD patient with creatine 2.0. Regular taking insulin\nshots(Lipusillin R) 3 times with baselog but...',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '30 minutes ago  |  15 views',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 45),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Sugar level is high with kidney problems',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'CKD patient with creatine 2.0. Regular taking insulin\nshots(Lipusillin R) 3 times with baselog but...',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '30 minutes ago  |  15 views',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 45),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Sugar level is high with kidney problems',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'CKD patient with creatine 2.0. Regular taking insulin\nshots(Lipusillin R) 3 times with baselog but...',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '30 minutes ago  |  15 views',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 45),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Sugar level is high with kidney problems',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'CKD patient with creatine 2.0. Regular taking insulin\nshots(Lipusillin R) 3 times with baselog but...',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '30 minutes ago  |  15 views',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
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
          height: 40,
          onPressed: () {},
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
