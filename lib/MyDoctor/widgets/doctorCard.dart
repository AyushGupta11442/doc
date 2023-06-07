import 'package:doctor/MyDoctor/models/DoctorClass.dart';
import 'package:doctor/doctorReview/doctorReview.dart';
import 'package:flutter/material.dart';

import '../../doctorProfile/DoctorProfile.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({Key? key, required this.doctor}) : super(key: key);
  final Doctor doctor;
  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  String speciality = '';

  @override
  Widget build(BuildContext context) {
    if (widget.doctor.speciality != null) {
      for (Speciality s in widget.doctor.speciality!) {
        speciality += '${s.name}/ ';
      }
    } else {
      speciality = 'No speciality to show';
    }
    return Container(
      child: SizedBox(
        height: 125.0,
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black.withOpacity(0.4),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Container(
                          height: 70.0,
                          width: 70.0,
                          color: const Color(0x00b2e2fc),
                          child: image(widget.doctor.imageFile,
                            'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.doctor.imageFile}')),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.doctor.name.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  speciality,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                 Text(
                                  widget.doctor.clinicDetails![0].name!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30,
                          width: 78,
                          margin: const EdgeInsets.only(left: 4, top: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DoctorProfile(
                                          id: widget.doctor.id!,
                                         screen: "1",
                                          ),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff14Dfff)),
                            ),
                            child: const Text("Book"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4, top: 8),
                          height: 30,
                          width: 78,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DoctorReview(
                                          doctor: widget.doctor,
                                          doctor_image: widget.doctor.imageFile,
                                            doctor_id: widget.doctor.id!,
                                            doctorname: widget.doctor.name!, speciality: speciality,)),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff14Dfff)),
                            ),
                            child: const Text("Review"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget image(String? image, String imageURL) {
    if (image != null) {
      return Container(
          width: 90,
          height: 100,
          margin: const EdgeInsets.only(left: 8, top: 2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                    imageURL,
                  ),

                  fit: BoxFit.fill)));
    } else {
      return Container(
        width: 90,
        height: 100,
        margin: const EdgeInsets.only(left: 8, top: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          image: const DecorationImage(
              image: AssetImage('assets/images/docto.png'), fit: BoxFit.fill),
        ),
      );
    }
  }
}
