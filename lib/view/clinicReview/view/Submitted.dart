// The screen of the error page.
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/view/clinicReview/view/AllReviews.dart';
import 'package:flutter/material.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key, this.id, this.clinic}) : super(key: key);
  final int? id;
    final Clinices? clinic;


  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  /// The error to display.

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/icons/cloudicon.png"),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  'Your Experience Has Been Submitted Successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  'Your Story Is Under Moderation, We will notify you once the Moderation is complete.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size.fromHeight(
                  40), // fromHeight use double.infinity as width and 40 is the height
            ),
            onPressed: () {
               Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AllReviews(
                      id: widget.id!,
                      clinic: widget.clinic!,
                    
                    );
                  },
                ),
                (route) => route.isFirst,
              );
            },
            child: const Text('Done'),
          ),
        ),
      );
}
