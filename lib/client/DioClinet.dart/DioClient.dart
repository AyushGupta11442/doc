import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClinet {
  Dio? dio;
  static DioClinet? _instance;

  DioClinet._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.doctrro.com/api',
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(),
    );
  }

  static DioClinet get instance {
    _instance ??= DioClinet._internal();
    return _instance!;
  }
}
