import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/appointmentBooking/Bookingpage2.dart';
import 'package:doctor/appointmentBooking/models/clinicClass.dart';
import 'package:doctor/appointmentBooking/models/dateClass.dart';
import 'package:doctor/appointmentBooking/models/slotClass.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

class DoctorAppoint extends StatefulWidget {
  const DoctorAppoint({
    Key? key,
    required this.id,
    required this.name,
    required this.imagefile,
    required this.speciality,
    this.clinic,
  }) : super(key: key);
  // final DoctorClass? doctor;

  final int id;
  final String name;
  final String? imagefile;
  final String speciality;
  final Clinices? clinic;

  @override
  State<DoctorAppoint> createState() => _DoctorAppointState();
}

class _DoctorAppointState extends State<DoctorAppoint> {
  bool value = false;
  List<Clinices> clinics = [];
  List<slotClass> Today_slots = [];
  List<slotClass> Tomorrow_slots = [];
  List<slotClass> NExtDay_slots = [];

  //arguments for next page
  slotClass? selectedSlot;
  dateClass? selectedDate;
  late Clinices? selectedClinic;
  List<slotClass> selectedSlots = [];

//handling dates
  dateClass? today;
  dateClass? tomorrow;
  dateClass? dayAfterTomorrow;

  var today_reqDate;
  var tomorrow_reqDate;
  var next_reqDate;
  // var doctorId;
  var slotId = 0;
  dynamic clinicId = 0;
//to convert the dates
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
      dayAfterTomorrow = convertdate(DateTime.now().add(const Duration(
          hours:
              48))); //TODO: change it to 48 hours to show the day after tommrorrow, right now its like this bcs any slots arent avaiable in this time

      today_reqDate = today!.date.toString();
      print(today_reqDate);
      tomorrow_reqDate = tomorrow!.date.toString();
      next_reqDate = dayAfterTomorrow!.date.toString();
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Select Clinic',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (Clinices cl in clinics)
            Builder(builder: (context) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cl.name.toString()),
                    Text(" Fees : " + cl.fees.toString())
                  ],
                ),
                leading: Radio(
                  value: cl.id!,
                  groupValue: clinicId,
                  onChanged: (value) {
                    setState(() {
                      clinicId = value;
                      selectedClinic = cl;
                      Today_slots = [];
                      Tomorrow_slots = [];
                      NExtDay_slots = [];
                      selectedSlots = [];
                      get_today_Slots();
                      get_tomorrow_Slots();
                      get_nextday_Slots();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              );
            }),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  void getclinics() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .get('/doctor_clinic_list/' + widget.id.toString());

      var _clinics = response.data['data']['clinic'];
      if (response.statusCode == 200) {
        for (var cl in _clinics) {
          Clinices c = Clinices.fromJson(cl);

          clinics.add(c);
        }
        print(clinics);
        setState(() {});
      }

      getDates();
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

  void get_today_Slots() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/today_available_slots', data: {
        "clinic_id": clinicId,
        "doctor_id": widget.id,
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
        "clinic_id": clinicId,
        "doctor_id": widget.id,
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
        "clinic_id": clinicId,
        "doctor_id": widget.id,
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

  @override
  void initState() {
    // getclinics();
    getDates();
    setState(() {
      selectedClinic = widget.clinic;
      clinicId = widget.clinic!.id;
    });
    get_today_Slots();
    get_tomorrow_Slots();
    get_nextday_Slots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14DFFF),
        title: Row(
          children: const <Widget>[
            Text(
              'Book In Clinic Appointment',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: SizedBox(
                  height: 151.0,
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            //or 15.0
                            child: image(
                              widget.imagefile,
                              "https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.imagefile}",
                            ),
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.name.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 19.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, right: 32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 160,
                                            child: Text(
                                              widget.speciality,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                // height: 80.0,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  clinicId > 0
                                      ? selectedClinic!.name.toString()
                                      : 'Select Clinic',
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  clinicId > 0
                                      ? selectedClinic!.address.toString()
                                      : '',
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_downward,
                      //       color: Colors.white, size: 20),
                      //   onPressed: () => showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) =>
                      //         _buildPopupDialog(context),
                      //   ),
                      // ),
                    ],
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
                                        : (clinicId == 0)
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
                                        : (clinicId == 0)
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
                                        : (clinicId == 0)
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
                  margin: const EdgeInsets.all(0),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              childAspectRatio: (1 / .3),
                                              shrinkWrap: true,
                                              children: slots_list_func(
                                                  (selectedDate == today)
                                                      ? Today_slots
                                                      : (selectedDate ==
                                                              tomorrow)
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
                                              childAspectRatio: (1 / .3),
                                              shrinkWrap: true,
                                              children: slots_list_func(
                                                  (selectedDate == today)
                                                      ? Today_slots
                                                      : (selectedDate ==
                                                              tomorrow)
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
                                              childAspectRatio: (1 / .3),
                                              shrinkWrap: true,
                                              children: slots_list_func(
                                                  (selectedDate == today)
                                                      ? Today_slots
                                                      : (selectedDate ==
                                                              tomorrow)
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
                                            GridView.count(
                                              crossAxisCount: 3,
                                              childAspectRatio: (1 / .3),
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
              ),
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

  Widget buttonReaction() {
    if (clinicId == 0) {
      return MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          child: const Text(
            'Select Clinic',
            style: TextStyle(color: Colors.white),
          ));
    } else if (slotId == 0) {
      return MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          child: const Text(
            'Select Slot',
            style: TextStyle(color: Colors.white),
          ));
    } else if (today == null) {
      return MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          child: const Text(
            'Select Date',
            style: TextStyle(color: Colors.white),
          ));
    } else {
      return MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AppointmentBooking(
                  slot: selectedSlot!,
                  clinic: selectedClinic!,
                  date: selectedDate!,
                  Image: widget.imagefile,
                  doctorid: widget.id,
                  speciality: widget.speciality,
                  name: widget.name,
                ),
              ),
            );
          },
          color: Colors.blue,
          child:
              const Icon(Icons.arrow_forward, color: Colors.white, size: 28));
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
              // height: 50,
              // width: 75,
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
}
