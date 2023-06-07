import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/doctorProfile/doctorProfile.dart';
import 'package:doctor/view/clinicReview/model/consultants_list.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
// import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:doctor/view/clinicReview/model/clinicReview.dart';
import 'package:doctor/view/clinicReview/model/clinic_detail.dart';
import 'package:doctor/view/clinicReview/view/ClinicReview.dart';
import 'package:doctor/view/clinicReview/view/ReviewCard.dart';
import 'package:doctor/view/clinicReview/view/UserReviewCard.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../provider/shared_pref_helper.dart';
import '../../../widget/CircleProgress.dart';

class AllReviews extends StatefulWidget {
  const AllReviews({
    Key? key,
    this.id,
    this.clinic,
  }) : super(key: key);
  final int? id;
  final Clinices? clinic;

  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  String screen = '1';
  bool reviewdone = false;

  Color aboutcolor = const Color(0xFF14B2ff);
  Color abouttextcolor = Colors.white;
  Color aboutbordercolor = const Color(0xFF14B2ff);
  Color consultantscolor = Colors.white;
  Color consultantstextcolor = const Color(0xFF14B2ff);
  Color consultantsbordercolor = const Color(0xFF14B2ff);
  Color Reviewscolor = Colors.white;
  Color Reviewstextcolor = const Color(0xFF14B2ff);
  Color Reviewsbordercolor = const Color(0xFF14B2ff);
  Iterable<Reviews> userReview = [];
  late Map ReviewsmapResponse;
  String Reviewsname = '';
  String Reviewsemail = '';
  String Reviewsallergies = '';
  String ReviewschronicDiseases = '';
  String Reviewsinjuries = '';
  String Reviewssurgeries = '';
  List<consultants_list> consultants = [];
  var isLoading = true;
  late clinic_detail clinic_about;
  late consultants_list consultants_detail;
  bool aboutload = false;

  void getclinicconsultants() async {
    final response = await DioClinetToken.instance.dio!
        .get('/clinic_doctors/' + widget.id.toString());
    var data = jsonDecode(response.toString());
    setState(() {
      consultants_detail = consultants_list.fromJson(data);
      consultants.add(consultants_detail);
    });
    setState(() {});
  }

  void getclinicabout() async {
    final response = await DioClinetToken.instance.dio!
        .get('/clinic_detail/' + widget.id.toString());
    var data = jsonDecode(response.toString());
    setState(() {
      clinic_about = clinic_detail.fromJson(data);
    });
    setState(() {
      aboutload = true;
    });
  }

  late clinicReview rev;

  void getClinicReviews() async {
    try {
      // final response = await _dio.get('clinic_reviews/' + clinicId.toString());
      final response = await DioClinetToken.instance.dio!
          .get('/clinic_reviews/' + widget.id.toString());

      var data = jsonDecode(response.toString());
      if (response.statusCode == 200) {
        rev = clinicReview.fromJson(data);

        print(userReview.isNotEmpty);
        userReview = await rev.data!.reviews!.where((i) =>
            i.customerId.toString() == SharedPreferencesHelper.getUserId());
        print(userReview.first.customerId);
        setState(() {
          reviewdone = userReview.isNotEmpty;
        });
        // if (userReview.isNotEmpty) {
        //   setState(() {
        //     rev = rev.data!.reviews!.filter((element) => false);
        //   });
        // }
      }
      // var data = jsonDecode(response.toString());
      // if (response.statusCode == 200) {
      //   doctorList = searheddoctorbyname.fromJson(data);
      //   setState(() {
      //     isload = true;
      //   });
      // }

      // setState(() {
      //   isLoading = false;
      //   userReview = reviews
      //       .where(
      //           (i) => SharedPreferencesHelper.getUserName() == i.customerName)
      //       .toList();
      //   reviews.removeWhere(
      //       (i) => SharedPreferencesHelper.getUserName() == i.customerName);
      // });
      // print(userReview[0]);
      // // ignore: avoid_print
      // print(reviews[0]);
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
    getClinicReviews();
    getclinicconsultants();
    getclinicabout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: (aboutload)
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Cover Photo.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 100),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: image(widget.clinic!.imageFile,
                                              "https://api.doctrro.com/assets/uploads/clinic/clinic_photo/${widget.clinic!.imageFile}")),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                InkWell(
                                  onTap: () {
                                    _makePhoneCall(
                                        "+91${clinic_about.data!.clinicDetail!.clinicNumber.toString()}");
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const <Widget>[
                                            Icon(
                                              Icons.call,
                                              color: Color(0xFF14B2ff),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              'Call',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Color(0xFF14B2ff),
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _makemail(clinic_about.data!
                                                  .registrationDetails!.email!);
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.email,
                                                color: Color(0xFF14B2ff),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                'Email',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Color(0xFF14B2ff),
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.clinic!.name.toString(),
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${clinic_about.data!.clinicType!.first.name}',
                              )),

                          // Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Text(
                          //       '${widget.clinic!.clinicType!.name}',

                          //     )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 4, right: 4),
                            child: InkWell(
                              child: Container(
                                height: 48.0,
                                width: 115.0,
                                decoration: BoxDecoration(
                                    color: aboutcolor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                      color: aboutbordercolor,
                                      width: 2,
                                    )),
                                child: Center(
                                  child: Text(
                                    "About",
                                    style: TextStyle(
                                        color: abouttextcolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: (() {
                                setState(() {
                                  aboutcolor = const Color(0xFF14B2ff);
                                  abouttextcolor = Colors.white;
                                  aboutbordercolor = const Color(0xFF14B2ff);
                                  consultantscolor = Colors.white;
                                  consultantstextcolor =
                                      const Color(0xFF14B2ff);
                                  consultantsbordercolor =
                                      const Color(0xFF14B2ff);
                                  Reviewscolor = Colors.white;
                                  Reviewstextcolor = const Color(0xFF14B2ff);
                                  Reviewsbordercolor = const Color(0xFF14B2ff);
                                  screen = "1";
                                });
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 4, right: 4),
                            child: InkWell(
                              child: Container(
                                height: 48.0,
                                width: 115.0,
                                decoration: BoxDecoration(
                                    color: consultantscolor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                      color: consultantsbordercolor,
                                      width: 2,
                                    )),
                                child: Center(
                                  child: Text(
                                    "Consultants",
                                    style: TextStyle(
                                        color: consultantstextcolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: (() {
                                setState(() {
                                  aboutcolor = Colors.white;
                                  abouttextcolor = const Color(0xFF14B2ff);
                                  aboutbordercolor = const Color(0xFF14B2ff);
                                  consultantscolor = const Color(0xFF14B2ff);
                                  consultantstextcolor = Colors.white;
                                  consultantsbordercolor =
                                      const Color(0xFF14B2ff);
                                  Reviewscolor = Colors.white;
                                  Reviewstextcolor = const Color(0xFF14B2ff);
                                  Reviewsbordercolor = const Color(0xFF14B2ff);
                                  screen = "2";
                                });
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 4, right: 4),
                            child: InkWell(
                              child: Container(
                                height: 48.0,
                                width: 115.0,
                                decoration: BoxDecoration(
                                    color: Reviewscolor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                      color: Reviewsbordercolor,
                                      width: 2,
                                    )),
                                child: Center(
                                  child: Text(
                                    "Reviews",
                                    style: TextStyle(
                                        color: Reviewstextcolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: (() {
                                setState(() {
                                  aboutcolor = Colors.white;
                                  abouttextcolor = const Color(0xFF14B2ff);
                                  aboutbordercolor = const Color(0xFF14B2ff);
                                  consultantscolor = Colors.white;
                                  consultantstextcolor =
                                      const Color(0xFF14B2ff);
                                  consultantsbordercolor =
                                      const Color(0xFF14B2ff);
                                  Reviewscolor = const Color(0xFF14B2ff);
                                  Reviewstextcolor = Colors.white;
                                  Reviewsbordercolor = const Color(0xFF14B2ff);
                                  screen = "3";
                                });
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (screen == "1")
                        ? about()
                        : (screen == "2")
                            ? ClinicConsultants()
                            : reviewsection(),
                  ],
                ),
              )
            : circularProgressIndicator(),
        bottomNavigationBar: (screen == '3') && reviewdone == false
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size.fromHeight(
                          40), // fromHeight use double.infinity as width and 40 is the height
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ClinicReview(
                              id: widget.id,
                              clinic: widget.clinic,
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Share Your Experience')),
              )
            : const SizedBox(height: 1));
  }

  Widget reviewsection() {
    return Column(
      children: [
        Builder(builder: (context) {
          return Column(
            children: [
              // for (Reviews r in rev.data!.reviews!)
              // r.customerId == SharedPreferencesHelper.getUserId()
              // ?
              userReview.isNotEmpty
                  ? UserReviewcard(
                      r: userReview.first,
                      clinic: widget.clinic,
                    )
                  : SizedBox()
            ],
          );
          // : const Spacer();
        }),
        Builder(builder: (context) {
          return rev.data!.reviews!.isNotEmpty && userReview.isNotEmpty
              ? Column(
                  children: [
                    for (Reviews r in rev.data!.reviews!
                        .filter((element) => userReview.first.id != element.id))
                      ReviewCard(r: r)
                  ],
                )
              : rev.data!.reviews!.isNotEmpty && userReview.isEmpty
                  ? Column(
                      children: [
                        for (Reviews r in rev.data!.reviews!) ReviewCard(r: r)
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'No Review added for this Clinic yet!',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
        }),
      ],
    );
  }

  Widget about() {
    if ((aboutload)) {
      return Column(
        children: [
          SizedBox(
            child: Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.medical_information,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'About',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 0.8,
                      color: Colors.grey,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (clinic_about.data?.clinicDetail?.about != null)
                                ? clinic_about.data!.clinicDetail!.about!
                                : "No about to show",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
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
            child: Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.my_location_sharp,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Clinic Location',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 0.8,
                      color: Colors.grey,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (clinic_about.data?.clinicDetail?.address != null)
                                ? clinic_about.data!.clinicDetail!.address!
                                : "No address is Given",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // Map to be added here

                        // TextButton(
                        //   style: ElevatedButton.styleFrom(
                        //     minimumSize: const Size.fromHeight(40),
                        //   ),
                        //   onPressed: () {},
                        //   child: const Text(
                        //     'See all 3',
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //       color: Color(0xff1484ff),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.my_location_sharp,
                                  color: Colors.grey,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  'Clinic Speciality',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.8,
                          color: Colors.grey,
                        ),
                        clinic_about.data!.clinicSpeciality!.length <= 0
                            ? Text(
                                "No Speciality Mentioned",
                                textAlign: TextAlign.start,
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: clinicspecialities(
                                    clinic_about.data!.clinicSpeciality),
                              )
                      ])),
            ),
          ),
          SizedBox(
            child: Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Icon(
                          Icons.request_page_rounded,
                          color: Colors.grey,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'Registration',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 0.8,
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 12.0,
                        ),
                        const Icon(
                          Icons.circle,
                          color: Colors.black,
                          size: 6.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Text(
                            (clinic_about.data?.registrationDetails
                                        ?.registrationCouncils ==
                                    null)
                                ? 'No registation detail'
                                : '${clinic_about.data!.registrationDetails!.registrationNo} - ${clinic_about.data?.registrationDetails?.registrationCouncils?.name} - ${clinic_about.data?.registrationDetails?.registrationYear}',
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
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
            child: Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Icon(
                          Icons.access_time_filled_sharp,
                          color: Colors.grey,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'Clinic Time',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 0.8,
                      color: Colors.grey,
                    ),
                    for (ClinicTime t in clinic_about.data!.clinicTime!)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${(t.day == null) ? 'unknown day' : t.day}',
                                    style: const TextStyle(
                                        color: Color(0xFF14ffB8),
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Sessions - ${(t.openingTime == null) ? 'unknown time' : t.openingTime.toString().substring(0, 5)} to ${(t.closingTime == null) ? 'unknown time' : t.closingTime.toString().substring(0, 5)}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Text("loading");
    }
  }

  Widget ClinicConsultants() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        for (consultants_list d in consultants)
          if (d.data?.message == "Success")
            for (Doctor l in d.data!.doctor!) consultants_container(l)
          else
            const Text("No Doctor to Show"),
      ],
    );
  }

  Widget image(String? image, String imageURL) {
    // print(object)
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

  List<Widget> clinicspecialities(speciality) {
    List<Widget> text = [];
    for (ClinicSpeciality s in speciality) {
      if (s.name != null) {
        text.add(
          Row(
            children: <Widget>[
              const SizedBox(
                width: 12.0,
              ),
              const Icon(
                Icons.circle,
                color: Colors.black,
                size: 6.0,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                s.name!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        );
      } else {
        text.add(const Text('No speciality to show'));
      }
    }
    return text;
  }

  Widget consultants_container(Doctor l) {
    String speciality = '';
    for (Speciality s in l.speciality!) {
      speciality += '${s.name}/';
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
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
                          child: image(l.imageFile,
                              'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${l.imageFile}')),
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l.name.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Poppins Bold',
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            speciality,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'Poppins SemiBold',
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'Experience : ${l.experience.toString()} Years',
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
                              '${(l.recommend == null) ? 'NO value' : l.recommend}',
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
                          SizedBox(
                            width: 170,
                            child: Text(
                              '${widget.clinic!.name}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            '${(l.district?.district == null) ? 'Not given' : l.district?.district}',
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
                          'Rs. ${(l.consultationFee == null) ? 'Not given' : l.consultationFee}',
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
                //         children: const <Widget>[
                //           Icon(
                //             Icons.home,
                //             size: 20.0,
                //             color: Color(0xFF14ffb8),
                //           ),
                //           SizedBox(
                //             width: 4.0,
                //           ),
                //           Text(
                //             '10:00 AM, Tomorrow',
                //             textAlign: TextAlign.start,
                //             style: TextStyle(
                //               fontFamily: 'Poppins SemiBold',
                //               fontSize: 12.0,
                //               color: Color(0xFF14ffb8),
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: const <Widget>[
                //           Icon(
                //             Icons.video_call_rounded,
                //             size: 22.0,
                //             color: Color(0xFF14ffb8),
                //           ),
                //           SizedBox(
                //             width: 4.0,
                //           ),
                //           Text(
                //             '10:00 AM, Tomorrow',
                //             textAlign: TextAlign.start,
                //             style: TextStyle(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DoctorProfile(id: l.id!)));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF1484ff)),
                          ),
                          child: const Text("View Profile",
                              style: TextStyle(fontSize: 12)
                              // Book Appointment
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
                                        DoctorProfile(id: l.id!, screen: "1")));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff14b2ff)),
                          ),
                          child: const Text(
                            'Book Appointment', style: TextStyle(fontSize: 12),
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
      ),
    );
  }

  Widget clinictype() {
    String clinictype = '';
    for (ClinicType c in clinic_about.data!.clinicType!) {
      print('hellllllllllllllllllllllllllllllllllllllll');
      print(c.name);
      clinictype += c.name.toString();
    }
    return Text(
      (clinictype == '') ? 'No clinic type to show' : clinictype,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> _makemail(String email) async {
  if (await canLaunchUrl(Uri.parse('mailto:$email'))) {
    await launchUrl(Uri.parse('mailto:$email'));
  }
}
