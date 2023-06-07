
import 'package:get/get.dart';

import 'controller_internet..dart';

class DependencyInjection {
  static void init() async {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
