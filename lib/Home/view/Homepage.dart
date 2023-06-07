import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/modals/top_doctor_list_modal.dart';
import 'package:doctor/Home/view/notification.dart';
import 'package:doctor/Home/view/category.dart';
import 'package:doctor/Home/view/clinics.dart';
import 'package:doctor/Home/view/doctorlist.dart';
import 'package:doctor/Home/view/modals/clinicspecialityclass.dart';
import 'package:doctor/Home/view/searchbydoctornamescreen.dart';
import 'package:doctor/Home/view/searchbyspecialistscreen.dart';
import 'package:doctor/Home/view/widgets/end_Drawer.dart';
import 'package:doctor/Home/view/widgets/locationSearch.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/doctorProfile/doctorprofile.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:doctor/widget/CircleProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../healthQ&A/AskQuestion.dart';
import '../../healthQ&A/FilterQuestions.dart';
import '../../patientProfile/patientpersonal/controller/patientpersonal_controller.dart';
import 'widgets/topQuestions.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late String entered_name;

  double bottombarheight = 80;
  double bottomcontainerheight = 0;
  bool isconatiner = false;

  final List<clinicspeciality> allspecialist = [];

  // This list holds the data for the list view
  List<clinicspeciality> foundspeacialist = [];

  void getspecialitylist() async {
    try {
      final response =
          await DioClinetToken.instance.dio!.get('/specialities/all');

      var speciality = response.data['data']['specialities'];

      if (response.statusCode == 200) {
        for (var d in speciality) {
          clinicspeciality dc = clinicspeciality(
            id: d['id'],
            name: d['name'],
            status: d['status'],
            created_at: d['created_at'],
            updated_at: d['updated_at'],
          );
          allspecialist.add(dc);
        }
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

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<clinicspeciality> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allspecialist;
    } else {
      results = allspecialist
          .where((user) =>
              user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundspeacialist = results;
    });
  }

  int selectedPage = 0;

  double Nearestlocationnumber = 125;
  String Nearestlocationtext = "See all";

  late double screen_height = MediaQuery.of(context).size.height;
  late double screen_width = MediaQuery.of(context).size.width;

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
    getspecialitylist();
    foundspeacialist = allspecialist;
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
          icon: Image.asset(
            'assets/lg.png',
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 30.0),
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
          preferredSize: const Size.fromHeight(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! loaction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: SearchUser());
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xff14FFB8),
                        size: 25,
                      ),
                      5.widthBox,
                      SharedPreferencesHelper.getLocation()
                          .text
                          .size(18)
                          .make(),
                      5.widthBox,
                      const Icon(CupertinoIcons.chevron_down,
                          color: Color(0xFF1484ff), size: 15),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // const SizedBox(
                  //   width: 12.0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 15, top: 8.0, bottom: 8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 21.5,
                      width: MediaQuery.of(context).size.width / 1.41,
                      child: TextField(
                        onChanged: (value) {
                          _runFilter(value);
                          setState(() {
                            bottombarheight = 300;
                            bottomcontainerheight = 220;
                            isconatiner = true;
                            entered_name = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[250],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                          hintText: 'Search...',
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 12.0,
                  // ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bottombarheight = 80;
                          bottomcontainerheight = 0;
                        });
                        if (entered_name.length > 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Searchbyspecialistname(
                                        name: entered_name,
                                      )));
                        }
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
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          (isconatiner) ? searchbox() : const SizedBox(),
          Expanded(
            child: SizedBox(
              height: (MediaQuery.of(context).size.height / 1.2095) -
                  bottomcontainerheight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      bottombarheight = 80;
                      bottomcontainerheight = 0;
                      isconatiner = false;
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //  ! location search

                          const SizedBox(height: 15),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Consult with doctor',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Poppins Bold',
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                      width: 160,
                                      child: MaterialButton(
                                        minWidth: double.infinity,
                                        height: 60,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const Category()),
                                          );
                                        },
                                        color: const Color(0xff14DFFF),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'In-Clinic Consultation',
                                    style: TextStyle(
                                        fontFamily: 'Poppins SemiBold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Category',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins Bold',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 110,
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Searchbyspecialist(
                                        id: 338,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(150),
                                            color: const Color(0xff14B2FF),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Image(
                                              image: AssetImage(
                                                "assets/images/brain.png",
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                                      const Text(
                                        "Brain",
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 43,
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Searchbyspecialist(
                                        id: 68,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(150),
                                            color: const Color(0xff14B2FF),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/doctor-specialities-Icons/Heart ( Cardiologist ).png'),
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                                      const Text(
                                        "Heart",
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 43,
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Searchbyspecialist(
                                        id: 135,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(150),
                                            color: const Color(0xff14B2FF),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/doctor-specialities-Icons/Skin,Hair,Nails(Dermatologist).png'),
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                                      const Text(
                                        "Skin",
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 43,
                                ),
                                InkWell(
                                    child: Column(
                                      children: [
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(150),
                                              color: const Color(0xff14B2FF),
                                            ),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Center(
                                                      child: Text(
                                                        "See",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "all",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                      ],
                                    ),
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const Category()),
                                        )),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),
                          Container(
                            width: size.width,
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Container(
                                  child: const Text(
                                    "Top Doctors",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Poppins Bold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "See all",
                                          style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontSize: 18,
                                            fontFamily: 'Poppins Bold',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const DoctorList(),
                                          ),
                                        )),
                              ],
                            ),
                          ),

                          Container(
                            width: size.width,
                            height: 140,
                            margin: const EdgeInsets.only(top: 10),
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      top_doctors_list()
                                    ],
                                  ),
                                ]),
                          ),
                          const SizedBox(height: 15),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'What do you need at your nearest location ?',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins Bold',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 5),
                          // ! Your Nearst Location
                          SizedBox(
                            height: Nearestlocationnumber,
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              primary: false,
                              // padding: const EdgeInsets.all(4),
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              crossAxisCount: 3,
                              children: <Widget>[
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Pathology centre',
                                          id: 3,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/storeimages/pathology center.jpg'),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/storeimages/pathology center.jpg'),
                                            fit: BoxFit.contain,
                                          )),
                                      Text(
                                        "Pathalogy Centre",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Ayurvedic centre',
                                          id: 12,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/ayurvedic store.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Ayurvedic Store",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Allopathic Store',
                                          id: 11,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/allopathic store.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Allopathic Store",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Gym Store',
                                          id: 10,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/gym center.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Gym Store",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Hospital',
                                          id: 9,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/hospital.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Hospital",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Poly Clinic',
                                          id: 8,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/poly clinic.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Poly Clinic",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Diagnostic Centre',
                                          id: 7,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/diagnostic center.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Diagnostic Centre",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Homeophatic Store',
                                          id: 6,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/homeopathic store.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Homeophatic Store",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Nursing Home',
                                          id: 5,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/nursing home.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Nursing Home",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Physiotherapy Centre',
                                          id: 4,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/physiotherapy center.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Physiotherapy Centre",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Veterinary Clinic',
                                          id: 2,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/veterinary center.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Veterinary Clinic",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            clinics_by_its_type(
                                          typename: 'Dental Clininc',
                                          id: 1,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/storeimages/dental clinic.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Dental Clinic",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 5),
                          Center(
                            child: SizedBox(
                              width: 100,
                              child: Container(
                                child: ElevatedButton(
                                  child: Text(
                                    Nearestlocationtext,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins SemiBold',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xff14B4FF),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Nearestlocationnumber =
                                          (Nearestlocationnumber == 125)
                                              ? 570
                                              : 125;
                                      Nearestlocationtext =
                                          (Nearestlocationtext == "See all")
                                              ? "See Less"
                                              : "See All";
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Experts answer to your health question',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins Bold',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  // Text(
                                  //   'your health question',
                                  //   style: TextStyle(
                                  //       fontSize: 20,
                                  //       fontFamily: 'Poppins Bold',
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.black),
                                  // )
                                ],
                              ),
                            ),
                          ),

                          //SizedBox(height: 5),
                          TopQuestionList(
                            size: size,
                          ),

                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            //child: Container(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ElevatedButton(
                                      child: const Text(
                                        'Ask a free question',
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: 'Poppins SemiBold',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xff14DFFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const AskQuestion(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ElevatedButton(
                                      child: const Text(
                                        'Read trending question',
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: 'Poppins SemiBold',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xff14B2FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const FilterQuestions(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Methods
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

  Widget myDetailsContainer1(String name, String? imageURL, Doctors d) {
    String speciality = '';
    for (Specialities s in d.specialities!) {
      speciality += '${s.name!}/';
    }
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        child: FittedBox(
          child: Material(
              color: const Color(0xff14DFFF),
              elevation: 14.0,
              borderRadius: BorderRadius.circular(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  image(imageURL,
                      "https://api.doctrro.com/assets/uploads/doctor/profile_pictures/$imageURL"),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                name,
                                style: const TextStyle(
                                    fontFamily: 'Poppins Bold',
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                              width: 100,
                              child: Text(
                                (speciality == '')
                                    ? 'No speciality to show'
                                    : speciality,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Poppins Bold',
                                  color: Colors.white,
                                  fontSize: 10.0,
                                ),
                              )),
                          Container(
                              child: Text(
                            "Experience: ${(d.experience == null) ? 'Not given' : d.experience} yr",
                            style: const TextStyle(
                              fontFamily: 'Poppins Bold',
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          )),
                          Container(
                              child: Row(
                            children: <Widget>[
                              Container(
                                child: const Icon(
                                  Icons.thumb_up_sharp,
                                  color: Colors.white,
                                  size: 10.0,
                                ),
                              ),
                              Text(
                                '${(d.recommend == null) ? 'No data' : d.recommend}',
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                          const SizedBox(height: 5),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 15),
                                  child: ElevatedButton(
                                    child: const Text(
                                      'View Profile',
                                      style: TextStyle(
                                          fontFamily: 'Poppins SemiBold',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.lightBlueAccent,
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DoctorProfile(id: d.id!),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              "Dr.Rahul Roy",
              style: TextStyle(
                  fontFamily: 'Poppins Bold',
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            )),
        Container(
            child: const Text(
          "Gynecologist / Obstetrician",
          style: TextStyle(
            fontFamily: 'Poppins Bold',
            color: Colors.white,
            fontSize: 10.0,
          ),
        )),
        Container(
            child: const Text(
          "Experience: 7yr",
          style: TextStyle(
            fontFamily: 'Poppins Bold',
            color: Colors.white,
            fontSize: 10.0,
          ),
        )),
        Container(
            child: Row(
          children: <Widget>[
            Container(
              child: const Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 10.0,
              ),
            ),
            Container(
              child: const Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 10.0,
              ),
            ),
            Container(
              child: const Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 10.0,
              ),
            ),
            Container(
              child: const Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 10.0,
              ),
            ),
            Container(
              child: const Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 10.0,
              ),
            ),
          ],
        )),
        const SizedBox(height: 5),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 5),
                child: ElevatedButton(
                  child: const Text(
                    'View Profile',
                    style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget top_doctors_list() {
    if (isload == true) {
      return Row(
        children: [
          for (Doctors d in doctors_data.data!.doctors!)
            myDetailsContainer1(d.name!, d.imageFile, d)
        ],
      );
    } else {
      return Row(children: [
        SizedBox(
          width: screen_width / 2 - 16,
        ),
        circularProgressIndicator()
      ]);
    }
  }

  Widget searchbox() {
    return SizedBox(
      height: bottomcontainerheight,
      child: foundspeacialist.isNotEmpty
          ? ListView.builder(
              itemCount: foundspeacialist.length,
              itemBuilder: (context, index) => Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Searchbyspecialist(
                                    id: foundspeacialist[index].id!,
                                  )));
                    });
                  },
                  child: ListTile(
                    title: Text(foundspeacialist[index].name.toString()),
                  ),
                ),
              ),
            )
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No results found Please try with diffrent search',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
    );
  }
}
