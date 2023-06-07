import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/appointment/UpcomingAppointments.dart';
import 'package:doctor/appointment/models/AppointmentClass.dart';
import 'package:doctor/appointmentBooking/models/dateClass.dart';
import 'package:doctor/appointmentBooking/models/slotClass.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentRescheduling extends StatefulWidget {
  const AppointmentRescheduling(
      {Key? key,
      required this.appointment,
      this.string1,
      this.string2,
      this.string3})
      : super(key: key);
  final Appointment? appointment;
  final String? string1;
  final String? string2;
  final String? string3;
  @override
  State<AppointmentRescheduling> createState() =>
      _AppointmentReschedulingState();
}

class _AppointmentReschedulingState extends State<AppointmentRescheduling> {
  bool value = false;

  List<slotClass> slots = [];
  slotClass? selectedSlot;
  dateClass? selectedDate;
  dateClass? today;
  dateClass? tomorrow;
  dateClass? dayAfterTomorrow;
  var reqDate;

  var slotId;

  dateClass convertdate(DateTime today) {
    var day = today.day.toString();
    var month = today.month.toString();
    var year = today.year.toString();

    List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    if (int.parse(month) < 10) {
      month = '0' + month;
    }
    if (int.parse(day) < 10) {
      day = '0' + day;
    }

    String date = day + "-" + month + "-" + year;

    dateClass d = dateClass(
        date: date,
        day: weekdays[today.weekday - 1],
        dateString: today.toString().substring(0, 10));

    return d;
  }

  void getDates() {
    setState(() {
      today = convertdate(DateTime.now());
      tomorrow = convertdate(DateTime.now().add(const Duration(hours: 24)));
      dayAfterTomorrow =
          convertdate(DateTime.now().add(const Duration(hours: 48)));

      reqDate = today!.date.toString();
      today_reqDate = today!.date.toString();
      print(today_reqDate);
      tomorrow_reqDate = tomorrow!.date.toString();
      next_reqDate = dayAfterTomorrow!.date.toString();
    });
  }

  void reshedule() async {
    try {
      print(selectedDate!.dateString);
      final response = await DioClinetToken.instance.dio!
          .put('/appointment_update/${widget.appointment!.id}/$slotId', data: {
        "date": selectedDate!.dateString,
      });

      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const UpcomingAppointments(),
          ),
          (route) => route.isFirst,
        );
      } else {
        await EasyLoading.showError("Something went wrong");
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

  var today_reqDate;
  var tomorrow_reqDate;
  var next_reqDate;
  List<slotClass> Today_slots = [];
  List<slotClass> Tomorrow_slots = [];
  List<slotClass> NExtDay_slots = [];
  List<slotClass> selectedSlots = [];

  void get_today_Slots() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/today_available_slots', data: {
        "clinic_id": widget.appointment!.clinicDetailId,
        "doctor_id": widget.appointment!.doctorId,
        "date": today_reqDate
      });

      var _slots = response.data['data']['today_slots_available'];
      if (response.statusCode == 200) {
        for (var sl in _slots) {
          slotClass slt = slotClass(
              id: sl['id'],
              availableSlot: sl['available_slot'],
              day: sl['day'],
              status: sl['status']);

          Today_slots.add(slt);
          print(Today_slots);
        }
        setState(() {});
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

  void get_tomorrow_Slots() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/today_available_slots', data: {
        "clinic_id": widget.appointment!.clinicDetailId,
        "doctor_id": widget.appointment!.doctorId,
        "date": tomorrow_reqDate
      });

      var _slots = response.data['data']['today_slots_available'];
      if (response.statusCode == 200) {
        for (var sl in _slots) {
          slotClass slt = slotClass(
              id: sl['id'],
              availableSlot: sl['available_slot'],
              day: sl['day'],
              status: sl['status']);

          Tomorrow_slots.add(slt);
        }
        setState(() {});
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

  void get_nextday_Slots() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/today_available_slots', data: {
        "clinic_id": widget.appointment!.clinicDetailId,
        "doctor_id": widget.appointment!.doctorId,
        "date": next_reqDate
      });

      var _slots = response.data['data']['today_slots_available'];
      if (response.statusCode == 200) {
        for (var sl in _slots) {
          slotClass slt = slotClass(
              id: sl['id'],
              availableSlot: sl['available_slot'],
              day: sl['day'],
              status: sl['status']);

          NExtDay_slots.add(slt);
        }
        setState(() {
          isload = true;
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

  bool isload = false;

  @override
  void initState() {
    getDates();
    get_today_Slots();
    get_tomorrow_Slots();
    get_nextday_Slots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14Dfff),
        title: const Text(
          'Reshedule Appointment',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150.0,
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
                                child: image(
                                    widget.appointment?.doctor_image_file,
                                    'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.appointment?.doctor_image_file}')),
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.appointment!.doctor_name.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  widget.string1.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.string2.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    widget.string3.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              // height: .0,
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
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.appointment!.clinic_name.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     '58 Canal Circular Road, On E.M. Bypass Road',
                      //     textAlign: TextAlign.start,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180.0,
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
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.appointment!.date.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.appointment!.slotTiming.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 0.8,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Text(
                                'Appointment for',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.appointment!.appointmentFor.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              const Text(
                                'Appointment ID',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.appointment!.id.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    // height: 70.0,
                    width: 160.0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = today;
                          selectedSlots = Today_slots;
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: selectedDate == today
                                  ? const Color(0xff14b2ff)
                                  : Colors.black.withOpacity(0.4),
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Today ${today_reqDate.toString()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  today == null
                                      ? "Today"
                                      : (Today_slots.isNotEmpty)
                                          ? today!.day.toString()
                                          : '${Today_slots.length.toString()} slots',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: (Today_slots.isEmpty)
                                          ? const Color(0xFFEE4B2B)
                                          : const Color(0xFF14ffb8),
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 70,
                    width: 160,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = tomorrow;
                          selectedSlots = Tomorrow_slots;
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: selectedDate == tomorrow
                                  ? const Color(0xff14b2ff)
                                  : Colors.black.withOpacity(0.4),
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  ' Tomorrow ${tomorrow_reqDate.toString()}',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  tomorrow == null
                                      ? ""
                                      : (Tomorrow_slots.isNotEmpty)
                                          ? tomorrow!.day.toString()
                                          : '${Tomorrow_slots.length.toString()} Slots',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: (Tomorrow_slots.isEmpty)
                                          ? const Color(0xFFEE4B2B)
                                          : const Color(0xFF14ffb8),
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 70,
                    width: 160,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = dayAfterTomorrow;
                          selectedSlots = NExtDay_slots;
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: selectedDate == dayAfterTomorrow
                                  ? const Color(0xff14b2ff)
                                  : Colors.black.withOpacity(0.4),
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  dayAfterTomorrow == null
                                      ? "Day after Tomorrow"
                                      : dayAfterTomorrow!.date.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  dayAfterTomorrow == null
                                      ? ""
                                      : (Tomorrow_slots.isNotEmpty)
                                          ? dayAfterTomorrow!.day.toString()
                                          : ('${NExtDay_slots.length.toString()} Slots'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: (NExtDay_slots.isEmpty)
                                          ? const Color(0xFFEE4B2B)
                                          : const Color(0xFF14ffb8),
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Card(
                elevation: 1.0,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.4), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${(selectedDate?.date == null) ? 'Select clinic and Slot' : selectedDate?.date}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          (selectedDate == today)
                              ? '${Today_slots.length} Time Schedule Available'
                              : (selectedSlot == tomorrow)
                                  ? '${Tomorrow_slots.length} Time Schedule Available'
                                  : (selectedSlot == dayAfterTomorrow)
                                      ? '${NExtDay_slots.length} Time Schedule Available'
                                      : 'Select clinic and slot',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Color(0xFF14ffb8),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 0.8,
                        color: Colors.black,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: selectedDate == null
                              ? const Center(
                                  child: Text(
                                    'Please Select A clinic and Date',
                                    style: TextStyle(
                                        color: Color(0xFF14ffb8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : (selectedSlots.isEmpty)
                                  ? const Text(
                                      'No Slots available',
                                      style: TextStyle(
                                          color: Color(0xFF14ffb8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(CupertinoIcons.sunrise),
                                              Text('Morining')
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GridView.count(
                                            crossAxisCount: 3,
                                            childAspectRatio: (1 / .4),
                                            shrinkWrap: true,
                                            children: slots_list_func(
                                                (selectedDate == today)
                                                    ? Today_slots
                                                    : (selectedDate == tomorrow)
                                                        ? Tomorrow_slots
                                                        : NExtDay_slots,
                                                1),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: const [
                                              Icon(Icons.sunny),
                                              Text('Afternoon')
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GridView.count(
                                            crossAxisCount: 3,
                                            childAspectRatio: (1 / .4),
                                            shrinkWrap: true,
                                            children: slots_list_func(
                                                (selectedDate == today)
                                                    ? Today_slots
                                                    : (selectedDate == tomorrow)
                                                        ? Tomorrow_slots
                                                        : NExtDay_slots,
                                                2),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: const [
                                              Icon(CupertinoIcons.sunset),
                                              Text('Evening')
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GridView.count(
                                            crossAxisCount: 3,
                                            childAspectRatio: (1 / .4),
                                            shrinkWrap: true,
                                            children: slots_list_func(
                                                (selectedDate == today)
                                                    ? Today_slots
                                                    : (selectedDate == tomorrow)
                                                        ? Tomorrow_slots
                                                        : NExtDay_slots,
                                                3),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: const [
                                              Icon(CupertinoIcons.moon),
                                              Text('Night')
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GridView.count(
                                              crossAxisCount: 3,
                                              childAspectRatio: (1 / .4),
                                              shrinkWrap: true,
                                              children: slots_list_func(
                                                  (selectedDate == today)
                                                      ? Today_slots
                                                      : (selectedDate ==
                                                              tomorrow)
                                                          ? Tomorrow_slots
                                                          : NExtDay_slots,
                                                  4),
                                            ),
                                          ),
                                        ],
                                      ))
                          // Row(
                          //     mainAxisSize: MainAxisSize.max,
                          //     children: [
                          //
                          //     ],
                          // ),
                          ),
                    ],
                  ),
                ),
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: const Color(0xff14b2ff),
            //       minimumSize: const Size.fromHeight(48),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (BuildContext context) => const Confirmation(),
            //         ),
            //       );
            //     },
            //     child: const Text(
            //       "Next",
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar:
          Padding(padding: const EdgeInsets.all(8.0), child: buttonReaction()),
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

  List<SizedBox> slots_list_func(slots, int when) {
    List<SizedBox> morning = [];
    List<SizedBox> afternoon = [];
    List<SizedBox> evening = [];
    List<SizedBox> night = [];
    if (slots != null) {
      for (slotClass sl in slots) {
        String time = sl.availableSlot!.split(' ')[2];
        if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 12:00:01"))) {
          morning.add(
            SizedBox(
              height: 50,
              width: 75,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 18:00:01"))) {
          afternoon.add(
            SizedBox(
              height: 50,
              width: 75,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 24:00:01"))) {
          evening.add(
            SizedBox(
              height: 50,
              width: 75,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (DateTime.parse("2021-12-23 $time:00")
            .isBefore(DateTime.parse("2021-12-23 06:00:01"))) {
          night.add(
            SizedBox(
              height: 50,
              width: 75,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    slotId = sl.id!;
                    selectedSlot = sl;
                  });
                },
                child: Card(
                  color: selectedSlot == sl
                      ? Colors.green
                      : const Color(0xFF14B2FF),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black.withOpacity(0), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 1.0, right: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sl.availableSlot.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
    if (when == 1) {
      return morning;
    } else if (when == 2) {
      return afternoon;
    } else if (when == 3) {
      return evening;
    } else {
      return night;
    }
  }

  Widget buttonReaction() {
    return MaterialButton(
        onPressed: () {
          reshedule();
        },
        color: Colors.blue,
        child: const Text(
          'Reschedule',
          style: TextStyle(color: Colors.white),
        ));
  }
}
