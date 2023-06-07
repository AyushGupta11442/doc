import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/appointment/UpcomingAppointments.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import 'models/dateClass.dart';
import 'models/slotClass.dart';

class AppointmentBooking extends StatefulWidget {
  const AppointmentBooking(
      {Key? key,
      required this.Image,
      required this.name,
      required this.doctorid,
      required this.date,
      required this.slot,
      required this.clinic,
      required this.speciality})
      : super(key: key);
  final String speciality;
  final String? Image;
  final int doctorid;
  final String name;
  final dateClass date;
  final slotClass slot;
  final Clinices clinic;
  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

//! important variables

class _AppointmentBookingState extends State<AppointmentBooking> {
  final genderss = ['Male', 'Female', 'Other'];
  String? selectedgender = 'Male';
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  bool user = true;
  bool offline_pay = true;
  bool isEmailVerified = false;
  bool isPhoneVerified = false;

  var appointment_for = SharedPreferencesHelper.getUserName();
  var name = SharedPreferencesHelper.getUserName();
  var gender = SharedPreferencesHelper.getUserGender();
  var phone_number = SharedPreferencesHelper.getUserPhone();
  var email = SharedPreferencesHelper.getUserMail();

  Future<dynamic> bookAppointment(mode, String? paymentId) async {
    print(phone_number);
    var id;
    try {
      final response = await DioClinetToken.instance.dio!
          .post('/appointment_store/' + widget.slot.id.toString(), data: {
        "clinic_detail_id": widget.clinic.id,
        "appointment_for": name,
        "name": name,
        "gender": (for_myself)
            ? gender!.toString().toLowerCase()
            : selectedgender!.toLowerCase(),
        "phone_number": phone_number.toString().toLowerCase(),
        "email": email.toString().toLowerCase(),
        "date": widget.date.dateString.toString().toLowerCase(),
        "payment_mode": mode
      });
      var _appointment = response.data['data']['data']['id'];
      print(_appointment);
      id = _appointment;
      if (response.statusCode == 200 && offline_pay) {
        // Navigator.pushAndRemoveUntil(
        //   context,

        //   MaterialPageRoute(
        //     builder: (BuildContext context) => const UpcomingAppointments(),
        //   ),
        //    (route) => false
        // );

        // Navigator.of(context).replace(
        //   oldRoute: ModalRoute.of(context) as PageRoute,
        //   newRoute: PageRouteBuilder(
        //     pageBuilder: (BuildContext context, _, __) {
        //       return UpcomingAppointments();
        //     },
        //   ),
        // );
      }
      if (!offline_pay) {
        print(paymentId);
        final response = await DioClinetToken.instance.dio!.post(
            '/appointment/${id.toString()}/payment',
            data: {'payment_id': paymentId, "_method": "PUT"});
        if (response.statusCode == 200) {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => const UpcomingAppointments(),
          //   ),
          //   (route)=>false
          // );
          Navigator.of(context).replace(
            oldRoute: ModalRoute.of(context) as PageRoute,
            newRoute: PageRouteBuilder(
              pageBuilder: (BuildContext context, _, __) {
                return UpcomingAppointments();
              },
            ),
          );
        }
      }
      return response;
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

  // razor pay integration
  late var _razorpay;
  var amountController = TextEditingController();

  bool for_myself = true;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
    bookAppointment((offline_pay) ? "Offline" : "Online", response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF14DFFF),
        title: const Text(
          'Book In Clinic Appointment',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        // Row(
        //   children: <Widget>[
        //     Text(
        //       'Book In Clinic Appointment',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 18,
        //           color: Colors.white),
        //     ),
        //
        //   ],
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 151.0,
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
                              borderRadius:
                                  BorderRadius.circular(10.0), //or 15.0
                              child: Container(
                                  height: 90.0,
                                  width: 90.0,
                                  color: const Color(0x00b2e2fc),
                                  child: image(widget.Image,
                                      'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.Image}')),
                            ),
                            const SizedBox(
                              width: 18.0,
                            ),
                            Column(
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
                                const SizedBox(
                                  height: 8.0,
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
                                            width: 150,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
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
                                          ),
                                        ],
                                      ),
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
                height: 102.0,
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
                            widget.clinic.name.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.clinic.address.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.white),
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
              SizedBox(
                height: 240.0,
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
                            widget.date.date.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.date.day}, ${widget.slot.availableSlot}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.8,
                          color: Colors.black,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'This in-clinic appointment is for:',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  user = true;
                                  for_myself = true;
                                  appointment_for =
                                      SharedPreferencesHelper.getUserName();
                                  name = SharedPreferencesHelper.getUserName();
                                  gender =
                                      SharedPreferencesHelper.getUserGender();
                                  phone_number =
                                      SharedPreferencesHelper.getUserPhone();
                                  email = SharedPreferencesHelper.getUserMail();
                                });
                              },
                              constraints:
                                  BoxConstraints.tight(const Size(16, 16)),
                              fillColor: user ? Colors.blue : Colors.white,
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid),
                              ),
                              child: Icon(
                                Icons.circle,
                                size: 16.0,
                                color: user ? Colors.blue : Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'For Myself',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  user = false;
                                  appointment_for = '';
                                  gender = '';
                                  phone_number = '';
                                  email = '';
                                  for_myself = false;
                                });
                              },
                              constraints:
                                  BoxConstraints.tight(const Size(16, 16)),
                              fillColor: user ? Colors.white : Colors.blue,
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid),
                              ),
                              child: Icon(
                                Icons.circle_rounded,
                                size: 16.0,
                                color: user ? Colors.white : Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Someone Else',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 275.0,
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
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Provide the following information about patient',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: info(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70.0,
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
                      children: <Widget>[
                        const Text(
                          'Consultation Fees',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.clinic.fees} Rs',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150.0,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: <Widget>[
                              RawMaterialButton(
                                onPressed: () {
                                  setState(() {
                                    offline_pay = false;
                                  });
                                },
                                constraints:
                                    BoxConstraints.tight(const Size(16, 16)),
                                fillColor:
                                    offline_pay ? Colors.white : Colors.blue,
                                shape: const CircleBorder(
                                  side: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid),
                                ),
                                child: Icon(
                                  Icons.circle_rounded,
                                  size: 16.0,
                                  color:
                                      offline_pay ? Colors.white : Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Rs. ${widget.clinic.fees} Pay Online',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: <Widget>[
                              RawMaterialButton(
                                onPressed: () {
                                  setState(() {
                                    offline_pay = true;
                                  });
                                },
                                constraints:
                                    BoxConstraints.tight(const Size(16, 16)),
                                fillColor:
                                    offline_pay ? Colors.blue : Colors.white,
                                shape: const CircleBorder(
                                  side: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid),
                                ),
                                child: Icon(
                                  Icons.circle,
                                  size: 16.0,
                                  color:
                                      offline_pay ? Colors.blue : Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Rs. ${widget.clinic.fees} Pay Later at Clinic',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'NOTE :',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  '1. Free cancellation and rescheduling is available till 2 hours before the appointment time. ',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  '2. After the stipulated time, rescheduling will not be available, and a fees of 50 INR will be applicable for cancellation or no-shows.',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text:
                            "3. By booking this appointment you agree to the ",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      TextSpan(
                          text: "T & C",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      const TextSpan(
                        text: ".",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "4. You can read our payment ",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      TextSpan(
                          text: "FAQs",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      const TextSpan(
                        text: ".",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff14b2ff),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    if (offline_pay) {
                      bookAppointment(
                              (offline_pay) ? "Offline" : "Online", null)
                          .then((value) => {
                                if (value.statusCode == 200)
                                  {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpcomingAppointments()),
                                        (route) => route.isFirst)
                                  }
                              });
                    } else {
                      int fees = widget.clinic.fees!;
                      fees = fees * 100;
                      var options = {
                        'key': "rzp_test_BMepWB6SWJdzu2",
                        'amount': fees,
                        'name': widget.clinic.name.toString(),
                        'description': 'payment from $name',
                        'timeout': 600, // in seconds
                        'prefill': {'contact': phone_number, 'email': email}
                      };
                      _razorpay.open(options);
                    }
                  },
                  child: const Text(
                    "Confirm & Pay",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
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

  List<Widget> info() {
    print(SharedPreferencesHelper.getUserGender());

    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return (for_myself)
        ? <Widget>[
            SizedBox(
              height: 50,
              child: ListTile(
                title: Text('${SharedPreferencesHelper.getUserName()}'),
                leading: Icon(
                  Icons.person,
                  color: Colors.grey.shade700,
                  size: 26,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                title: Text('${SharedPreferencesHelper.getUserGender()}'),
                leading: Icon(
                  Icons.man,
                  color: Colors.grey.shade700,
                  size: 26,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                title: Text('${SharedPreferencesHelper.getUserPhone()}'),
                leading: Icon(
                  Icons.phone,
                  color: Colors.grey.shade700,
                  size: 26,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                title: Text('${SharedPreferencesHelper.getUserMail()}'),
                leading: Icon(
                  Icons.mail,
                  color: Colors.grey.shade700,
                  size: 26,
                ),
              ),
            ),
          ]
        : <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListTile(
                    title: TextFormField(
                      enabled: !for_myself,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        )),
                        hintText: 'Enter Patient Full Name',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                          print(value);
                        });
                      },
                    ),
                    leading: Icon(
                      Icons.person,
                      color: Colors.grey.shade700,
                      size: 26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    title: DropdownButtonFormField(
                      value: selectedgender,
                      items: genderss
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedgender = value.toString();
                        });
                      },
                    ),
                    leading: Icon(
                      Icons.man,
                      color: Colors.grey.shade700,
                      size: 26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    title: TextFormField(
                      enabled: !for_myself,
                      keyboardType: TextInputType.number,
                      // controller: _phone,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            10), // Limit input to 10 characters
                      ],
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: isPhoneVerified
                                    ? Colors.grey
                                    : Colors.red)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: isPhoneVerified
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.red,
                        )),
                        hintText: 'Enter Patient Mobile Number',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        setState(() {
                          phone_number = value;
                        });

                        if (phone_number!.length == 10) {
                          setState(() {
                            isPhoneVerified = true;
                          });
                        }
                        return null;
                      },
                    ),
                    leading: Icon(
                      Icons.phone,
                      color: Colors.grey.shade700,
                      size: 26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    title: TextFormField(
                      enabled: !for_myself,
                      // controller: _email,

                      onSaved: (String? email) {},
                      onChanged: (value) {
                        setState(() {
                          email = value;
                          print(value);
                        });
                        // if (email!.isEmpty) {
                        //   setState(() {
                        //     isEmailVerified = false;
                        //   });
                        // }
                        if (RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(email!)) {
                          setState(() {
                            isEmailVerified = true;
                          });
                          print(isEmailVerified);
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: isEmailVerified
                                ? BorderSide(color: Colors.grey)
                                : BorderSide(color: Colors.red)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: isEmailVerified
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.red,
                        )),
                        hintText: 'Enter Patient Email Id',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    leading: Icon(
                      Icons.mail,
                      color: Colors.grey.shade700,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ];
  }
}
// code for radio button 
// Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                   Expanded(
//                     child: RadioListTile(
//                       value: Genders.Male,
//                       title: Text(Genders.Male.name,style: const TextStyle(fontSize: 10),),
//                       groupValue: genderss,
//                       onChanged: ((value) {
//                         setState(() {
//                           genderss = value as Genders?;
//                         });
//                       }),
//                     ),
//                   ),
//                   Expanded(
//                     child: RadioListTile(
//                       value: Genders.Female,
//                       title: Text(Genders.Female.name),
//                       groupValue: genderss,
//                       onChanged: ((value) {
//                         setState(() {
//                           genderss = value as Genders?;
//                         });
//                       }),
//                     ),
//                   ),
//                   Expanded(
//                     child: RadioListTile(
//                       value: Genders.Other,
//                       title: Text(Genders.Other.name),
//                       groupValue: genderss,
//                       onChanged: ((value) {
//                         setState(() {
//                           genderss = value as Genders?;
//                         });
//                       }),
//                     ),
//                   ),
//                 ]),