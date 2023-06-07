import 'dart:developer';

import 'package:doctor/client/DioClinet.dart/DioClient.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/location_data.dart';

// final HomeProviderProvider = Provider<HomeController>((ref) {
//   return HomeController();
// });
// FutureProvider<List<District>> getLocationProvider =
//     FutureProvider<List<District>>((ref) async {
//   return await ref.read(locationProvider).getLocation();
// });
// final locationProvider = Provider<LocationController>((ref) {
//   return LocationController();
// });

class LocationController {
  // final Dio _dio = Dio();
  // ! get method
  // // Future<List<District>> getLocation() async {
  // //   List<District>? locationData;
  // //   try {
  // //     final response =
  // //         await _dio.get('https://api.doctrro.com/api/district_index');
  // //     if (response.statusCode == 200) {
  // //       var data = response.data["data"]["districts"];
  // //       locationData = District.fromJsonList(data);
  // //     }
  // //   } catch (e) {
  // //     // log(e.toString());
  // //   }
  //   return locationData!;
  // }

  var data = [];
  List<District> results = [];
  // String urlList = 'https://api.doctrro.com/api/district_index';

  Future<List<District>> getLocationList({String? query}) async {
    try {
      var response = await DioClinet.instance.dio!.get('/district_index');
      if (response.statusCode == 200) {
        data = response.data["data"]["districts"];
        results = data.map((e) => District.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) => element.district
                  .toLowerCase()
                  .contains((query.trim().toLowerCase())))
              .toList();
        }

      } else {
        log("fetch error");
        // Vx ('fetch Error');
      }
    } on Exception catch (e) {
      log('error: $e');
      // Utils.toastMessage('Wrong');
      
    }
    return results;
    
  }
}
