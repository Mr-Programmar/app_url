import 'dart:async';

import 'package:com.GLO365.glO365/screens/enter_url.dart';
import 'package:com.GLO365.glO365/screens/splash%20Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/fcm.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final sharedPrefencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
  Fcm.generateFCMDeviceToken();

  FirebaseMessaging.onBackgroundMessage(
      (message) => Fcm.listenbackgroundFCM(message));
  Fcm.listenAppFCM();
  Fcm.onOpenNotificationAction();


  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(ProviderScope(
      overrides: [sharedPrefencesProvider.overrideWithValue(prefs)],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: Scaffold(body: MyApp()))));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Ellipse Cloude',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(


primary: Color(0xff1d2951),

            seedColor:Color(0xff1d2951),


            ),
      ),
      home:
          //
          // const EnterUrl(),

          const Splash(),

      // Splash(),
    );
  }
}
