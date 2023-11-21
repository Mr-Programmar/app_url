import 'package:com.GLO365.glO365/main.dart';
import 'package:com.GLO365.glO365/screens/sign_in.dart';
import 'package:com.GLO365.glO365/screens/webview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'enter_url.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {




  @override
  void initState() {

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthCheck()),
            (route) => false,
      );
    });




    super.initState();
     // Store the context here
  }











  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    super.dispose();
  }
}


class AuthCheck extends HookConsumerWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentUser = FirebaseAuth.instance.currentUser;
   final prefs=ref.watch( sharedPrefencesProvider);

    if (currentUser != null) {

      final savedUrls = prefs.getStringList('savedUrls');
      if(savedUrls==null){return Home();}
      else {
        return Webview(url: prefs.getStringList('savedUrls')?.last,);
      }
    } else {
      // User is not logged in
      return SignIn();
    }




  }
}