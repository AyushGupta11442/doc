import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/appointment/UpcomingAppointments.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:doctor/view/Settings/view/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../MedicalHistory/MedicalInformation.dart';
import '../../../MyDoctor/MyDoctor.dart';
import '../../../controller/AuthController.dart';
import '../../../core/constants.dart';
import '../../../healthQ&A/AskQuestion.dart';
import '../../../healthQ&A/FilterQuestions.dart';
import '../../../patientProfile/patientpersonal/controller/patientpersonal_controller.dart';
import '../../../patientProfile/patientpersonal/view/patientPersonal.dart';

Widget endDrwawer(BuildContext context, WidgetRef ref) {
  final patientProfilePersonalData =
      ref.watch(getPatientPersonalProfileProvider);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
       
        Column(
          children: <Widget>[
            const SizedBox(
              height: 32.0,
            ),
            patientProfilePersonalData.when(
              data: (data) {
                return Card(
                  color: const Color(0xFF14DFFF),
                  elevation: 7.0,
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0), //or 15.0
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircleAvatar(
                            radius:30,
                            backgroundColor: Colors.black,
                            backgroundImage: CachedNetworkImageProvider(
                              data.data!.data!.profile!.imageFile.isNotEmpty
                                  ? 'https://api.doctrro.com/assets/uploads/customer/profile_pictures/${SharedPreferencesHelper.getUserImage()}'
                                  : dumyProfilePic,
                              //   // data!.data.profile.imageFile,
                             
                            ),
                          ),
                        ),
                        // : Image.network(
                        //     dumyProfilePic,
                        //     // width: 300,
                        //     // height: 150,
                        //     fit: BoxFit.fill,
                        //   ),
                      ),

                      // child:

                      const SizedBox(
                        width: 12.0,
                      ),
                      data.error == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                   SharedPreferencesHelper.getUserName()!.isNotEmptyAndNotNull? SharedPreferencesHelper.getUserName()!  : data.data!.data!.profile!.name ,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins Bold',
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  SharedPreferencesHelper.getUserMail().toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins SemiBold',
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  SharedPreferencesHelper.getUserPhone().toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins SemiBold',
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
              error: ((error, stackTrace) => Center(
                    child: Text(error.toString()),
                  )),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            //! card
          ],
        ),
        const SizedBox(height: 2),
        const Align(
          alignment: Alignment.centerLeft,
            child: Text(
          '     Dashboard',
          style: TextStyle(
            fontFamily: 'Poppins SemiBold',
            fontSize: 12.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )),
        const Divider(thickness: 1,color: Color.fromARGB(255, 105, 101, 101),),
        ListTile(
          leading: const Icon(
            Icons.face,
            color: Colors.lightBlueAccent,
            size: 24.0,
          ),
          title: const Text(
            "My Profile",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientPersonal(
                          screen: '1',
                        )));
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "My Appointment",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpcomingAppointments()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.local_hospital,
            color: Colors.lightBlueAccent,
            size: 24.0,
          ),
          title: const Text(
            "My Doctor",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyDoctor()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.receipt_outlined,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "My Medical Records",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MedicalInformation()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.question_answer_rounded,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "Health Q & A",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            // Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FilterQuestions()));
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.health_and_safety,
        //       color: Colors.lightBlueAccent, size: 24.0),
        //   title: const Text(
        //     "Health Articles",
        //     style: TextStyle(
        //       fontFamily: 'Poppins SemiBold',
        //       fontSize: 12.0,
        //       color: Colors.black,
        //     ),
        //   ),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const ArticleHomePage()));
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.question_mark_outlined,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "Ask Question to Doctor",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AskQuestion()));
          },
        ),
        const SizedBox(height: 2),
        const Align(
          alignment: Alignment.centerLeft,
            child: Text(
          '     About doctrro',
          style: TextStyle(
            fontFamily: 'Poppins SemiBold',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        )),
        const Divider(
          thickness: 1,
          color: Color.fromARGB(255, 105, 101, 101),
        ),
        ListTile(
          leading: const Icon(Icons.assignment_late_rounded,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "About Doctrro",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () async {
            const Urlstring = 'https://doctrro.com/#intro';
            if (await canLaunchUrl(Uri.parse(Urlstring))) {
              await launchUrlString(Urlstring);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.contacts_outlined,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "Contact us & Help",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
           onTap: () async {
            const Urlstring = 'https://doctrro.com/#contact';
            if (await canLaunchUrl(Uri.parse(Urlstring))) {
              await launchUrlString(Urlstring);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () async {
            const Urlstring = 'https://doctrro.com/privacy-policy/';
            if (await canLaunchUrl(Uri.parse(Urlstring))) {
              await launchUrlString(Urlstring);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.share_arrival_time_sharp,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "Share with friends & family",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings,
              color: Colors.lightBlueAccent, size: 24.0),
          title: const Text(
            "Setting",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MySettings()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.lightBlueAccent,
            size: 24.0,
          ),
          title: const Text(
            "Logout",
            style: TextStyle(
              fontFamily: 'Poppins SemiBold',
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          onTap: () async {
            await AuthController().logout(context);
            await DefaultCacheManager()
                .emptyCache()
                .then((value) => print("Cache cleared"));
            // String? token = SharedPreferencesHelper.getAuthToken();
            // if (token.isEmpty) {
            //   context.go('/login');
            //   // Navigator.pushReplacement(
            //   //   context,
            //   //   MaterialPageRoute(
            //   //     builder: (context) => LoginPage(),
            //   //   ),
            //   // );
            // }
          },
        ),
      ],
    ),
  );
}
