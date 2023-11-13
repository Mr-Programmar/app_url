import 'package:com.GLO365.glO365/provider/provider.dart';
import 'package:com.GLO365.glO365/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlutterBottemNavigationBar extends HookConsumerWidget {
  FlutterBottemNavigationBar({super.key});

  List<BottomNavigationBarItem> bottemButton = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.mail),
      label: 'Messages',
    ),

  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      onTap: (a) {
        print(a);
        ref.read(flutter_bottem_Provider.notifier).state = a;
      },
      currentIndex: ref.read(flutter_bottem_Provider),
      items: bottemButton,
    );
  }
}
