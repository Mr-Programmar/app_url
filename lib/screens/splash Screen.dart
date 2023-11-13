import 'package:com.GLO365.glO365/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              fit: BoxFit.fill,
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





class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // User is logged in
      return Home();
    } else {
      // User is not logged in
      return SignIn();
    }
  }





}