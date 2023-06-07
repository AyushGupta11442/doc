import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/view/clinicReview/view/AllReviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Home/view/Homepage.dart';

class CentersList extends StatefulWidget {
  const CentersList({Key? key}) : super(key: key);

  @override
  State<CentersList> createState() => _CentersListState();
}

class _CentersListState extends State<CentersList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        home: const MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool value = false;
  bool isload = false;
  late search_by_clinic_id clinicss;

  Future<void> getlist() async {
    try {
      final response = await DioClinetToken.instance.dio!.get('/clinic_index');

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
    getlist();
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
        title: Column(
          children: [
            Text(
              'All Centers (' +
                  clinicss.data!.clinices!.length.toString() +
                  ')',
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            // Text(
            //   'Das Medical Store',
            //   style: TextStyle(
            //     fontSize: 15,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                for (Clinices c in clinicss.data!.clinices!)
                  SizedBox(
                    child: Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black.withOpacity(0.4),
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
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
                                    child: Image.asset(
                                      'assets/images/Building.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 32.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return AllReviews(
                                                  id: c.id!,
                                                  clinic: c,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Text(
                                          c.name.toString(),
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text(
                                        'Aliphatic Pharmacy',
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.grey),
                                      ),
                                      Text(
                                        c.address.toString(),
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle(
                                            fontSize: 14.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
