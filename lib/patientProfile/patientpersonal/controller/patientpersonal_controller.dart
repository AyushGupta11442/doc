import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctor/Home/view/Homepage.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/models/GetImage_error_model.dart';
import 'package:doctor/models/patientpersonal_profile_model.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:velocity_x/velocity_x.dart';

final progressProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final patinetPersonalProvider = Provider<PatientPersonalController>((ref) {
  return PatientPersonalController();
});
// ! fetch data patient personal profile
final getPatientPersonalProfileProvider =
    FutureProvider.autoDispose<ErrorModel>((ref) async {
  return await ref.read(patinetPersonalProvider).getUserProfile();
});

class PatientPersonalController {
  File? proImage;
// ! get image from gallery
  Future<File?> pickImageGallery(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        final img = File(image.path);
        proImage = img;

        return proImage;
      } else {
        VxToast.show(
          context,
          msg: "No image selected",
          bgColor: Vx.black,
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

// ! pick image from camera
  Future<File?> pickImageCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (image != null) {
        final img = File(image.path);

        proImage = img;
        return proImage;
      } else {
        VxToast.show(
          context,
          msg: 'please click image',
          bgColor: Vx.black,
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

  // ! profile Image Upload with dio
  Future<dynamic> uploadProfileImage(File file, WidgetRef ref) async {
    Dio _dio = Dio();
    try {
      if (proImage != null) {
        final formData = FormData.fromMap({
          'image_file': await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last),
          '_method': 'PUT',
        });

        await EasyLoading.show(status: 'Uploading...');

        final response = await _dio.post(
          'https://api.doctrro.com/api/add_customer_profile_picture',
          data: formData,
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${SharedPreferencesHelper.getAuthToken()}',
            },
          ),
        );
        _dio.interceptors.add(
          PrettyDioLogger(),
        );

        _dio.interceptors.add(
          RetryInterceptor(
            dio: _dio,
            logPrint: print, // specify log function (optional)
            retries: 10, // retry count (optional)
          ),
        );

        if (response.statusCode == 200) {
          await EasyLoading.showSuccess('Image Uploaded');

          SharedPreferencesHelper.setUserImage(
              response.data['data']['customer']['image_file']);
          await EasyLoading.dismiss();
        }
        return response;
      }
    } catch (e) {
      // Utils.toastMessage('Error: $e');
      EasyLoading.dismiss();
      log(e.toString());
    }
  }

  Future<ErrorModel> getUserProfile() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );

    try {
      final response = await DioClinetToken.instance.dio!.get('/profile',
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${SharedPreferencesHelper.getAuthToken()}',
            },
          ));

      if (response.statusCode == 200) {
        final data = response.data;

        error = ErrorModel(
          error: null,
          data: PatientPersonalProfile.fromJson(data),
        );
      }
    } on DioError catch (e) {
      error = ErrorModel(error: '$e', data: null);
    }

    return error;
  }
}
