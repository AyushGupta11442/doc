import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/Home/view/modals/ssearch_by_clinic_id.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/view/clinicReview/model/clinicReview.dart';
import 'package:doctor/view/clinicReview/view/ClinicReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

import 'AllReviews.dart';

class UserReviewcard extends StatefulWidget {
  const UserReviewcard({
    Key? key,
    required this.r,
    this.clinic,
  }) : super(key: key);
  final Reviews r;
  final Clinices? clinic;

  // final void delete;
  @override
  State<UserReviewcard> createState() => _UserReviewcardState();
}

class _UserReviewcardState extends State<UserReviewcard> {
  void deleteReview(int id) async {
    try {
      final response = await DioClinetToken.instance.dio!
          .get("/clinic_review_delete/" + id.toString());

      if (response.statusCode == 200) {
        setState(() {});

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AllReviews(
                id: widget.clinic!.id!,
                clinic: widget.clinic!,
              );
            },
          ),
        );
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
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Your Experience',
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipOval(
                              child: image(widget.r.customer?.imageFile,
                                  'https://api.doctrro.com/assets/uploads/customer/profile_pictures/${widget.r.customer?.imageFile}'))),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      widget.r.customer!.name.toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 48.0,
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < widget.r.rating!; i++)
                          const Icon(
                            Icons.star,
                            size: 20.0,
                            color: Color(0xFF14b2ff),
                          ),
                      ],
                    ),
                  ],
                ),
                Container(
                  // margin: const EdgeInsets.only(right: 32),
                  child: Text(
                    'Date : ' + widget.r.updatedAt!.substring(0, 10),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 52),
                child: Text(
                  widget.r.message.toString(),
                  overflow: TextOverflow.visible,
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ClinicReview(
                                id: widget.r.clinicDetailId,
                                star: widget.r.rating,
                                review: widget.r.message,
                                reviewId: widget.r.id,
                                clinic: widget.clinic,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Edit Your Experience',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      )),
                  MaterialButton(
                    onPressed: () {
                      deleteReview(widget.r.id!);
                    },
                    color: Colors.blue,
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget image(String? image, String imageURL) {
    print(imageURL);
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
