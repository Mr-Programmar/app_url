import 'package:com.GLO365.glO365/comman_widget/outlinetextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignIn extends StatefulHookConsumerWidget {
  const SignIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  @override
  Widget build(BuildContext context) {
    final userNameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    return Scaffold(
        body: Container(
      child: Column(children: [
        OutlineTextField(
            hintText: 'User Name', controller: userNameTextController),
        OutlineTextField(
            hintText: 'password', controller: passwordTextController),
      ]),
    ));
  }
}
