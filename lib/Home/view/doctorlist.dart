import 'dart:convert';

import 'package:doctor/Home/view/modals/top_doctor_list_modal.dart';
import 'package:doctor/Home/view/widgets/end_Drawer.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/doctorProfile/DoctorProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../patientProfile/patientpersonal/controller/patientpersonal_controller.dart';
import '../../widget/CircleProgress.dart';
import 'notification.dart';

class DoctorList extends ConsumerStatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorListState();
}

class _DoctorListState extends ConsumerState<DoctorList> {
  bool isload = false;
  late top_doctors doctors_data;

  void getDoctor() async {
    final response = await DioClinetToken.instance.dio!.get('/top_doctor_list');
    var data = jsonDecode(response.toString());
    setState(() {
      doctors_data = top_doctors.fromJson(data);
      isload = true;
    });
  }

  @override
  void initState() {
    getDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final patientProfilePersonalData =
        ref.watch(getPatientPersonalProfileProvider);
    // final locationData = ref.watch(getLocationProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: endDrwawer(context, ref),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF1484ff), size: 40.0),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 28),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, top: 10, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Notification_page()));
                  },
                  child: const Icon(
                    Icons.notifications_active,
                    size: 26.0,
                  ),
                )),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 35, // Changing Drawer Icon Size
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(55.0),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: <Widget>[
          //           const SizedBox(
          //             width: 12.0,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(
          //                 right: 8.0, left: 15, top: 8.0, bottom: 8.0),
          //             child: SizedBox(
          //               height: MediaQuery.of(context).size.height / 21.5,
          //               width: MediaQuery.of(context).size.width / 1.41,
          //               child: TextField(
          //                 decoration: InputDecoration(
          //                   filled: true,
          //                   fillColor: Colors.grey[250],
          //                   border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(12.0),
          //                   ),
          //                   contentPadding:
          //                       const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
          //                   hintText: 'Search...',
          //                 ),
          //               ),
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 12.0,
          //           ),
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(8.0),
          //             child: Container(
          //                 color: const Color(0xFF14B2FF),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(6.0),
          //                   child: const Icon(Icons.search,
          //                       size: 24.0, color: Colors.white),
          //                 )),
          //           ),
          //           const SizedBox(
          //             width: 8.0,
          //           ),
          //         ],
          //       ),
          //       // Container(
          //       //   margin: const EdgeInsets.only(left: 340),
          //       //   child: Row(
          //       //     children: <Widget>[
          //       //       Padding(
          //       //         padding: const EdgeInsets.only(top: 10, bottom: 10),
          //       //         child: GestureDetector(
          //       //           onTap: () {},
          //       //           child: const Icon(
          //       //             Icons.notifications_active,
          //       //             size: 20.0,
          //       //             color: Color(0xFF14B2FF),
          //       //           ),
          //       //         ),
          //       //       ),
          //       //       const Text("filters",
          //       //           style: TextStyle(color: Color(0xFF14B2FF))),
          //       //     ],
          //       //   ),
          //       // ),
          //       // Container(
          //       //   margin: const EdgeInsets.only(left: 340),
          //       //   child: Row(
          //       //     children: <Widget>[
          //       //       Padding(
          //       //         padding: const EdgeInsets.only(top: 10, bottom: 10),
          //       //         child: GestureDetector(
          //       //           onTap: () {},
          //       //           child: const Icon(
          //       //             Icons.notifications_active,
          //       //             size: 20.0,
          //       //             color: Color(0xFF14B2FF),
          //       //           ),
          //       //         ),
          //       //       ),
          //       //       const Text("filters",
          //       //           style: TextStyle(color: Color(0xFF14B2FF))),
          //       //     ],
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
        ),
        body: (isload)
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (Doctors d in doctors_data.data!.doctors!)
                      doctordetail(d)
                  ],
                ),
              )
            : circularProgressIndicator());
  }

  Widget doctordetail(Doctors d) {
    String speciality = '';
    for (Specialities s in d.specialities!) {
      speciality += '${s.name!}/';
    }
    String? from =
        (d.nextSlot?.day != null) ? (d.nextSlot!.time!).split(' ')[0] : 'null';
    String? to =
        (d.nextSlot?.day != null) ? (d.nextSlot!.time!).split(' ')[2] : 'null';
    print(to);
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    //or 15.0
                    child: Container(
                        height: 90.0,
                        width: 90.0,
                        color: const Color(0x00b2e2fc),
                        child: image(d.imageFile,
                            'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${d.imageFile}')),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 200,

                        child: Text(
                          d.name!,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Poppins Bold',
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width:150,
                          child: Text(
                            (speciality == '')
                                ? 'No speciality to show'
                                : speciality,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'Poppins SemiBold',
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Experience : ${(d.experience == null) ? 'Not Given' : d.experience} Years',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Poppins SemiBold',
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.thumb_up_sharp,
                            size: 16.0,
                            color: Color(0xFF14ffb8),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            '${(d.recommend == null) ? 'Not Found' : (d.recommend)}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Divider(
                height: 0.0,
                thickness: 2.0,
                color: Colors.grey,
                indent: 8.0,
                endIndent: 8.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${(d.clinic?.name == null) ? 'No clinic' : d.clinic?.name}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${(d.clinic?.address == null) ? 'Address not given' : d.clinic?.address}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Poppins SemiBold',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${(d.consultationFee == null) ? 'Not mentioned' : 'Rs.' + d.consultationFee.toString()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontFamily: 'Poppins SemiBold',
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        'Consultation Fees',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins SemiBold',
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Next Slot Available',
              //       style: TextStyle(
              //         fontFamily: 'Poppins SemiBold',
              //         fontSize: 12.0,
              //         color: Colors.black,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Row(
              //         children: <Widget>[
              //           const Icon(
              //             Icons.home,
              //             size: 20.0,
              //             color: Color(0xFF14ffb8),
              //           ),
              //           const SizedBox(
              //             width: 4.0,
              //           ),
              //           Text(
              //             '$from, ${d.nextSlot?.day}',
              //             textAlign: TextAlign.start,
              //             style: const TextStyle(
              //               fontFamily: 'Poppins SemiBold',
              //               fontSize: 12.0,
              //               color: Color(0xFF14ffb8),
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: <Widget>[
              //           const Icon(
              //             Icons.video_call_rounded,
              //             size: 22.0,
              //             color: Color(0xFF14ffb8),
              //           ),
              //           const SizedBox(
              //             width: 4.0,
              //           ),
              //           Text(
              //             '$to, ${d.nextSlot?.day}',
              //             textAlign: TextAlign.start,
              //             style: const TextStyle(
              //               fontFamily: 'Poppins SemiBold',
              //               fontSize: 12.0,
              //               color: Color(0xFF14ffb8),
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         DoctorAppoint(doctor: d),
                          //   ),
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DoctorProfile(id: d.id!, screen: "1",),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF1484ff)),
                        ),
                        child: const Text("View Profile"),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10.0,
                    // ),
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all(
                    //           const Color(0xff14b2ff)),
                    //     ),
                    //     child: const Text("Video Consult"),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
              image: AssetImage('assets/images/docto.png'), fit: BoxFit.fill),
        ),
      );
    }
  }
}
