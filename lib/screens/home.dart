import 'package:com.GLO365.glO365/screens/Exit_popup.dart';
import 'package:com.GLO365.glO365/screens/enter_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';
import 'app_bar.dart';
import 'bottem_navigation_bar.dart';
import 'notification_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  static final List<Widget> _widgetOptions = <Widget>[
    const EnterUrl(),
    const Text('Search Page'),
    const Text('Profile Page'),
    const NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final webcontroller = ref.watch(webcontrollerprovider);
    final bottemNavValue = ref.watch(valueProvider);

    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        bottomNavigationBar: const BottemBar(),
        appBar: buildAppBar(context, webcontroller),
        body: _widgetOptions.elementAt(bottemNavValue),
      ),
    );
  }
}
