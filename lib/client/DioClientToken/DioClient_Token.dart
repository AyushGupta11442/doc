import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../provider/shared_pref_helper.dart';

class DioClinetToken {
  Dio? dio;
  static DioClinetToken? _instance;
  String token = SharedPreferencesHelper.getAuthToken();

  DioClinetToken._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.doctrro.com/api',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        // 
        connectTimeout: 7000,
        receiveTimeout: 7000,
      ),
    );
    dio?.interceptors.add(
      PrettyDioLogger(),
    );

    // dio?.interceptors.add(
    //   RetryInterceptor(
    //     dio: dio!,
    //     logPrint: print, // specify log function (optional)
    //     retries: 10, // retry count (optional)
    //   ),
    // );
  }

  static DioClinetToken get instance {
    _instance ??= DioClinetToken._internal();
    return _instance!;
  }
}
