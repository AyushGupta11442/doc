import 'package:flutter/foundation.dart';

import '../provider/shared_pref_helper.dart';

class LogionInof extends ChangeNotifier {
  bool _isLogin = false;
  get isLogin => _isLogin;
  

  set isLogin(value) {
    _isLogin = value;
    notifyListeners();
  }

  void changeLogin() {
    if (SharedPreferencesHelper.getAuthToken() != "") {
      _isLogin = true;
      notifyListeners();
    }
  }
}
