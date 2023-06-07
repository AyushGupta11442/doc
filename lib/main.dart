import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:doctor/routes/Routes_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'internetCheck/internetcheck_screen.dart';
import 'routes/pressist_auth_controller.dart';
import 'core/globalkey/globalkey.dart';

Future? token;
String? myToken;

LogionInof loginInfo = LogionInof();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DependencyInjection.init();
  await SharedPreferencesHelper.init();
  Future.delayed(const Duration(), () {
    loginInfo.changeLogin();
  });

  runApp(const ProviderScope(child: MyApp()));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {


  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult _connectivityResult;
  late StreamSubscription<ConnectivityResult> _streamSubscription;
  @override
  void initState() {
    _initConnectivity();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    doLogin();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Future doLogin() async {
    final token = SharedPreferencesHelper.getAuthToken();
    setState(() => myToken = token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: snackbarKey,
      title: 'Doctrro App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: EasyLoading.init(),
      routeInformationProvider: Routes.router.routeInformationProvider,
      routeInformationParser: Routes.router.routeInformationParser,
      routerDelegate: Routes.router.routerDelegate,
    );
  }

  Future<void> _initConnectivity() async {
    _connectivityResult = await _connectivity.checkConnectivity();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
     
       SnackBar snackBar = SnackBar(
        onVisible: (){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Internet()),
          // );
           Get.to(() => const Internet());
        },
        duration: const Duration(days: 1),
        content:  const Text(
          "No Internet Connection , Please Check Your  Internet Connection",
        ),
        backgroundColor: Colors.red,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
      

      
    } else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (snackbarKey.currentState?.mounted == true) {
        
        snackbarKey.currentState?.hideCurrentSnackBar();
      }
    }
  }
}
