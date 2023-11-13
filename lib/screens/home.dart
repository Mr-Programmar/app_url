import 'package:com.GLO365.glO365/screens/Exit_popup.dart';
import 'package:com.GLO365.glO365/screens/enter_url.dart';
import 'package:com.GLO365.glO365/screens/snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';

import 'flutter_bottem_navigation_bar.dart';
import 'notification_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  static final List<Widget> _widgetOptions = <Widget>[
    const EnterUrl(),
    const NotificationsScreen(),
    const Text('Profile Page'),

  ];

  @override
  Widget build(BuildContext context) {
    final webcontroller = ref.watch(webcontrollerprovider);
    final flutterBottemNavIndex = ref.watch(flutter_bottem_Provider);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => showDialogApna(context),
        child: Scaffold(
          bottomNavigationBar: FlutterBottemNavigationBar(),

          body: _widgetOptions.elementAt(flutterBottemNavIndex),
        ),
      ),
    );
  }



  @override
  void initState() {
    final _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        print("-------------------------internet-----------------$result");

        // ref.read(webcontrollerprovider)?.reload();
        CustomSnackBar.show(context, "Welcome", color: Colors.green);
      } else {
        print("-------------------------internet-----------------$result");

        CustomSnackBar.show(context, "No Connection", color: Colors.red);
      }
    });
    super.initState();
  }
}
