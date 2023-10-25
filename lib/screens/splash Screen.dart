import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late BuildContext _context; // Store the context

  @override
  void initState() {
    super.initState();
    _context = context; // Store the context here
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
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
