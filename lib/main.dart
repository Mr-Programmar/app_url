import 'dart:async';

import 'package:com.GLO365.glO365/provider/provider.dart';
import 'package:com.GLO365.glO365/screens/snackbar.dart';
import 'package:com.GLO365.glO365/screens/enter_url.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'firebase/fcm.dart';
import 'screens/home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Fcm.generateFCMDeviceToken();

  FirebaseMessaging.onBackgroundMessage(
      (message) => Fcm.listenbackgroundFCM(message));
  Fcm.listenAppFCM();
  Fcm.onOpenNotificationAction();

  //admob
  MobileAds.instance.initialize();

  //enable full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const ProviderScope(
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: Scaffold(body: MyApp()))));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _connectivity = Connectivity();

  @override
  void initState() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        print("-------------------------internet-----------------$result");

        ref.read(webcontrollerprovider)?.reload();
        CustomSnackBar.show(context, "Connection on", color: Colors.green);
      } else {
        print("-------------------------internet-----------------$result");

        CustomSnackBar.show(context, "No Connection", color: Colors.red);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final webcontroller = ref.watch(webcontrollerprovider);
    return MaterialApp(
      themeMode: ThemeMode.system,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'GLO365',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
      ),
      home: const Home(),

      // Splash(),
    );
  }
}
