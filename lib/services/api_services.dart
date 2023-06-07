import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../provider/shared_pref_helper.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.doctrro.com/api/',
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${SharedPreferencesHelper.getAuthToken()}',
      },
    ),
  );
  // ! get method
  Future<dynamic> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // ! post method
  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // ! put method
  Future<dynamic> put(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(url, data: data);
      return response.data;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // ! delete method
  Future<dynamic> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return response.data;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // ! update method
  Future<dynamic> update(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(url, data: data);
      return response.data;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }
}
