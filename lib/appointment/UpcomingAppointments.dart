import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/appointment/models/AppointmentClass.dart';
import 'package:doctor/appointment/widgets/AppointmentCard.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  var isLoaded = false;
  var screen = "up";
  List<Appointment> appointments = [];

  void getAppointments() async {
    try {
      final response =
          await DioClinetToken.instance.dio!.get('/upcoming_appointment');

      var _appointments = response.data['data']['appointment'];

      if (response.statusCode == 200) {
        for (var ap in _appointments) {
          Appointment a = Appointment(
              id: ap['id'],
              date: ap['date'],
              status: ap['status'],
              clinicDetailId: ap['clinic_detail_id'],
              doctorId: ap['doctor_id'],
              customerId: ap['customer_id'],
              appointmentFor: ap['appointment_for'],
              name: ap['name'],
              gender: ap['gender'],
              phoneNumber: ap['phone_number'],
              email: ap['email'],
              createdAt: ap['created_at'],
              updatedAt: ap['updated_at'],
              slotId: ap['slot_id'],
              report: ap['report'],
              slotTiming: ap['slot_timing'],
              type: ap['type'],
              doctor_name: ap['doctor']['name'],
              clinic_name: ap['clinic']['name'],
              doctor_image_file: ap['doctor']['image_file'],
              doctor_speciality: ap['doctor']['specialities'][0]['name']);

          appointments.add(a);
        }
        setState(() {
          isLoaded = true;
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

  Color upcommingcolor = const Color(0xFF14B2ff);
  Color upcommingtxtcolor = Colors.white;
  Color upcommingbordercolor = Colors.transparent;
  Color pastcolor = Colors.white;
  Color pasttxtcolor = const Color(0xFF14B2ff);
  Color pastbordercolor = const Color(0xFF14B2ff);

  List<Appointment> pastappointments = [];

  void getpastAppointments() async {
    try {
      final response =
          await DioClinetToken.instance.dio!.get('/previous_appointment');

      var _aappointments = response.data['data']['appointment'];

      if (response.statusCode == 200) {
        for (var ap in _aappointments) {
          Appointment p = Appointment(
              id: ap['id'],
              date: ap['date'],
              status: ap['status'],
              clinicDetailId: ap['clinic_detail_id'],
              doctorId: ap['doctor_id'],
              customerId: ap['customer_id'],
              appointmentFor: ap['appointment_for'],
              name: ap['name'],
              gender: ap['gender'],
              phoneNumber: ap['phone_number'],
              email: ap['email'],
              createdAt: ap['created_at'],
              updatedAt: ap['updated_at'],
              slotId: ap['slot_id'],
              report: ap['report'],
              slotTiming: ap['slot_timing'],
              type: ap['type'],
              doctor_name: ap['doctor']['name'],
              clinic_name: ap['clinic']['name'],
              doctor_image_file: ap['doctor']['image_file'],
              doctor_speciality: ap['doctor']['specialities'][0]['name']);

          pastappointments.add(p);
        }
        setState(() {
          isLoaded = true;
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
    getpastAppointments();
    getAppointments();
    super.initState();
  }

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
        title: PreferredSize(
          preferredSize: const Size.fromHeight(16.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.calendar_today, size: 24, color: Colors.white),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'My Appointments',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    height: 48.0,
                    width: 160.0,
                    decoration: BoxDecoration(
                        color: upcommingcolor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: upcommingbordercolor,
                          width: 2,
                        )),
                    child: Center(
                      child: Text(
                        "Upcoming",
                        style: TextStyle(
                            color: upcommingtxtcolor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: (() {
                    setState(() {
                      upcommingcolor = const Color(0xFF14B2ff);
                      upcommingtxtcolor = Colors.white;
                      upcommingbordercolor = Colors.transparent;
                      pastcolor = Colors.white;
                      pasttxtcolor = const Color(0xFF14B2ff);
                      pastbordercolor = const Color(0xFF14B2ff);
                      screen = "up";
                    });
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    height: 48.0,
                    width: 160.0,
                    decoration: BoxDecoration(
                        color: pastcolor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: pastbordercolor,
                          width: 2,
                        )),
                    child: Center(
                      child: Text(
                        "Past",
                        style: TextStyle(
                            color: pasttxtcolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      upcommingcolor = Colors.white;
                      upcommingtxtcolor = const Color(0xFF14B2ff);
                      upcommingbordercolor = const Color(0xFF14B2ff);
                      pastcolor = const Color(0xFF14B2ff);
                      pasttxtcolor = Colors.white;
                      pastbordercolor = const Color(0xFF14B2ff);
                      screen = "past";
                    });
                  },
                ),
              ),
            ]),
            (screen == "up") ? upcommingwidget() : pastwidget()
          ],
        ),
      ),
    );
  }

  Widget upcommingwidget() {
    return appointments.isEmpty
        ? const Text("You Don't Have Any Upcoming Appointments")
        : Column(
            children: [
              for (Appointment ap in appointments) ApmntCard(appointment: ap)
            ],
          );
  }

  Widget pastwidget() {
    return pastappointments.isEmpty
        ? const Text("You Don't Have Any Past Appointments")
        : Column(
            children: [
              for (Appointment ap in pastappointments)
                ApmntCard(appointment: ap)
            ],
          );
  }
}
