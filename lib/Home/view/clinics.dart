import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/Home/view/clinic_by_name.dart';
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/view/clinicReview/view/AllReviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget/CircleProgress.dart';

class clinics_by_its_type extends StatefulWidget {
  String typename;
  int id;
  clinics_by_its_type({Key? key, required this.typename, required this.id})
      : super(key: key);

  @override
  State<clinics_by_its_type> createState() => _clinics_by_its_typeState();
}

class _clinics_by_its_typeState extends State<clinics_by_its_type> {
  late String searched_name;
  bool isload = false;
  late search_by_clinic_id clinicss;

  Future<void> getlist() async {
    try {
      final response = await DioClinetToken.instance.dio!
          .get('/clinic_search_with_clinic_type/${widget.id}');

      var data = jsonDecode(response.toString());

      if (response.statusCode == 200) {
        setState(() {
          clinicss = search_by_clinic_id.fromJson(data);
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

  @override
  void initState() {
    // TODO: implement initState
    getlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF1484ff), size: 30.0),
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Text(
                'Find ${widget.typename}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey),
              ),
              const SizedBox(
                width: 8.0,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 15, top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: 39.0,
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searched_name = value;
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
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              clinics_by_its_name(name: searched_name)),
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
          ),
        ),
        body: (isload) && clinicss.data!.clinices!.length > 0
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 16,
                    ),
                    for (Clinices c in clinicss.data!.clinices!) clinicCard(c),
                  ],
                ),
              )
            : isload && clinicss.data!.clinices!.length == 0
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("No Clinics Found"),
                  ))
                : circularProgressIndicator());
  }

  Widget image(String? image, String imageURL) {
    if (image != null) {
      return Container(
          width: 80,
          height: 90,
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
        width: 80,
        height: 90,
        margin: const EdgeInsets.only(left: 8, top: 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
              image: NetworkImage(
                'assets/images/docto.png',
              ),
              fit: BoxFit.fill,
            )),
      );
    }
  }

  Widget clinicCard(Clinices c) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AllReviews(
                    id: c.id,
                    clinic: c,
                  )),
        );
      },
      child: SizedBox(
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black.withOpacity(0.4),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    image(c.imageFile,
                        "https://api.doctrro.com/assets/uploads/clinic/clinic_photo/${c.imageFile}"),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            c.name!,
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
                                  (c.clinicType?.name == null)
                                      ? 'No clinic type'
                                      : c.clinicType!.name!,
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
                                  '${(c.address == null) ? 'No Clinics address' : c.address}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
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
                    // const Text(
                    //   "open",
                    //   style: TextStyle(color: Colors.greenAccent, fontSize: 20),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.greenAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              const Text("Rating"),
                              Text((c.avarageRating != null)
                                  ? "${c.avarageRating!.substring(0, 3)} out of 5"
                                  : 'No rating')
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.home,
                          color: Color.fromARGB(255, 33, 226, 243),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              const Text("Own"),
                              Text(
                                  "${(c.ownClinic == null) ? 'No data' : c.ownClinic}")
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.medical_information,
                          color: Color.fromARGB(255, 33, 131, 243),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              const Text("Clinics"),
                              Text(
                                  "${(c.visitClinic == null) ? 'No data' : c.visitClinic}")
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
