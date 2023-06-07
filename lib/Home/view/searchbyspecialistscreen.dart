import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/Home/view/modals/searchbysoctorspeciality.dart';
import 'package:doctor/Home/view/notification.dart';
import 'package:doctor/Home/view/searchbydoctornamescreen.dart';
import 'package:doctor/Home/view/widgets/end_Drawer.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/doctorProfile/doctorProfile.dart';
import 'package:doctor/widget/CircleProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../patientProfile/patientpersonal/controller/patientpersonal_controller.dart';

class Searchbyspecialist extends ConsumerStatefulWidget {
  const Searchbyspecialist({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchbyspecialistState();
}

class _SearchbyspecialistState extends ConsumerState<Searchbyspecialist> {
  bool male = true;
  bool female = true;
  late double year_of_experience;
  late double fee;
  int? statuscode;

  String name = '';
  void getfilter(bool male, bool female, double yearOfExperience, double fee) {
    setState(() {
      male = male;
      female = female;
      yearOfExperience = yearOfExperience;
      fee = fee;
    });
    print(male.toString());
    print("male");
    print(female.toString());
    print(yearOfExperience);
    // doctorList = [];
    getDoctors();
  }

  late searchdoctorby_speciality doctorListss;
  bool isload = false;
  bool islistEmpty = false;

  void getDoctors() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .get('/doctor_speciality_search/${widget.id}');

      var data = jsonDecode(response.toString());
      if (response.statusCode == 200) {
        setState(() {
          doctorListss = searchdoctorby_speciality.fromJson(data);
          isload = true;
          print(isload);
        });
      } else {
        setState(() {
          islistEmpty = true;
          isload = false;
        });
      }
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        // handle timeout error
        VxToast.show(
          context,
          msg: 'Connection Timeout',
          bgColor: Vx.black,
          textColor: Vx.white,
          showTime: 5000,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else if (e.response?.statusCode != null) {
        await EasyLoading.showError(
            e.response!.data['data']['errors'].toString());

        // String er = '';
        // for (String e in otpRes.data!.errors!) {
        //   if (e == 'OTP does not match.') {
        //     await EasyLoading.showSuccess("Enter Otp correctly");
        //     setState(() {});
        //   }else
        //   {
        //     er += er + e;
        //   }
        // }
        // if(er != ''){
        //   await EasyLoading.showError(er);
        // }
      } else if (e.type == DioErrorType.response) {
        await EasyLoading.showError(
            e.response!.data['data']['errors'][0].toString());
      } else {
        VxToast.show(
          context,
          msg: 'Something Went Wrong! Try Again',
          bgColor: Vx.black,
          textColor: Vx.white,
          showTime: 5000,
        );
      }
    }
  }

  @override
  void initState() {
    getDoctors();
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 15, top: 8.0, bottom: 8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 21.5,
                        width: MediaQuery.of(context).size.width / 1.41,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[250],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                            hintText: 'Search...',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Searchbyspecialistname(
                                    name: name,
                                  )),
                          (route) => route.isFirst,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                            color: const Color(0xFF14B2FF),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: const Icon(Icons.search,
                                  size: 24.0, color: Colors.white),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     margin: const EdgeInsets.only(left: 340),
                //     child: Row(
                //       children: <Widget>[
                //         Padding(
                //           padding: const EdgeInsets.only(top: 10, bottom: 10),
                //           child: GestureDetector(
                //             onTap: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (BuildContext context) => filter(
                //                             addvalue: getfilter,
                //                           )));
                //             },
                //             child: const Icon(
                //               Icons.notifications_active,
                //               size: 20.0,
                //               color: Color(0xFF14B2FF),
                //             ),
                //           ),
                //         ),
                //         const Text("filters",
                //             style: TextStyle(color: Color(0xFF14B2FF))),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        body: (isload)
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (Doctors d in doctorListss.data!.doctors!)
                      doctordetail(
                        d,
                      ),
                  ],
                ),
              )
            : (isload)
                ? circularProgressIndicator()
                : const Center(child: Text("No doctor to show")));
  }

  Widget doctordetail(Doctors d) {
    String speciality = '';
    for (Specialities s in d.specialities!) {
      speciality += '${s.name}/ ';
    }
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
          padding: const EdgeInsets.all(12.0),
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
                          'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${d.imageFile}'),
                    ),
                  ),
                  const SizedBox(
                    width: 18.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        d.name!,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          speciality,
                          overflow: TextOverflow.ellipsis,
                          // maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Poppins SemiBold',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        (d.experience == null)
                            ? 'Experience : null years'
                            : 'Experience : ${d.experience} years',
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
                            d.recommend.toString(),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.clinic!.name!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          d.clinic!.address!,
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
                        'Rs. ${d.clinic!.fees!}',
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
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Next Slot Available',
                    style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 13.0, right: 16.0, top: 8, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.home,
                          size: 20.0,
                          color: Color(0xFF14ffb8),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          '${(d.nextSlot?.time == null) ? 'Unknown' : d.nextSlot!.time}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Poppins SemiBold',
                            fontSize: 12.0,
                            color: Color(0xFF14ffb8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     const Icon(
                    //       Icons.video_call_rounded,
                    //       size: 22.0,
                    //       color: Color(0xFF14ffb8),
                    //     ),
                    //     const SizedBox(
                    //       width: 4.0,
                    //     ),
                    //     Text(
                    //       '${d.nextSlot!.time!}, ${d.nextSlot!.time!}',
                    //       overflow: TextOverflow.ellipsis,
                    //       textAlign: TextAlign.start,
                    //       style: const TextStyle(
                    //         fontFamily: 'Poppins SemiBold',
                    //         fontSize: 12.0,
                    //         color: Color(0xFF14ffb8),
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DoctorProfile(id: d.id!)));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF1484ff)),
                        ),
                        child: const Text('Veiw profile',
                            style: TextStyle(fontSize: 12)
                            // "Book Appointment"
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DoctorProfile(id: d.id!, screen: "1")));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff14b2ff)),
                        ),
                        child: const Text('Book Appointment',
                            style: TextStyle(fontSize: 12)
                            // "Video Consult"
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showdialogbox() {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
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
